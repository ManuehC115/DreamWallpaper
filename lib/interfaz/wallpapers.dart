import 'package:flutter/material.dart';
import '../apis/pixabay.dart';

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
            ListTile(
              leading: Icon(Icons.emoji_people),
              title: Text('Anime'),
              onTap: () {
                Navigator.pop(context); // Cierra el Drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WallpaperScreen('anime'),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text('Superheroes'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WallpaperScreen('superheroes'),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.landscape),
              title: Text('Naturaleza'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WallpaperScreen('naturzaleza'),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text('Cultura'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WallpaperScreen('mexico'),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.face_2),
              title: Text('Arte'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WallpaperScreen('arte'),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.sports_soccer),
              title: Text('Deportes'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WallpaperScreen('deportes'),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.computer),
              title: Text('Tecnologia'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WallpaperScreen('tecnologia'),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Cine'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WallpaperScreen('cine'),
                  ),
                );
              },
            ),
            // Puedes agregar más ListTiles aquí para otras categorías.
          ],
        ),
      ),
      body: FutureBuilder<List<String>>(
        future: fetchWallpapers(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final imageUrls = snapshot.data;
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1, // Ajusta si quieres cambiar el aspecto
              ),
              itemCount: imageUrls!.length,
              itemBuilder: (context, index) {
                return Image.network(
                  imageUrls[index],
                  fit: BoxFit.cover,
                );
              },
            );
          }
        },
      ),
    );
  }
}
