import 'package:CowTrack/screens/produccion_screen.dart';
import 'package:CowTrack/screens/terreno_screen.dart';
import 'package:flutter/material.dart';
import 'package:CowTrack/screens/contactos_screen.dart';
import 'finca_screen.dart';
import 'login_screen.dart';
import 'maquinaria_screen.dart';
import 'semoviente_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '¿Qué tenemos en Nuestro Proyecto?',
          style: TextStyle(
            color: Colors.black,
            fontStyle: FontStyle.italic,
          ),
        ),
        backgroundColor: Colors.lightBlue[200],
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(16.0),
        children: [

          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SemovienteScreen()),
              );
            },
            child: buildCard('assets/images/semoviente.png', 'Semovientes'),
          ),

          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MaquinariaScreen()), // Navegación a SemovienteScreen
              );
            },
            child: buildCard('assets/images/tractor.png', 'Maquinaria'),
          ),

          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TerrenoScreen()), // Navegación a SemovienteScreen
              );
            },
            child: buildCard('assets/images/terreno.png', 'Terreno'),
          ),

          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProduccionScreen()), // Navegación a SemovienteScreen
              );
            },
            child: buildCard('assets/images/produccion.png', 'Producción'),
          ),
        ],
      ),

      //INICIO TOPBAR
      bottomNavigationBar: BottomAppBar(
        color: Colors.lightBlue[200],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.menu_outlined),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FincaScreen()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.contact_phone_rounded),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactosScreen()),
                );
              },
            ),
            // Icono para salir de la APP
            IconButton(
              icon: Icon(Icons.exit_to_app, color: Colors.black),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Confirmación"),
                      content: Text("¿Estás seguro de salir de la aplicación?"),
                      actions: <Widget>[
                        TextButton(
                          child: Text("Cancelar"),
                          onPressed: () {
                            Navigator.of(context).pop(); // Cerrar el cuadro de diálogo
                          },
                        ),
                        TextButton(
                          child: Text("Salir"),
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => LoginScreen()),
                                  (Route<dynamic> route) => false,
                            );
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      //FIN TOPBAR
    );
  }



  Widget buildCard(String imagePath, String description) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              description,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }
}
