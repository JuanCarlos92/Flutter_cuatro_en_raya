import 'package:flutter/material.dart';

class Headerwidget extends StatelessWidget {
  const Headerwidget({super.key});

  // Estilo de texto para el título: color blanco, negrita, tamaño de fuente 26
  final tituloTextStyle = const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 26,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(25),
      height: 120,
      decoration: BoxDecoration(color: Color.fromARGB(255, 41, 40, 39)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text("4 en raya", style: tituloTextStyle)],
          ),
        ],
      ),
    );
  }
}
