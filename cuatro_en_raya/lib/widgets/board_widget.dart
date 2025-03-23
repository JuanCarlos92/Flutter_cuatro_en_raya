import 'package:flutter/material.dart';
import '../models/game_board.dart';
import '../models/game_logic.dart';

class BoardWidget extends StatefulWidget {
  const BoardWidget({super.key});

  @override
  State<BoardWidget> createState() => _BoardWidgetState();
}

class _BoardWidgetState extends State<BoardWidget> {
  late GameBoard board;
  late GameLogic gameLogic;

  @override
  void initState() {
    super.initState();
    board = GameBoard();
    gameLogic = GameLogic(board);
  }

  void resetGame() {
    setState(() {
      board.reset();
    });
  }

  void showWinnerDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            title: Text('¡Jugador ${board.currentPlayer} ha ganado!'),
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

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Turno del Jugador ${board.currentPlayer}',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            'Nivel: ${board.currentLevel == 0 ? "Exterior" : "Interior"}',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 20),
          for (int row = 0; row < board.size; row++)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int col = 0; col < board.size; col++)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        gameLogic.playMove(row, col);
                        if (board.gameOver) {
                          showWinnerDialog();
                        }
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.all(4),
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color:
                            board.board[row][col] == null
                                ? (board.isValidMove(row, col)
                                    ? Colors.green[100]
                                    : Colors.grey[300])
                                : board.board[row][col] == 'X'
                                ? Colors.red
                                : Colors.yellow,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black, width: 1),
                      ),
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
