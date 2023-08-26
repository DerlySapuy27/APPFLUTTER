import 'package:CowTrack/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart' as pathh;
import 'contactos_screen.dart';
import 'finca_screen.dart';
import 'login_screen.dart';

class Semoviente {
  final int id;
  final String imageUrl;
  String description;

  Semoviente({
    required this.id,
    required this.imageUrl,
    required this.description,
  });
}

class DatabaseHelper {
  late Database _database;

  Future<void> initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = pathh.join(documentsDirectory.path, 'semovientes.db');
    print('Database path: $path'); // Agrega este print para verificar la ruta de la base de datos
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
        CREATE TABLE semovientes (
          id INTEGER PRIMARY KEY,
          imageUrl TEXT,
          description TEXT
        )
      ''');
      },
    );
  }


  Future<List<Semoviente>> getAllSemovientes() async {
    List<Map<String, dynamic>> maps = await _database.query('semovientes');
    return List.generate(maps.length, (index) {
      return Semoviente(
        id: maps[index]['id'],
        imageUrl: maps[index]['imageUrl'],
        description: maps[index]['description'],
      );
    });
  }

  Future<void> insertSemoviente(String imageUrl, String description) async {
    await _database.insert('semovientes', {
      'imageUrl': imageUrl,
      'description': description,
    });
  }

  Future<void> updateSemoviente(int id, String imageUrl, String description) async {
    await _database.update(
      'semovientes',
      {'imageUrl': imageUrl, 'description': description},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteSemoviente(int id) async {
    await _database.delete(
      'semovientes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

class SemovienteScreen extends StatefulWidget {
  @override
  _SemovienteScreenState createState() => _SemovienteScreenState();
}

class _SemovienteScreenState extends State<SemovienteScreen> {
  late DatabaseHelper _dbHelper;
  List<Semoviente> _semovientes = [];
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController imageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dbHelper = DatabaseHelper();
    _dbHelper.initDatabase();
    _loadSemovientes();
  }

  Future<void> _loadSemovientes() async {
    final semovientes = await _dbHelper.getAllSemovientes();
    setState(() {
      _semovientes = semovientes;
    });
  }

  Future<String> saveImage(File imagefile) async {
    final directory = await getApplicationCacheDirectory();
    final filename = DateTime.now().microsecondsSinceEpoch.toString();
    final imagepath = "${directory.path}/$filename.jpg";

    await imagefile.copy(imagepath);
    return imagepath;
  }

  Future<void> image() async {
    final ImagePicker image = ImagePicker();
    final XFile? pickedImage = await image.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      String imageurl = await saveImage(File(pickedImage.path));
      imageController.text = imageurl;
    }
  }

  //DIALOGO DE AGREGAR REGISTRO
  void _showAddDialog() {
    _descriptionController.text = ''; // Limpiar el campo de descripción
    imageController.clear(); // Limpiar el campo de imagen
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                'Agregar Registro',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 16),
                  Text(
                    'Descripción:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      hintText: 'Ingrese la descripción',
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                    ),
                    child: Text("Seleccionar Imagen"),
                    onPressed: () async {
                      await image();
                      setState(() {}); // Actualizar la vista previa de la imagen
                    },
                  ),
                  SizedBox(height: 16),
                  // Mostrar vista previa de la imagen y descripción
                  if (imageController.text.isNotEmpty)
                    Column(
                      children: [
                        Image.file(
                          File(imageController.text),
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 8),
                        Text(_descriptionController.text),
                      ],
                    ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),
                    child: Text("Guardar"),
                    onPressed: () async {
                      String imageUrl = imageController.text;
                      String description = _descriptionController.text;
                      await _dbHelper.insertSemoviente(imageUrl, description);
                      _loadSemovientes();
                      Navigator.pop(context);

                      // Mostrar un AlertDialog de Registro Exitoso
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              "Registro Exitoso",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.check_circle_outline,
                                  color: Colors.green,
                                  size: 48,
                                ),
                                SizedBox(height: 16),
                                Text(
                                  "El registro se ha guardado exitosamente.",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            actions: [
                              Align(
                                alignment: Alignment.center,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.green,
                                  ),
                                  child: Text(
                                    "Aceptar",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );

                      // Esperar 2 segundos y cerrar el AlertDialog
                      await Future.delayed(Duration(seconds: 2));
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }




//DIALOGO DE EDICION DE REGISTRO
  void _showEditDialog(Semoviente semoviente) {
    _descriptionController.text = semoviente.description;
    imageController.text = semoviente.imageUrl;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Editar Registro',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 16),
              Text(
                'Editar Descripción:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  hintText: 'Ingrese la nueva descripción',
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                ),
                child: Text("Seleccionar Nueva Imagen"),
                onPressed: () async {
                  await image(); // Llama al método para seleccionar imagen
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                ),
                child: Text("Guardar Cambios"),
                onPressed: () async {
                  String imageUrl = imageController.text;
                  String description = _descriptionController.text;
                  await _dbHelper.updateSemoviente(semoviente.id, imageUrl, description);
                  _loadSemovientes();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

//DIALOGO DE CONFIRMACION DE ELIMINAR REGISTRO
  void _confirmDeleteSemoviente(Semoviente semoviente) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Confirmar eliminación',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          content: Text(
            '¿Estás seguro de que quieres eliminar este Registro?',
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              child: Text(
                'Cancelar',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Eliminar',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _deleteSemoviente(semoviente); // Llamada sin await
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteSemoviente(Semoviente semoviente) async {
    await _dbHelper.deleteSemoviente(semoviente.id);
    _loadSemovientes();
  }


  //CODIGO DE APPBAR
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[200],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_outlined,
            color: Colors.black,
            size: 28,
          ),
          onPressed: () {
            Navigator.of(context).pop(); // Navegar hacia atrás
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Inventario de Ovinos',
              style: TextStyle(
                color: Colors.black,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(width: 10), // Agrega un espacio horizontal entre el texto y la imagen
            Image.asset(
              'assets/icons/fondoemprender.png',
              width: 80,
              height: 80,
            ),
          ],
        ),
      ),



      //FIN DEL APPBAR

      //TARGETA DE LOS REGISTROS
      body: ListView.builder(
        itemCount: _semovientes.length,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              children: [
                SizedBox(
                  height: 200, // Ajusta esta altura según lo necesario
                  child: Image.file(
                    File(_semovientes[index].imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(_semovientes[index].description),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        _showEditDialog(_semovientes[index]);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _confirmDeleteSemoviente(_semovientes[index]);
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),

      //BOTON DE AGREGAR REGISTRO
      floatingActionButton: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
          child: GestureDetector(
            onTap: _showAddDialog,
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add), // Icono de agregar
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      //FIN BOTON AGREGAR NUEVO REGISTRO

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

void main() {
  runApp(MaterialApp(
    home: SemovienteScreen(),
  ));
}
