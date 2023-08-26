  import 'package:flutter/material.dart';
  import 'package:carousel_slider/carousel_slider.dart';
  import 'package:CowTrack/screens/contactos_screen.dart';
  import 'package:CowTrack/screens/profile_screen.dart';
  import 'login_screen.dart';
  import 'package:url_launcher/url_launcher.dart';
  
  class FincaScreen extends StatelessWidget {
    // Lista de imágenes para el carrusel
    List<String> carouselImages = [
      'assets/images/becerro.jpg',
      'assets/images/pasto.jpg',
      'assets/images/vaca.jpg',
      'assets/images/potrero.jpg',
    ];
  
    void _openGoogleMaps() async {
      const url =
          'https://goo.gl/maps/y9UpAm1D7MbKREbh7';

      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'No se puede abrir Google Maps: $url';
      }
    }
  //CODIGO DE APPBAR
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue[200],
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/icons/fondoemprender.png',
                width: 90,
                height: 90,
              ),
              Spacer(),
              Text(
                'Nuestro Proyecto',
                style: TextStyle(
                  color: Colors.black,
                  fontStyle: FontStyle.italic,
                ),
              ),
              Spacer(),
              Image.asset(
                'assets/icons/sena.png',
                width: 60,
                height: 60,
              ),
            ],
          ),
        ),
        //FIN APPBAR
  
  
        //CUERPO DE LA VISTA
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Image.asset(
                  'assets/images/lina.jpg',
                  width: 400,
                  height: 400,
                ),
              ),
              Text(
                '¿Qué es Fondo Emprender?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10), // Espaciado entre el título y el texto
              Text(
                'Iniciativas emprendedoras que reciben '
                    'apoyo financiero y técnico del Gobierno Nacional'
                    ' a través del Servicio Nacional de Aprendizaje (SENA).'
                    ' Fondo Emprender es una estrategia'
                    ' que busca fomentar el emprendimiento y generar empleo'
                    ' en el país, brindando recursos económicos y asesoría'
                    ' a emprendedores que tengan ideas innovadoras y sostenibles.',
                textAlign: TextAlign.center, // Alineación del texto
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20), // Espaciado entre el texto y el carrusel
              // Carrusel utilizando carousel_slider
              CarouselSlider(
                options: CarouselOptions( // Aquí configuramos las opciones del carrusel
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  enlargeCenterPage: true,
                ),
                items: carouselImages.map((imagePath) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Image.asset(
                        imagePath,
                        width: 400,
                        height: 400,
                        fit: BoxFit.cover,
                      );
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 40), // Espaciado entre el carrusel y el texto
              Text(
                'Ganadería el Portal del Progreso',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20), // Espaciado entre el título y el texto
                  Text(
                    'Proyecto de Emprendimiento Familiar, que se centra en '
                        'la producción de leche y terneros, para venta y uso de la leche '
                        'en producción de sus derivados como Queso, Kumis y Yogurth.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
  
  
                  Padding(
                    padding: const EdgeInsets.only(top: 0.0),
                    child: Image.asset(
                      'assets/images/proyecto.jpg',
                      width: 400,
                      height: 400,
                    ),
                  ),
                  SizedBox(height: 1.0), // Espaciado entre la imagen y las opciones
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Espacio igual entre las imágenes
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  ProfileScreen()),
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.yellow, // Cambia este color al que desees
                              ),
                              child: Image.asset(
                                'assets/images/inventario.jpg', // Ruta de la imagen 1
                                width: 50,
                                height: 50,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'INVENTARIO',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),


                      GestureDetector(
                        onTap: () async {
                          const url = 'https://goo.gl/maps/y9UpAm1D7MbKREbh7';
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'No se pudo abrir $url';
                          }
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.redAccent, // Cambia este color al que desees
                              ),
                              child: Image.asset(
                                'assets/images/ubicacion.png', // Ruta de la imagen 3
                                width: 50,
                                height: 50,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'UBICACIÓN',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
  
  
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  ContactosScreen()),
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue, // Cambia este color al que desees
                              ),
                              child: Image.asset(
                                'assets/images/contacto.jpg', // Ruta de la imagen 2
                                width: 50,
                                height: 50,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'CONTACTOS',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
  
  
                  SizedBox(height: 40),
                  Text(
                    'Derechos Reservados Yuderly Sapuy Chavarro ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'SENA-Servicio Nacional De Aprendizaje',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'CEFA-La Angostura',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
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
