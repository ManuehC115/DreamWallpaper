import 'package:flutter/material.dart';
import 'buttom_nav.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavWrapper(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Perfil', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.black87, // Fondo oscuro del AppBar
        ),
        body: Container(
          color: Colors.black87, // Fondo de la pantalla
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person,
                    size: 100, color: Colors.white70), // Icono de perfil
                SizedBox(height: 20),
                Text(
                  'Nombre del Usuario',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
                SizedBox(height: 10),
                Text(
                  'correo@ejemplo.com',
                  style: TextStyle(fontSize: 18, color: Colors.white60),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800], // Color del botón
                    foregroundColor: Colors.white, // Color del texto del botón
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/edit_profile');
                  },
                  child: Text('Editar Perfil'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
