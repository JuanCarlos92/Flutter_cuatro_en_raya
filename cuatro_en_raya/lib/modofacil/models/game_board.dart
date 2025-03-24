class GameBoard {
  final int size; // Tamaño del tablero (por defecto 4x4)
  List<List<String?>>
  board; // Representa el tablero (puede ser 'X', 'O' o null)
  int currentPlayer; // Jugador actual (1 o 2)
  bool gameOver; // Indica si el juego ha terminado
  int currentLevel; // Nivel actual del juego (0 o 1)

  // Constructor que inicializa el tablero con un tamaño predeterminado de 4x4
  GameBoard({this.size = 4})
    // Crea un tablero vacío
    : board = List.generate(4, (i) => List.filled(4, null)),
      currentPlayer = 1, // Comienza con el jugador 1
      gameOver = false,
      currentLevel = 0; // Nivel inicial es 0

  // Reinicia el estado del juego
  void reset() {
    // Restablece el tablero
    board = List.generate(size, (i) => List.filled(size, null));
    currentPlayer = 1; // Reinicia al jugador 1
    gameOver = false;
    currentLevel = 0; // Reinicia al nivel 0
  }

  // Verifica si un movimiento en la posición (row, col) es válido
  bool isValidMove(int row, int col) {
    // No se puede jugar si el juego ha terminado y no se puede jugar en una celda ocupada
    if (gameOver) return false;
    if (board[row][col] != null) return false;

    // En el nivel 0, solo se permiten movimientos en los bordes del tablero
    if (currentLevel == 0) {
      return row == 0 || row == size - 1 || col == 0 || col == size - 1;
    } else {
      return row == 1 || row == size - 2 || col == 1 || col == size - 2;
    }
  }

  // Comprueba si se ha completado el nivel actual
  bool isLevelComplete() {
    if (currentLevel == 0) {
      // Recorre los bordes del tablero y verifica si hay alguna celda vacía
      for (int i = 0; i < size; i++) {
        // Fila superior, interior, column izq y drch
        if (board[0][i] == null ||
            board[size - 1][i] == null ||
            board[i][0] == null ||
            board[i][size - 1] == null) {
          return false;
        }
      }
    } else {
      // Recorre la segunda fila y columna desde los bordes y verifica si hay alguna celda vacía
      for (int i = 1; i < size - 1; i++) {
        // Segunda fila, penultima fila, segunda colmn y penultima colmn
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

  // Realiza un movimiento en la posición (row, col)
  void makeMove(int row, int col) {
    // Verifica si el movimiento es válido
    if (!isValidMove(row, col)) return;
    // Asigna 'X' al jugador 1 y 'O' al jugador 2
    board[row][col] = currentPlayer == 1 ? 'X' : 'O';
  }

  // Cambia al siguiente jugador
  void nextPlayer() {
    // Alterna entre los jugadores 1 y 2
    currentPlayer = currentPlayer == 1 ? 2 : 1;
  }

  // Avanza al siguiente nivel
  void nextLevel() {
    currentLevel++;
  }
}

























/*

class GameBoard {
  final int size; // Tamaño del tablero (por defecto 4x4)
  List<List<String?>> board; // Representa el tablero (puede ser 'X', 'O' o null)
  int currentPlayer; // Jugador actual (1 o 2)
  bool gameOver; // Indica si el juego ha terminado
  int currentLevel; // Nivel actual del juego (0 o 1)
  bool firstMoveDone; // Indica si el primer movimiento ya ocurrió

  // Constructor que inicializa el tablero con un tamaño predeterminado de 4x4
  GameBoard({this.size = 4})
      : board = List.generate(4, (i) => List.filled(4, null)),
        currentPlayer = 1, // Comienza con el jugador 1
        gameOver = false,
        currentLevel = 0, // Nivel inicial es 0
        firstMoveDone = false; // Aún no se ha realizado el primer movimiento

  // Reinicia el estado del juego
  void reset() {
    board = List.generate(size, (i) => List.filled(size, null));
    currentPlayer = 1;
    gameOver = false;
    currentLevel = 0;
    firstMoveDone = false; // Se restablece para que el primer movimiento esté restringido nuevamente
  }

  // Verifica si un movimiento en la posición (row, col) es válido
  bool isValidMove(int row, int col) {
    if (gameOver || board[row][col] != null) return false;

    // Si es el primer movimiento, solo se permite en los bordes
    if (!firstMoveDone) {
      return row == 0 || row == size - 1 || col == 0 || col == size - 1;
    }

    // Después del primer movimiento, se puede jugar en cualquier parte
    return true;
  }

  // Realiza un movimiento en la posición (row, col)
  void makeMove(int row, int col) {
    if (!isValidMove(row, col)) return;
    board[row][col] = currentPlayer == 1 ? 'X' : 'O';

    // Marca que el primer movimiento ya fue realizado
    firstMoveDone = true;
  }

  // Cambia al siguiente jugador
  void nextPlayer() {
    currentPlayer = currentPlayer == 1 ? 2 : 1;
  }

  // Avanza al siguiente nivel
  void nextLevel() {
    currentLevel++;
  }
}


 */