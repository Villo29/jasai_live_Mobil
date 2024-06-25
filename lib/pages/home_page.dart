import 'package:flutter/material.dart';
import 'package:JASAI_LIVE/pages/home_list.dart';
import 'package:JASAI_LIVE/pages/home_page_register.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  final String _validEmail = 'usuario@example.com';
  final String _validPassword = '1234';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/icon.png'),
            SizedBox(height: 10),
            Text('Inicio de Sesion', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
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
            ElevatedButton(
              onPressed: () {
                if (_emailController.text == _validEmail && _passwordController.text == _validPassword) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Inicio de sesión exitoso')));
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeList(title: 'JASAI LIVE')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Correo o contraseña incorrectos')));
                }
              },
              child: Text('Iniciar Sesión'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePageRegister(title: 'Registro')),
                );
              },
              child: Text('Nuevo Usuario? Regístrate'),
            ),
          ],
        ),
      ),
    );
  }
}
