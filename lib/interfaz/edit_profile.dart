import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; // Para trabajar con archivos de imagen
import 'buttom_nav.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? _profileImage; // Almacenar la imagen seleccionada
  final ImagePicker _picker = ImagePicker();

  // Función para seleccionar imagen desde la galería o cámara
  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path); // Actualiza la imagen de perfil
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavWrapper(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Editar Perfil'),
          backgroundColor:
              Color(0xFF424242), // Color de fondo del AppBar (gris oscuro)
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Imagen de perfil
              Center(
                child: GestureDetector(
                  onTap: () {
                    // Muestra un cuadro de diálogo para elegir entre cámara o galería
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Seleccionar fuente de la imagen'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              _pickImage(ImageSource.camera); // Tomar una foto
                              Navigator.pop(context); // Cierra el diálogo
                            },
                            child: Text('Cámara'),
                          ),
                          TextButton(
                            onPressed: () {
                              _pickImage(ImageSource
                                  .gallery); // Seleccionar de la galería
                              Navigator.pop(context); // Cierra el diálogo
                            },
                            child: Text('Galería'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: _profileImage == null
                        ? AssetImage('assets/default_profile.png')
                            as ImageProvider
                        : FileImage(_profileImage!),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Nombre o correo
              TextField(
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  hintText: 'Ingresa tu nombre',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              // Botón de guardar cambios
              ElevatedButton(
                onPressed: () {
                  // Aquí podrías guardar la imagen seleccionada, y otros cambios
                  // Ejemplo: guardar en un servidor o en la base de datos local
                  print('Imagen de perfil guardada');
                },
                child: Text('Guardar Cambios'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
