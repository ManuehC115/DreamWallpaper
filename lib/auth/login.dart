import 'package:flutter/material.dart';
import 'dart:async';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _errorMessage;
  bool _showError = false;

  void _login() {
    setState(() {
      _errorMessage = null;
      _showError = false;
    });

    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      _showErrorMessage('Por favor, completa todos los campos');
    } else if (_passwordController.text != '1234') {
      _showErrorMessage('Contraseña incorrecta');
    } else {
      Navigator.pushNamed(context, '/dashboard');
    }
  }

  void _showErrorMessage(String message) {
    setState(() {
      _errorMessage = message;
      _showError = true;
    });

    Timer(Duration(seconds: 5), () {
      setState(() {
        _showError = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // Asegura que el contenido no se superponga con la barra de estado
        child: Container(
          height: MediaQuery.of(context).size.height, // Ocupa toda la pantalla
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
          child: Center(
            child: SingleChildScrollView(
              // Desplazamiento solo si es necesario
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo3.png',
                    height: MediaQuery.of(context).size.height *
                        0.3, // Ajusta proporcionalmente
                  ),
                  SizedBox(height: 20),
                  AnimatedOpacity(
                    opacity: _showError ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 500),
                    child: _errorMessage != null
                        ? Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              _errorMessage!,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : SizedBox.shrink(),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 25),
                  TextField(
                    controller: _passwordController,
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
                  SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: _login,
                    child: Text(
                      'Iniciar Sesión',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color.fromARGB(255, 5, 145, 232),
                      padding:
                          EdgeInsets.symmetric(horizontal: 90, vertical: 26),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/forgot-password');
                    },
                    child: Text(
                      '¿Olvidaste tu contraseña?',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
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
          ),
        ),
      ),
    );
  }
}
