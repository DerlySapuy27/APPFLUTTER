import 'package:flutter/material.dart';

class ProduccionScreen extends StatefulWidget {
  const ProduccionScreen({Key? key}) : super(key: key);

  @override
  _ProduccionScreenState createState() => _ProduccionScreenState();
}

class _ProduccionScreenState extends State<ProduccionScreen> {
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
        title: Text('Detalles de Semovientes'),
        backgroundColor: Colors.lightBlue[200],
      ),
      body: Center(
        child: Text('Contenido de la pantalla Produccion'),
      ),
    );
  }
}
