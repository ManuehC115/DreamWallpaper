import 'package:flutter/material.dart';
import '../apis/pixabay.dart';
import 'wallpaper_detail.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WallpaperScreen extends StatelessWidget {
  final String query;

  WallpaperScreen(this.query);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fondos de pantalla'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple, Colors.deepPurple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Text(
                'Categorías',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            // Agrega tus categorías como ListTiles aquí
            ListTile(
              leading: Icon(Icons.emoji_people),
              title: Text('Anime'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WallpaperScreen('anime'),
                  ),
                );
              },
            ),
            // Repite esto para otras categorías
          ],
        ),
      ),
      body: FutureBuilder<List<String>>(
        future: fetchWallpapers(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SpinKitFadingCircle(
                color: Colors.purple, // Cambia el color si quieres
                size: 50.0,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final imageUrls = snapshot.data;
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              itemCount: imageUrls!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            WallpaperDetailScreen(imageUrls[index]),
                      ),
                    );
                  },
                  child: Image.network(
                    imageUrls[index],
                    fit: BoxFit.cover,
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
