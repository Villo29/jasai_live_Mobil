import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePageRegister extends StatefulWidget {
  const HomePageRegister({super.key, required this.title});
  final String title;

  @override
  State<HomePageRegister> createState() => _HomePageRegisterState();
}

class _HomePageRegisterState extends State<HomePageRegister> {
  // Controladores para los campos de texto
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();

  @override
  void dispose() {
    // Limpia los controladores cuando el widget se descarte
    _nombreController.dispose();
    _passwordController.dispose();
    _correoController.dispose();
    _numeroController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildLogo(),
              const SizedBox(height: 20),
              _buildTitle(),
              const SizedBox(height: 20),
              _buildNombreField(),
              const SizedBox(height: 20),
              _buildCorreoField(),
              const SizedBox(height: 20),
              _buildPasswordField(),
              const SizedBox(height: 20),
              _buildNumeroField(),
              const SizedBox(height: 20),
              _buildRegisterButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Image.asset('assets/images/logo.png');
  }

  Widget _buildTitle() {
    return const Text(
      'Registro',
      style: TextStyle(fontSize: 24),
    );
  }

  Widget _buildNombreField() {
    return TextField(
      controller: _nombreController,
      decoration: const InputDecoration(
        labelText: 'Nombre',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildCorreoField() {
    return TextField(
      controller: _correoController,
      decoration: const InputDecoration(
        labelText: 'Correo',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildPasswordField() {
    return TextField(
      controller: _passwordController,
      obscureText: true,
      decoration: const InputDecoration(
        labelText: 'Contraseña',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildNumeroField() {
    return TextField(
      controller: _numeroController,
      decoration: const InputDecoration(
        labelText: 'Telefono',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildRegisterButton() {
    return ElevatedButton(
      onPressed: _handleRegister,
      child: const Text('Registrarse'),
    );
  }

  Future<void> _handleRegister() async {
    final String nombre = _nombreController.text;
    final String correo = _correoController.text;
    final String contrasena = _passwordController.text;
    final String telefono = _numeroController.text;

    if (nombre.isNotEmpty && correo.isNotEmpty && contrasena.isNotEmpty && telefono.isNotEmpty) {
      final response = await http.post(
        Uri.parse('http://67.202.4.38:3000/api/Usuarios'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'nombre': nombre,
          'correo': correo,
          'contrasena': contrasena,
          'telefono': telefono,
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registro exitoso')),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error en el registro')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Todos los campos son obligatorios')),
      );
    }
  }
}

void main() {
  runApp(const MaterialApp(
    home: HomePageRegister(title: 'BIENVENIDO A JASAI'),
  ));
}
