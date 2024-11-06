import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:permission_handler/permission_handler.dart';

class WallpaperDetailScreen extends StatefulWidget {
  final String imageUrl;

  WallpaperDetailScreen(this.imageUrl);

  @override
  _WallpaperDetailScreenState createState() => _WallpaperDetailScreenState();
}

class _WallpaperDetailScreenState extends State<WallpaperDetailScreen> {
  double _rating = 0;
  bool isFavorite = false;

  Future<void> _downloadImage() async {
    // Solicitar permisos de almacenamiento en tiempo de ejecución
    var status = await Permission.storage.request();

    if (status.isGranted) {
      try {
        await ImageDownloader.downloadImage(widget.imageUrl);
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
    return Scaffold(
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
                    onRatingUpdate: (rating) {
                      setState(() {
                        _rating = rating;
                      });
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
                  onPressed: () {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
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
    );
  }
}
