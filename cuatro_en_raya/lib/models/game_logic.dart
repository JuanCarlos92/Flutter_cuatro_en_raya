import 'game_board.dart';

class GameLogic {
  final GameBoard board;

  GameLogic(this.board);

  bool checkWinner(int row, int col) {
    String player = board.board[row][col]!;

    // Check horizontal
    int count = 1;
    for (int i = col - 1; i >= 0 && board.board[row][i] == player; i--) {
      count++;
    }
    for (
      int i = col + 1;
      i < board.size && board.board[row][i] == player;
      i++
    ) {
      count++;
    }
    if (count >= 4) return true;

    // Check vertical
    count = 1;
    for (int i = row - 1; i >= 0 && board.board[i][col] == player; i--) {
      count++;
    }
    for (
      int i = row + 1;
      i < board.size && board.board[i][col] == player;
      i++
    ) {
      count++;
    }
    if (count >= 4) return true;

    count = 1;
    for (
      int i = 1;
      row - i >= 0 && col - i >= 0 && board.board[row - i][col - i] == player;
      i++
    ) {
      count++;
    }
    for (
      int i = 1;
      row + i < board.size &&
          col + i < board.size &&
          board.board[row + i][col + i] == player;
      i++
    ) {
      count++;
    }
    if (count >= 4) return true;

    count = 1;
    for (
      int i = 1;
      row - i >= 0 &&
          col + i < board.size &&
          board.board[row - i][col + i] == player;
      i++
    ) {
      count++;
    }
    for (
      int i = 1;
      row + i < board.size &&
          col - i >= 0 &&
          board.board[row + i][col - i] == player;
      i++
    ) {
      count++;
    }
    if (count >= 4) return true;

    return false;
  }

  void playMove(int row, int col) {
    if (!board.isValidMove(row, col)) return;

    board.makeMove(row, col);

    if (checkWinner(row, col)) {
      board.gameOver = true;
      return;
    }

    board.nextPlayer();
    if (board.isLevelComplete()) {
      board.nextLevel();
    }
  }
}
