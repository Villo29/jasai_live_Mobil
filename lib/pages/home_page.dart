import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:JASAI_LIVE/pages/home_list.dart';
import 'package:JASAI_LIVE/pages/home_page_register.dart';
import 'package:JASAI_LIVE/models/auth_model.dart'; // Asegúrate de tener este archivo

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildLogo(),
              const SizedBox(height: 20),
              _buildTitle(),
              const SizedBox(height: 20),
              _buildEmailField(),
              const SizedBox(height: 20),
              _buildPasswordField(),
              const SizedBox(height: 20),
              _buildLoginButton(context),
              _buildRegisterButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return SizedBox(
      width: 400,  // Ancho deseado para la imagen
      height: 400, // Altura deseada para la imagen
      child: Image.asset('assets/images/icon.png'),
    );
  }

  Widget _buildTitle() {
    return const Text(
      'Inicio de Sesión',
      style: TextStyle(fontSize: 24),
    );
  }

  Widget _buildEmailField() {
    return TextField(
      controller: _emailController,
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

  Widget _buildLoginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _handleLogin(context),
      child: const Text('Iniciar Sesión'),
    );
  }

  Widget _buildRegisterButton() {
    return ElevatedButton(
      onPressed: _navigateToRegister,
      child: const Text('Nuevo Usuario? Regístrate'),
    );
  }

  void _handleLogin(BuildContext context) async {
    try {
      await Provider.of<AuthModel>(context, listen: false).login(
        _emailController.text,
        _passwordController.text,
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeList(title: 'JASAI LIVE'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  void _navigateToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePageRegister(title: 'Registro'),
      ),
    );
  }
}
