import 'dart:convert';
import 'package:http/http.dart' as http;

class GameService {
  static const String baseUrl = 'http://localhost:8080';

  // Método para iniciar un nuevo juego
  Future<Map<String, dynamic>> startGame(String gameName) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/start'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'game': gameName}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Error al iniciar el juego: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }
}
