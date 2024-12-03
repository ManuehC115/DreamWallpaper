import 'package:flutter/material.dart';
import '../apis/pixabay.dart';
import 'wallpaper_detail.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'buttom_nav.dart';

class WallpaperScreen extends StatelessWidget {
  final String query;

  WallpaperScreen(this.query);

  @override
  Widget build(BuildContext context) {
    return BottomNavWrapper(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Fondos de pantalla :)'),
          backgroundColor:
              Color(0xFF424242), // Color de fondo del AppBar (gris oscuro)
          iconTheme: IconThemeData(color: Colors.white),
        ), // Color de fondo del AppBar (gris oscuro)
        drawer: _buildDrawer(context),
        body: _buildWallpaperGrid(query),
      ),
    );
  }

  /// Construye el Drawer con las categorías
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.45,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _buildDrawerHeader(),
          _buildCategoryListTile(
            context,
            icon: Icons.house,
            title: 'Inicio',
            route: '/dashboard',
          ),
          _buildCategoryListTile(
            context,
            icon: Icons.emoji_people,
            title: 'Anime',
            route: '/categoria/anime',
          ),
          _buildCategoryListTile(
            context,
            icon: Icons.shield,
            title: 'Héroes',
            route: '/categoria/heroes',
          ),
          _buildCategoryListTile(
            context,
            icon: Icons.nature,
            title: 'Naturaleza',
            route: '/categoria/naturaleza',
          ),
          _buildCategoryListTile(
            context,
            icon: Icons.account_balance,
            title: 'Cultura',
            route: '/categoria/cultura',
          ),
          _buildCategoryListTile(
            context,
            icon: Icons.palette,
            title: 'Arte',
            route: '/categoria/arte',
          ),
          _buildCategoryListTile(
            context,
            icon: Icons.sports_soccer,
            title: 'Deportes',
            route: '/categoria/deportes',
          ),
          _buildCategoryListTile(
            context,
            icon: Icons.computer,
            title: 'Tecnología',
            route: '/categoria/tecnologia',
          ),
          _buildCategoryListTile(
            context,
            icon: Icons.movie,
            title: 'Cine',
            route: '/categoria/cine',
          ),
          _buildCategoryListTile(
            context,
            icon: Icons.movie,
            title: 'Pendiente',
            route: '/categoria/cine',
          ),
        ],
      ),
    );
  }

  /// Construye el encabezado del Drawer
  Widget _buildDrawerHeader() {
    return DrawerHeader(
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
    );
  }

  /// Construye un ListTile para cada categoría
  Widget _buildCategoryListTile(BuildContext context,
      {required IconData icon, required String title, required String route}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, route);
      },
    );
  }

  /// Construye el GridView de los fondos de pantalla
  Widget _buildWallpaperGrid(String query) {
    return FutureBuilder<List<String>>(
      future: fetchWallpapers(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingIndicator();
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error.toString());
        } else {
          return _buildImageGrid(snapshot.data ?? []);
        }
      },
    );
  }

  /// Indicador de carga mientras se obtienen los datos
  Widget _buildLoadingIndicator() {
    return Center(
      child: SpinKitFadingCircle(
        color: Colors.purple,
        size: 50.0,
      ),
    );
  }

  /// Widget para mostrar errores
  Widget _buildErrorWidget(String error) {
    return Center(
      child: Text(
        'Error: $error',
        style: TextStyle(color: Colors.red, fontSize: 16),
      ),
    );
  }

  /// Construye el GridView con las imágenes
  Widget _buildImageGrid(List<String> imageUrls) {
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1,
      ),
      itemCount: imageUrls.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WallpaperDetailScreen(imageUrls[index]),
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
}
