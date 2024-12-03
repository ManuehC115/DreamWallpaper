import 'package:flutter/material.dart';

class BottomNavWrapper extends StatefulWidget {
  final Widget child; // Pantalla que se muestra dentro del scaffold
  BottomNavWrapper({required this.child});

  @override
  _BottomNavWrapperState createState() => _BottomNavWrapperState();
}

class _BottomNavWrapperState extends State<BottomNavWrapper> {
  int _currentIndex = 0;

  final List<String> _routes = [
    '/dashboard', // Ruta para la pantalla principal (dashboard)
    '/profile',
    '/settings',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child, // Contenido de la pantalla actual
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          Navigator.pushReplacementNamed(
              context, _routes[index]); // Navega entre pantallas
        },
        backgroundColor: Color(0xFF424242), // Gris oscuro
        selectedItemColor: Colors.white, // Color del ítem seleccionado
        unselectedItemColor:
            Colors.grey[400], // Gris más claro para ítems no seleccionados
        // Color de los íconos no seleccionados
        showSelectedLabels: true, // Muestra etiquetas seleccionadas
        showUnselectedLabels: true, // Muestra etiquetas no seleccionadas
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Ajustes',
          ),
        ],
      ),
    );
  }
}
