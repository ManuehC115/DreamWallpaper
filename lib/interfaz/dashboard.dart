import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isTapped = false; // Controla el estado de expansión del botón
  String _selectedRoute = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildAnimatedButton('Categoria', '/categoria'),
            SizedBox(height: 20),
            _buildAnimatedButton('Fondos populares', '/fondos_populares'),
            SizedBox(height: 20),
            _buildAnimatedButton('Fondos animados', '/fondos_animados'),
            SizedBox(height: 20),
            _buildAnimatedButton('Fondos Ultra HD', '/fondos_hd'),
            SizedBox(height: 20),
            _buildAnimatedButton('Fondos generados con IA', '/fondos_ia'),
          ],
        ),
      ),
    );
  }

  // Widget que construye cada botón animado
  Widget _buildAnimatedButton(String title, String route) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isTapped = true;
          _selectedRoute = route; // Guarda la ruta seleccionada
        });
        // Retrasa la navegación hasta que la animación termine
        Future.delayed(Duration(milliseconds: 200), () {
          Navigator.pushNamed(context, route);
          setState(() {
            _isTapped = false; // Resetea la animación después de navegar
          });
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: _isTapped && _selectedRoute == route
            ? 320
            : 300, // Expande el botón
        height: _isTapped && _selectedRoute == route
            ? 120
            : 100, // Expande la altura
        decoration: _isTapped && _selectedRoute == route
            ? BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purpleAccent, Colors.deepPurpleAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
              )
            : BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple, Colors.deepPurple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
      ),
    );
  }
}

// Define las rutas para las pantallas adicionales
class Route1Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Categoria')),
      body: Center(
        child: Text(
          'Esta es la pantalla de Categoria',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class Route2Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Fondos populares')),
      body: Center(
        child: Text(
          'Esta es la pantalla de Fondos populares',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

// Continúa agregando pantallas para las demás rutas
