import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() {
  runApp(PayPage());
}

class PayPage extends StatelessWidget {
  const PayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Formulario',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isLoading = false;

  void _handlePagar() {
    setState(() {
      _isLoading = true;
    });
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pago realizado con éxito')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        title: const Text(
          'TU CONFIANZA ES NUESTRA MEJOR RECOMPENSA',
          style: TextStyle(fontSize: 16.0),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 20.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'RELLENE LOS DATOS',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.blue[800],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'LOCALIDAD',
                          border: OutlineInputBorder(),
                        ),
                        items: ['Localidad 1', 'Localidad 2', 'Localidad 3']
                            .map((localidad) {
                          return DropdownMenuItem<String>(
                            value: localidad,
                            child: Text(localidad),
                          );
                        }).toList(),
                        onChanged: (value) {},
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'NOMBRE COMPLETO',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'NUMERO DE TELEFONO',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      _isLoading
                          ? const SpinKitFadingCircle(
                              color: Colors.blue,
                              size: 50.0,
                            )
                          : ElevatedButton(
                              onPressed: _handlePagar,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue[800],
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 20),
                              ),
                              child: Text('PAGAR'),
                            ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                ),
                child: Text('QUITAR'),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Column(
                  children: [
                    const Text(
                      'SIGUENOS',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const FaIcon(FontAwesomeIcons.facebook),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const FaIcon(FontAwesomeIcons.twitter),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const FaIcon(FontAwesomeIcons.tiktok),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const Text(
                      'TERMINOS LEGALES',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text('Terminos y condiciones\nPoliticas de privacidad'),
                    const SizedBox(height: 10),
                    const Text(
                      'CONTACTANOS',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Column(
                      children: [
                        Text('jesuruga@email.com'),
                        Text('+52 961 283 5436'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
