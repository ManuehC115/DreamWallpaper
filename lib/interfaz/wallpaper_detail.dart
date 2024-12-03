import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'buttom_nav.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart'; // Solo para móviles
import 'package:wallpaper/wallpaper.dart';
import 'package:http/http.dart' as http;

class WallpaperDetailScreen extends StatefulWidget {
  final String imageUrl;

  WallpaperDetailScreen(this.imageUrl);

  @override
  _WallpaperDetailScreenState createState() => _WallpaperDetailScreenState();
}

class _WallpaperDetailScreenState extends State<WallpaperDetailScreen> {
  double _rating = 0;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
    _loadRating();
  }

  // Cargar estado favorito
  Future<void> _loadFavoriteStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isFavorite = prefs.getBool('${widget.imageUrl}_favorite') ?? false;
    });
  }

  // Guardar estado favorito
  Future<void> _saveFavoriteStatus() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('${widget.imageUrl}_favorite', isFavorite);
  }

  // Cargar calificación
  Future<void> _loadRating() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _rating = prefs.getDouble('${widget.imageUrl}_rating') ?? 0;
    });
  }

  // Guardar calificación
  Future<void> _saveRating() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('${widget.imageUrl}_rating', _rating);
  }

  // Guardar imagen en la galería
  Future<void> saveImageToGallery(String imageUrl) async {
    if (Platform.isAndroid) {
      // Solicitar permisos de almacenamiento
      var status = await Permission.manageExternalStorage.request();
      if (status.isGranted) {
        // Descargar la imagen desde la URL
        final response = await http.get(Uri.parse(imageUrl));
        final bytes = response.bodyBytes;

        // Acceder al directorio de almacenamiento
        Directory? directory = await getExternalStorageDirectory();
        String newPath = "";
        List<String> paths = directory!.path.split("/");
        for (int x = 1; x < paths.length; x++) {
          String folder = paths[x];
          if (folder != "Android") {
            newPath += "/$folder";
          } else {
            break;
          }
        }
        newPath = "$newPath/Download";
        directory = Directory(newPath);
        if (!await directory.exists()) {
          await directory.create(recursive: true);
        }

        // Guardar el archivo
        String filePath =
            '${directory.path}/image_${DateTime.now().millisecondsSinceEpoch}.jpg';
        File file = File(filePath);
        await file.writeAsBytes(bytes);

        // Notificar al usuario
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Imagen guardada en $filePath')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Permiso de almacenamiento denegado')),
        );
      }
    }
  }

  Future<void> _setWallpaper(String imageUrl) async {
    try {
      // Solicitar permisos de almacenamiento (para Android 11 o superior)
      var status = await Permission.manageExternalStorage.request();
      if (!status.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Permiso de almacenamiento denegado')),
        );
        return;
      }

      // Obtener el directorio de "Download" en el almacenamiento externo
      Directory? directory = await getExternalStorageDirectory();
      String newPath = "";
      List<String> paths = directory!.path.split("/");

      for (int x = 1; x < paths.length; x++) {
        String folder = paths[x];
        if (folder != "Android") {
          newPath += "/$folder";
        } else {
          break;
        }
      }
      newPath = "$newPath/Download";
      directory = Directory(newPath);

      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      // Define el path donde se guardará la imagen descargada
      String imagePath =
          '${directory.path}/image_${DateTime.now().millisecondsSinceEpoch}.jpg';
      // Descargar la imagen desde la URL
      await Dio().download(imageUrl, imagePath);
      // Verificar que el archivo existe en la ruta esperada
      File file = File(imagePath);
      if (await file.exists()) {
        // Aplicar la imagen descargada como fondo de pantalla
        final result =
            await Wallpaper.homeScreen(); // No es necesario pasar parámetros
        if (result != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Fondo de pantalla aplicado con éxito')),
          );
        }
      } else {
        throw Exception('El archivo no se encontró en la ruta: $imagePath');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al establecer el fondo de pantalla: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Asegurarse de guardar antes de salir
        await _saveFavoriteStatus();
        await _saveRating();
        return true;
      },
      child: BottomNavWrapper(
        child: Scaffold(
          body: Stack(
            children: [
              // Imagen de fondo ocupando toda la pantalla
              Positioned.fill(
                child: Image.network(
                  widget.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              // Fondo de degradado para los botones
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Calificación con estrellas
                      Text(
                        'Calificación:',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      RatingBar.builder(
                        initialRating: _rating,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) async {
                          setState(() {
                            _rating = rating;
                          });
                          await _saveRating(); // Guardar calificación
                        },
                      ),
                      SizedBox(height: 10),
                      Text(
                        '$_rating / 5',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              // Botones de favoritos y descarga en la esquina superior derecha
              Positioned(
                top: 40,
                right: 16,
                child: Column(
                  children: [
                    IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.white,
                      ),
                      onPressed: () async {
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                        await _saveFavoriteStatus(); // Guardar estado favorito
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              isFavorite
                                  ? 'Añadido a favoritos'
                                  : 'Eliminado de favoritos',
                            ),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.download, color: Colors.white),
                      onPressed: () => saveImageToGallery(
                          widget.imageUrl), // Pasar la URL a la función
                    ),
                    // Nuevo botón para establecer como fondo de pantalla
                    IconButton(
                      icon: Icon(Icons.wallpaper, color: Colors.white),
                      onPressed: () => _setWallpaper(widget.imageUrl),
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
