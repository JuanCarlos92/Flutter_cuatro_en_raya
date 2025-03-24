import 'dart:convert';
import 'package:http/http.dart' as http;

class GameService {
  static const String baseUrl = 'http://localhost:8080';
  bool _isServerAvailable = false;

  // Método para verificar el estado de la conexión con el servidor
  Future<bool> checkConnection() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/health'),
        headers: {'Content-Type': 'application/json'},
      );
      _isServerAvailable = response.statusCode == 200;
      return _isServerAvailable;
    } catch (e) {
      _isServerAvailable = false;
      return false;
    }
  }

  // Método para iniciar un nuevo juego
  Future<Map<String, dynamic>> startGame(String gameName) async {
    if (!_isServerAvailable) {
      // Si no hay conexión al servidor, iniciamos el juego localmente
      return {
        'gameId': DateTime.now().millisecondsSinceEpoch.toString(),
        'game': gameName,
        'isLocal': true,
      };
    }

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/start'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'game': gameName}),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        responseData['isLocal'] = false;
        return responseData;
      } else {
        throw Exception('Error al iniciar el juego: ${response.statusCode}');
      }
    } catch (e) {
      // Si hay error de conexión, iniciamos el juego localmente
      return {
        'gameId': DateTime.now().millisecondsSinceEpoch.toString(),
        'game': gameName,
        'isLocal': true,
      };
    }
  }

  Future<List<String>> getGameModes() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/games'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((game) => game['name'] as String).toList();
      } else {
        throw Exception('Error al cargar los modos de juego');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  Future<void> startGameMode(String gameMode) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/start-game'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'gameMode': gameMode}),
      );

      if (response.statusCode != 200) {
        throw Exception('Error al iniciar el juego');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }
}
