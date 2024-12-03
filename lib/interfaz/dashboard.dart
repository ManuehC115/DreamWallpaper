import 'package:flutter/material.dart';
import 'buttom_nav.dart'; // Importa el componente

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isTapped = false;
  String _selectedRoute = '';

  @override
  Widget build(BuildContext context) {
    return BottomNavWrapper(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Dashboard'),
          backgroundColor: Color(0xFF424242),
        ),
        body: Center(
          // Centra el contenido en la pantalla
          child: SingleChildScrollView(
            // Desplazamiento si el contenido excede la pantalla
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment
                    .center, // Centra verticalmente los elementos
                crossAxisAlignment: CrossAxisAlignment
                    .center, // Centra horizontalmente los elementos
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
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedButton(String title, String route) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isTapped = true;
          _selectedRoute = route;
        });
        Future.delayed(Duration(milliseconds: 200), () {
          Navigator.pushNamed(context, route);
          setState(() {
            _isTapped = false;
          });
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: _isTapped && _selectedRoute == route ? 320 : 300,
        height: _isTapped && _selectedRoute == route ? 110 : 100,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _isTapped && _selectedRoute == route
                ? [Colors.purpleAccent, Colors.deepPurpleAccent]
                : [Colors.purple, Colors.deepPurple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            title,
            style:
                TextStyle(color: Colors.white, fontSize: 22), // Tamaño ajustado
          ),
        ),
      ),
    );
  }
}
