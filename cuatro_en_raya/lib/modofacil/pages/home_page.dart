import 'package:cuatro_en_raya/modofacil/widgets/board_widget.dart';
import 'package:cuatro_en_raya/modofacil/widgets/header_widget.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 16, 16, 16),
      body: Column(children: <Widget>[Headerwidget(), BoardWidget()]),
    );
  }
}
