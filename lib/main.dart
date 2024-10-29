import 'package:flutter/material.dart';
import 'interfaz/dashboard.dart';
import 'interfaz/categorias.dart';
import 'interfaz/wallpapers.dart';
import 'auth/registro.dart';
import 'auth/login.dart';
import 'auth/recuperacion.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[900], // Fondo negro grisáceo
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black, // Color del AppBar
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      home: LoginScreen(),
      routes: {
        '/dashboard': (context) => HomeScreen(),
        '/register': (context) => RegisterScreen(),
        '/categoria': (context) => CategoriesScreen(),
        '/forgot-password': (context) => ForgotPasswordScreen(),
        // '/fondos_populares': (context) => Route2Screen(),
        // '/fondos_animados': (context) => Route3Screen(),
        '/categoria/anime': (context) => WallpaperScreen('anime'),
        '/categoria/heroes': (context) => WallpaperScreen('heroes'),
        '/categoria/naturaleza': (context) => WallpaperScreen('naturaleza'),
        '/categoria/cultura': (context) => WallpaperScreen('cultura'),
        '/categoria/arte': (context) => WallpaperScreen('arte'),
        '/categoria/deportes': (context) => WallpaperScreen('deportes'),
        '/categoria/tecnologia': (context) => WallpaperScreen('tecnologia'),
        '/categoria/cine': (context) => WallpaperScreen('cine'),
      },
    );
  }
}
