import 'package:flutter/material.dart';

class WallpaperDetailScreen extends StatelessWidget {
  final String imageUrl;

  WallpaperDetailScreen({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles del fondo de pantalla'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Implementa la funcionalidad de descarga aquí
                  },
                  icon: Icon(Icons.download),
                  label: Text('Descargar'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Implementa la funcionalidad de compartir aquí
                  },
                  icon: Icon(Icons.share),
                  label: Text('Compartir'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Implementa la funcionalidad de establecer como fondo de pantalla
                  },
                  icon: Icon(Icons.wallpaper),
                  label: Text('Establecer'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
