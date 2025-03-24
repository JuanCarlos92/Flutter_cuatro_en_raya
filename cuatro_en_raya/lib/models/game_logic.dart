import 'game_board.dart';

class GameLogic {
  final GameBoard board;

  GameLogic(this.board); // Referencia al tablero de juego

  // Método para verificar si un jugador ha ganado después de hacer un movimiento en (row, col)
  bool checkWinner(int row, int col) {
    // Obtiene el símbolo del jugador actual ('X' o 'O')
    String player = board.board[row][col]!;

    // Verifica horizontal
    int count = 1;
    for (int i = col - 1; i >= 0 && board.board[row][i] == player; i--) {
      count++; // Cuenta fichas hacia la izquierda
    }
    for (
      int i = col + 1;
      i < board.size && board.board[row][i] == player;
      i++
    ) {
      count++; // Cuenta fichas hacia la derecha
    }

    // Si hay 4 o más fichas seguidas, el jugador gana
    if (count >= 4) return true;

    // Verifica vertical
    count = 1;
    for (int i = row - 1; i >= 0 && board.board[i][col] == player; i--) {
      count++; // Cuenta fichas hacia arriba
    }
    for (
      int i = row + 1;
      i < board.size && board.board[i][col] == player;
      i++
    ) {
      count++; // Cuenta fichas hacia abajo
    }

    // Si hay 4 o más fichas seguidas, el jugador gana
    if (count >= 4) return true;

    // Verificar diagonal (\)
    count = 1;
    for (
      int i = 1;
      row - i >= 0 && col - i >= 0 && board.board[row - i][col - i] == player;
      i++
    ) {
      count++; // Cuenta fichas en la diagonal superior izquierda
    }
    for (
      int i = 1;
      row + i < board.size &&
          col + i < board.size &&
          board.board[row + i][col + i] == player;
      i++
    ) {
      count++; // Cuenta fichas en la diagonal inferior derecha
    }

    // Si hay 4 o más fichas seguidas, el jugador gana
    if (count >= 4) return true;

    // Verificar diagonal secundaria (/)
    count = 1;
    for (
      int i = 1;
      row - i >= 0 &&
          col + i < board.size &&
          board.board[row - i][col + i] == player;
      i++
    ) {
      count++; // Cuenta fichas en la diagonal superior derecha
    }
    for (
      int i = 1;
      row + i < board.size &&
          col - i >= 0 &&
          board.board[row + i][col - i] == player;
      i++
    ) {
      count++; // Cuenta fichas en la diagonal inferior izquierda
    }

    // Si hay 4 o más fichas seguidas, el jugador gana
    if (count >= 4) return true;

    // Si no se cumple ninguna de las condiciones, el juego sigue
    return false;
  }

  // Método para realizar un movimiento en la posición (row, col)
  void playMove(int row, int col) {
    // Verifica si el movimiento es válido
    if (!board.isValidMove(row, col)) return;

    board.makeMove(row, col); // Realiza el movimiento

    // Verifica si el jugador ha ganado después del movimiento
    if (checkWinner(row, col)) {
      board.gameOver = true;
      return;
    }

    // Cambia al siguiente jugador
    board.nextPlayer();
    // Verifica si el nivel actual se ha completado
    if (board.isLevelComplete()) {
      board.nextLevel();
    }
  }
}
