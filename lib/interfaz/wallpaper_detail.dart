import 'package:flutter/material.dart';

class WallpaperDetailScreen extends StatefulWidget {
  final String imageUrl;

  WallpaperDetailScreen(this.imageUrl);

  @override
  _WallpaperDetailScreenState createState() => _WallpaperDetailScreenState();
}

class _WallpaperDetailScreenState extends State<WallpaperDetailScreen> {
  double _rating = 0; // Valor inicial de la clasificación

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
              widget.imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Calificación:',
                  style: TextStyle(fontSize: 20),
                ),
                Slider(
                  value: _rating,
                  onChanged: (newRating) {
                    setState(() {
                      _rating = newRating;
                    });
                  },
                  min: 0,
                  max: 5,
                  divisions: 5,
                  label: _rating.toString(),
                ),
                Text(
                  '$_rating / 5',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
