import 'package:flutter/material.dart';
import 'dart:async'; // Impor

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
      body: SingleChildScrollView(
        child: Container(
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
              Center(
                child: Image.asset(
                  'assets/logo3.png',
                  height: 250, // Ajuste del tamaño para evitar desbordamiento
                ),
              ),
              SizedBox(height: 5),
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
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      )
                    : SizedBox.shrink(),
              ),
              SizedBox(height: 10),
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
              SizedBox(height: 50),
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
                  padding: EdgeInsets.symmetric(horizontal: 90, vertical: 26),
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
    );
  }
}
