import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:CowTrack/screens/profile_screen.dart';
import 'package:CowTrack/screens/register_screen.dart';
import 'finca_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Homescreen(),
    );
  }
}

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  HomescreenState createState() => HomescreenState();
}

class HomescreenState extends State<Homescreen> {
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return LoginScreen();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();

  static void _showErrorDialog(BuildContext context, String message, bool isEmailError) {
    String title = isEmailError ? "Correo incorrecto" : "Contraseña incorrecta";
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
        );
      },
    );
  }
}

class LoginScreenState extends State<LoginScreen> {
  static Future<User?> loginUsingEmailPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        LoginScreen._showErrorDialog(context, "Correo no registrado", true);
      } else if (e.code == "wrong-password") {
        LoginScreen._showErrorDialog(context, "Verifique las credenciales", false);
      } else {
        LoginScreen._showErrorDialog(context, "Verifique las credenciales", false);
      }
    }
    return user;
  }

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<void> _loginWithCredentials(BuildContext context) async {
    User? user = await loginUsingEmailPassword(
      email: _emailController.text,
      password: _passwordController.text,
      context: context,
    );



    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => FincaScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/login.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Ganadería el Portal del Progreso",
                  style: TextStyle(
                    color: Colors.white, // Cambio del color del texto a blanco
                    fontSize: 23.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 44.0,
              ),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "CORREO",
                  prefixIcon: Icon(
                    Icons.alternate_email_sharp,
                    color: Colors.white, // Cambio del color del icono a blanco
                  ),
                ),
                style: TextStyle(color: Colors.white), // Cambio del color del texto a blanco
              ),
              const SizedBox(
                height: 26.0,
              ),
              TextField(
                controller: _passwordController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "CONTRASEÑA",
                  prefixIcon: Icon(
                    Icons.key,
                    color: Colors.white, // Cambio del color del icono a blanco
                  ),
                ),
                style: TextStyle(color: Colors.white), // Cambio del color del texto a blanco
              ),
              const SizedBox(
                height: 12.0,
              ),
              const SizedBox(
                height: 88.0,
              ),


              Container(
                width: double.infinity,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: RawMaterialButton(
                            fillColor: const Color.fromARGB(171, 44, 184, 51),
                            elevation: 0.0,
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            onPressed: () async {
                              await _loginWithCredentials(context);
                            },
                            child: const Text(
                              "Ingresar",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ),


                        const SizedBox(width: 16.0),
                        Expanded(
                          child: RawMaterialButton(
                            fillColor: const Color.fromARGB(171, 44, 184, 51),
                            elevation: 0.0,
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => RegisterScreen()),
                              );
                            },
                            child: const Text(
                              "Registrarme",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    TextButton(
                      onPressed: () {
                        // Lógica del botón Olvidé mi contraseña
                      },
                      child: const Text(
                        "Olvidé mi contraseña",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
