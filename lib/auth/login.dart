import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Definimos el fondo con un gradiente
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color.fromARGB(255, 3, 88, 157),
              const Color.fromARGB(255, 117, 1, 138)
            ],
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Título centrado
            Center(
              child: Image.asset(
                'assets/logo3.png',
                height: 350, // Puedes ajustar el tamaño según lo que necesites
              ),
            ),
            SizedBox(height: 5),
            // Campo de texto para el email
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle:
                    TextStyle(color: Colors.white), // Color del texto del label
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.white), // Color del borde
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
              style:
                  TextStyle(color: Colors.white), // Color del texto ingresado
            ),
            SizedBox(height: 25),
            // Campo de texto para la contraseña
            TextField(
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              obscureText: true,
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 50),
            // Botón de inicio de sesión
            ElevatedButton(
              onPressed: () {
                // Acción de registro
                Navigator.pushNamed(context, '/dashboard');
              },
              child: Text(
                'Iniciar Sesión',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // Fondo blanco
                foregroundColor:
                    const Color.fromARGB(255, 5, 145, 232), // Texto azul
                padding: EdgeInsets.symmetric(horizontal: 90, vertical: 26),
              ),
            ),
            // Enlace para recuperar contraseña
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/forgot-password');
              },
              child: Text(
                '¿Olvidaste tu contraseña?',
                style: TextStyle(color: Colors.white),
              ),
            ),
            // Texto para registrarse
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: Text(
                '¿No tienes cuenta? Regístrate',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
