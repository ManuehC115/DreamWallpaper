import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  // Descargar imagen (sin implementación completa)
  Future<void> _downloadImage() async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      try {
        // Implementa tu lógica de descarga aquí
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Imagen descargada con éxito')),
        );
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al descargar la imagen: $error')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Permiso de almacenamiento denegado')),
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
                    onPressed: _downloadImage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
