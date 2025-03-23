class GameBoard {
  final int size;
  List<List<String?>> board;
  int currentPlayer;
  bool gameOver;
  int currentLevel;

  GameBoard({this.size = 4})
    : board = List.generate(4, (i) => List.filled(4, null)),
      currentPlayer = 1,
      gameOver = false,
      currentLevel = 0;

  void reset() {
    board = List.generate(size, (i) => List.filled(size, null));
    currentPlayer = 1;
    gameOver = false;
    currentLevel = 0;
  }

  bool isValidMove(int row, int col) {
    if (gameOver) return false;
    if (board[row][col] != null) return false;

    if (currentLevel == 0) {
      return row == 0 || row == size - 1 || col == 0 || col == size - 1;
    } else {
      return row == 1 || row == size - 2 || col == 1 || col == size - 2;
    }
  }

  bool isLevelComplete() {
    if (currentLevel == 0) {
      for (int i = 0; i < size; i++) {
        if (board[0][i] == null ||
            board[size - 1][i] == null ||
            board[i][0] == null ||
            board[i][size - 1] == null) {
          return false;
        }
      }
    } else {
      for (int i = 1; i < size - 1; i++) {
        if (board[1][i] == null ||
            board[size - 2][i] == null ||
            board[i][1] == null ||
            board[i][size - 2] == null) {
          return false;
        }
      }
    }
    return true;
  }

  void makeMove(int row, int col) {
    if (!isValidMove(row, col)) return;
    board[row][col] = currentPlayer == 1 ? 'X' : 'O';
  }

  void nextPlayer() {
    currentPlayer = currentPlayer == 1 ? 2 : 1;
  }

  void nextLevel() {
    currentLevel++;
  }
}
