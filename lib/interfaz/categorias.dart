import 'package:flutter/material.dart';
import 'buttom_nav.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF424242), // Fondo negro grisáceo
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF424242), // Color del AppBar
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      home: CategoriesScreen(),
      routes: {
        '/categoria/anime': (context) => CategoryScreen('Anime'),
        '/categoria/heroes': (context) => CategoryScreen('Superheroes'),
        '/categoria/naturaleza': (context) => CategoryScreen('Naturaleza'),
        '/categoria/cultura': (context) => CategoryScreen('Cultura'),
        '/categoria/arte': (context) => CategoryScreen('Arte'),
        '/categoria/deportes': (context) => CategoryScreen('Deportes'),
        '/categoria/tecnologia': (context) => CategoryScreen('Tecnología'),
        '/categoria/cine': (context) => CategoryScreen('Cine'),
      },
    );
  }
}

class CategoriesScreen extends StatelessWidget {
  // Arreglo con los nombres de las categorías
  final List<String> categoryNames = [
    'Anime',
    'Superheroes',
    'Naturaleza',
    'Cultura',
    'Arte',
    'Deportes',
    'Tecnologia',
    'Cine',
  ];

  final List<String> categoryroutes = [
    '/categoria/anime',
    '/categoria/heroes',
    '/categoria/naturaleza',
    '/categoria/cultura',
    '/categoria/arte',
    '/categoria/deportes',
    '/categoria/tecnologia',
    '/categoria/cine',
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavWrapper(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Categorías'),
          backgroundColor:
              Color(0xFF424242), // Color de fondo del AppBar (gris oscuro)
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Dos columnas
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.5, // Ajustado para mejorar la visualización
            ),
            itemCount:
                categoryNames.length, // Cambiado a la longitud del arreglo
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // Navegar a la pantalla de la categoría correspondiente
                  Navigator.pushNamed(context, categoryroutes[index]);
                },
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.purple, Colors.deepPurple],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        categoryNames[index], // Usa el nombre del arreglo
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class CategoryScreen extends StatelessWidget {
  final String title;

  CategoryScreen(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Color(0xFF424242),
      ),
      body: Center(
        child: Text(
          'Esta es la pantalla de $title',
          style: TextStyle(fontSize: 20, color: Colors.red),
        ),
      ),
    );
  }
}
