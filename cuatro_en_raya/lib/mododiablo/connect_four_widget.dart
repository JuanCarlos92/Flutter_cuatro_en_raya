import 'package:flutter/material.dart';

class ConnectFourWidget extends StatefulWidget {
  const ConnectFourWidget({super.key});

  @override
  State<ConnectFourWidget> createState() => _ConnectFourWidgetState();
}

class _ConnectFourWidgetState extends State<ConnectFourWidget> {
  List<List<String?>> board = List.generate(6, (_) => List.filled(7, null));
  String currentPlayer = 'X';
  bool gameOver = false;

  void resetGame() {
    setState(() {
      board = List.generate(6, (_) => List.filled(7, null));
      currentPlayer = 'X';
      gameOver = false;
    });
  }

  void showWinnerDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            title: Text(
              '¡Jugador ${currentPlayer == 'X' ? 'O' : 'X'} ha ganado!',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  resetGame();
                },
                child: Text('Jugar de nuevo'),
              ),
            ],
          ),
    );
  }

  bool isValidMove(int col) {
    return !gameOver && board[0][col] == null;
  }

  void playMove(int col) {
    if (!isValidMove(col)) return;

    for (int row = 5; row >= 0; row--) {
      if (board[row][col] == null) {
        setState(() {
          board[row][col] = currentPlayer;
          if (checkWinner(row, col)) {
            gameOver = true;
            showWinnerDialog();
          } else {
            currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
          }
        });
        break;
      }
    }
  }

  bool checkWinner(int row, int col) {
    final directions = [
      [
        [0, 1],
        [0, -1],
      ], // horizontal
      [
        [1, 0],
        [-1, 0],
      ], // vertical
      [
        [1, 1],
        [-1, -1],
      ], // diagonal
      [
        [1, -1],
        [-1, 1],
      ], // diagonal
    ];

    for (var direction in directions) {
      int count = 1;
      for (var [dx, dy] in direction) {
        int r = row + dx;
        int c = col + dy;
        while (r >= 0 &&
            r < 6 &&
            c >= 0 &&
            c < 7 &&
            board[r][c] == currentPlayer) {
          count++;
          r += dx;
          c += dy;
        }
      }
      if (count >= 4) return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Turno del Jugador $currentPlayer',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 20),
          for (int row = 0; row < 6; row++)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int col = 0; col < 7; col++)
                  GestureDetector(
                    onTap: () => playMove(col),
                    child: Container(
                      margin: EdgeInsets.all(4),
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color:
                            board[row][col] == null
                                ? Colors.grey[300]
                                : board[row][col] == 'X'
                                ? Colors.red
                                : Colors.yellow,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Colors.black, width: 1),
                      ),
                    ),
                  ),
              ],
            ),
          FloatingActionButton(
            onPressed: resetGame,
            child: Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}
