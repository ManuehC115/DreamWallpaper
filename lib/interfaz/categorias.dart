import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[900], // Fondo negro grisáceo
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black, // Color del AppBar
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      home: CategoriesScreen(),
      // routes: {
      //   '/category1': (context) => CategoryScreen('Categoría 1'),
      //   '/category2': (context) => CategoryScreen('Categoría 2'),
      //   '/category3': (context) => CategoryScreen('Categoría 3'),
      //   '/category4': (context) => CategoryScreen('Categoría 4'),
      //   '/category5': (context) => CategoryScreen('Categoría 5'),
      //   '/category6': (context) => CategoryScreen('Categoría 6'),
      //   '/category7': (context) => CategoryScreen('Categoría 7'),
      //   '/category8': (context) => CategoryScreen('Categoría 8'),
      // },
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Categorías'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Dos columnas
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 2, // Relación de aspecto
          ),
          itemCount: categoryNames.length, // Cambiado a la longitud del arreglo
          //routeCount: categoryroutes.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, categoryroutes[index]);
              },
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
            );
          },
        ),
      ),
    );
  }
}

// Pantallas de categorías individuales
class CategoryScreen extends StatelessWidget {
  final String title;

  CategoryScreen(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(
          'Esta es la pantalla de $title',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
