import 'package:flutter/material.dart';

class TerrenoScreen extends StatefulWidget {
  const TerrenoScreen({Key? key}) : super(key: key);

  @override
  _TerrenoScreenState createState() => _TerrenoScreenState();
}

class _TerrenoScreenState extends State<TerrenoScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de Terreno'),
        backgroundColor: Colors.lightBlue[200],
      ),
      body: Center(
        child: Text('Contenido de la pantalla de Terreno'),
      ),
    );
  }
}
