import 'package:CowTrack/screens/profile_screen.dart';
import 'package:flutter/material.dart';


import 'finca_screen.dart';
import 'login_screen.dart';

class ContactosScreen extends StatefulWidget {

  @override
  _ContactosScreenState createState() => _ContactosScreenState();
}



class _ContactosScreenState extends State<ContactosScreen> {
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
        backgroundColor: Colors.lightBlue[200],
        title: Text('Contactos'),
      ),



      body: Center(
        child: Text(
          'Bienvenido a la pantalla de contactos',
          style: TextStyle(fontSize: 24),
        ),
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
}
