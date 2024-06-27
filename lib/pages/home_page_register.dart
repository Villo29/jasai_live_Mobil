import 'package:flutter/material.dart';

class HomePageRegister extends StatefulWidget {
  const HomePageRegister({super.key, required this.title});
  final String title;

  @override
  State<HomePageRegister> createState() => _HomePageRegister();
}

class _HomePageRegister extends State<HomePageRegister> {
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png'),
            SizedBox(height: 20),
            Text('Inicio de Sesion', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            TextField(
              controller: _nombreController,
              decoration: InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _correoController,
              decoration: InputDecoration(
                labelText: 'Correo',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _numeroController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Telefono',
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registro exitoso')));
                Navigator.pop(context);
              },
              child: Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomePageRegister(title: 'BIENVENIDO A JASAI'),
  ));
}