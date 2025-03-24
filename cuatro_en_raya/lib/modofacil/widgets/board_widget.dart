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

  // Muestra un cuadro de diálogo cuando un jugador gana
  void showWinnerDialog() {
    showDialog(
      context: context,
      // Evita que se cierre al tocar fuera del diálogo
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            title: Text('¡Jugador ${board.currentPlayer} ha ganado!'),
            actions: [
              TextButton(
                onPressed: () {
                  // Cierra el cuadro de diálogo
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
        // Centra el contenido verticalmente
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Muestra el turno del jugador actual
          Text(
            'Turno del Jugador ${board.currentPlayer}',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          // Muestra el nivel actual del juego
          Text(
            'Nivel: ${board.currentLevel == 0 ? "Exterior" : "Interior"}',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 20),
          // Genera las filas del tablero de juego
          for (int row = 0; row < board.size; row++)
            Row(
              // Centra las filas horizontalmente
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Genera las celdas del tablero
                for (int col = 0; col < board.size; col++)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        // Realiza el movimiento en la celda seleccionada
                        gameLogic.playMove(row, col);
                        if (board.gameOver) {
                          showWinnerDialog();
                        }
                      });
                    },
                    child: Container(
                      // Margen entre las celdas
                      margin: EdgeInsets.all(4),
                      width: 60, // Ancho de la celda
                      height: 60, // Alto de la celda
                      decoration: BoxDecoration(
                        color:
                            board.board[row][col] == null
                                ? (board.isValidMove(row, col)
                                    ? Colors
                                        .green[100] // Si la celda es válida, color verde claro
                                    : Colors
                                        .grey[300]) // Si no es válida, color gris claro
                                : board.board[row][col] == 'X'
                                ? Colors.red
                                : Colors.yellow,
                        // Bordes redondeados
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
