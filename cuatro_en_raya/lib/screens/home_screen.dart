import 'package:flutter/material.dart';
import '../modofacil/widgets/board_widget.dart';
import '../mododiablo/connect_four_widget.dart';
import '../modonormal/juego_normal.dart';
import '../services/game_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GameService _gameService = GameService();
  List<String> gameModes = [];
  bool isLoading = true;
  bool isOffline = false;

  @override
  void initState() {
    super.initState();
    _initializeGameModes();
  }

  Future<void> _initializeGameModes() async {
    try {
      final isConnected = await _gameService.checkConnection();
      setState(() {
        isOffline = !isConnected;
      });

      final modes = await _gameService.getGameModes();
      setState(() {
        gameModes = modes;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        gameModes = _gameService.getLocalGameModes();
        isLoading = false;
        isOffline = true;
      });
    }
  }

  void _navigateToGame(String gameMode) {
    Widget gameWidget;
    String title;

    switch (gameMode.toLowerCase()) {
      case 'fácil':
        gameWidget = const BoardWidget();
        title = 'MODO FÁCIL';
        break;
      case 'normal':
        gameWidget = JuegoNormal(gameId: 'normal', gameName: 'MODO NORMAL');
        title = 'MODO NORMAL';
        break;
      case 'diablo':
        gameWidget = const ConnectFourWidget();
        title = 'MODO DIABLO';
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Modo de juego no válido')),
        );
        return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GameScreen(title: title, gameWidget: gameWidget),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue[900]!, Colors.blue[600]!],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                const Text(
                  '4 EN RAYA',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        offset: Offset(2, 2),
                        blurRadius: 4,
                        color: Colors.black26,
                      ),
                    ],
                  ),
                ),
                if (isOffline)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Modo offline',
                      style: TextStyle(color: Colors.orange[300], fontSize: 16),
                    ),
                  ),
                const SizedBox(height: 40),
                const Text(
                  'Selecciona el modo de juego',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
                const SizedBox(height: 40),
                if (isLoading)
                  const CircularProgressIndicator(color: Colors.white)
                else
                  ...gameModes.map(
                    (mode) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: _buildGameModeButton(
                        context,
                        'MODO ${mode.toUpperCase()}',
                        '4 en Raya ${mode == 'diablo'
                            ? 'Clásico'
                            : mode == 'normal'
                            ? 'modo 3 en Raya'
                            : 'Interior'}',
                        _getIconForMode(mode),
                        _getColorForMode(mode),
                        () => _navigateToGame(mode),
                      ),
                    ),
                  ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _getIconForMode(String mode) {
    switch (mode.toLowerCase()) {
      case 'fácil':
        return Icons.star;
      case 'normal':
        return Icons.extension;
      case 'diablo':
        return Icons.whatshot;
      default:
        return Icons.games;
    }
  }

  Color _getColorForMode(String mode) {
    switch (mode.toLowerCase()) {
      case 'fácil':
        return Colors.green;
      case 'normal':
        return Colors.orange;
      case 'diablo':
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  Widget _buildGameModeButton(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: color,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 5,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30),
            const SizedBox(width: 10),
            Column(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 14, color: color.withOpacity(0.8)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class GameScreen extends StatelessWidget {
  final String title;
  final Widget gameWidget;

  const GameScreen({super.key, required this.title, required this.gameWidget});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue[900]!, Colors.blue[600]!],
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                  minWidth: constraints.maxWidth,
                ),
                child: IntrinsicHeight(child: gameWidget),
              ),
            );
          },
        ),
      ),
    );
  }
}
