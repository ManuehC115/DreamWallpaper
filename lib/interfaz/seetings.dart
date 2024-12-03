import 'package:flutter/material.dart';
import 'buttom_nav.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavWrapper(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Ajustes', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.black87, // Color oscuro del AppBar
        ),
        body: Container(
          color: Colors.black87, // Fondo oscuro de la pantalla
          child: ListView(
            children: [
              ListTile(
                leading: Icon(Icons.notifications, color: Colors.white70),
                title: Text('Notificaciones',
                    style: TextStyle(color: Colors.white)),
                trailing: Switch(
                  value: true, // Cambia según la configuración real
                  activeColor: Colors.blueAccent,
                  onChanged: (value) {
                    // Acción para cambiar notificaciones
                  },
                ),
              ),
              ListTile(
                leading: Icon(Icons.lock, color: Colors.white70),
                title: Text('Cambiar contraseña',
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  // Acción para cambiar contraseña
                },
              ),
              ListTile(
                leading: Icon(Icons.language, color: Colors.white70),
                title: Text('Idioma', style: TextStyle(color: Colors.white)),
                onTap: () {
                  // Acción para cambiar idioma
                },
              ),
              Divider(color: Colors.white24), // Separador visual
              ListTile(
                leading: Icon(Icons.exit_to_app, color: Colors.redAccent),
                title: Text('Cerrar sesión',
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  // Acción para cerrar sesión
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
