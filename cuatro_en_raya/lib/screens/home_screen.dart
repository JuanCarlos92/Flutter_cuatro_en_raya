import 'package:flutter/material.dart';
import '../modofacil/widgets/board_widget.dart';
import '../mododiablo/connect_four_widget.dart';
import '../modonormal/juego_normal.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
              const SizedBox(height: 60),
              const Text(
                'Selecciona el modo de juego',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              const SizedBox(height: 40),
              _buildGameModeButton(
                context,
                'MODO FÁCIL',
                '4 en Raya Interior',
                Icons.star,
                Colors.green,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => GameScreen(
                          title: 'MODO FÁCIL',
                          gameWidget: const BoardWidget(),
                        ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildGameModeButton(
                context,
                'MODO NORMAL',
                '4 en Raya Clásico',
                Icons.extension,
                Colors.orange,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => JuegoNormal(
                          gameId: 'normal',
                          gameName: 'MODO NORMAL',
                        ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildGameModeButton(
                context,
                'MODO DIABLO',
                '4 en Raya Clásico',
                Icons.whatshot,
                Colors.red,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => GameScreen(
                          title: 'MODO DIABLO',
                          gameWidget: const ConnectFourWidget(),
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
        child: gameWidget,
      ),
    );
  }
}
