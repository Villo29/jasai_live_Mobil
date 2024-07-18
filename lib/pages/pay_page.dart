import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:JASAI_LIVE/models/auth_model.dart'; // Asegúrate de que la ruta de importación es correcta.

void main() {
  runApp(
    Provider<AuthModel>(
      create: (_) => AuthModel(), // Asegura que AuthModel ya está definido y configurado.
      child: const MaterialApp(
        home: PayPage(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}

class PayPage extends StatefulWidget {
  const PayPage({super.key});

  @override
  _PayPageState createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  final nombreController = TextEditingController();
  final telefonoController = TextEditingController();
  final correoController = TextEditingController();
  String localidad = 'General';
  bool _isLoading = false;

  @override
  void dispose() {
    nombreController.dispose();
    telefonoController.dispose();
    correoController.dispose();
    super.dispose();
  }

  void _handlePagar() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await enviarDatosAlServidor();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pago realizado con éxito')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al realizar el pago: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> enviarDatosAlServidor() async {
    final authModel = Provider.of<AuthModel>(context, listen: false);
    var url = Uri.parse('http://67.202.4.38:3000/api/carrito');
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authModel.token}',
      },
      body: jsonEncode({
        '_id': authModel.userId,
        'nombre': nombreController.text,
        'localidad': localidad,
        'correo': correoController.text,
      }),
    );

    // Aceptar cualquier respuesta 2xx como un éxito.
    if (response.statusCode >= 200 && response.statusCode < 300) {
      print("Datos enviados correctamente.");
    } else {
      throw Exception('Falló la solicitud: ${response.statusCode} ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagar'),
        backgroundColor: Colors.blue[800],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre Completo',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: correoController,
                decoration: const InputDecoration(
                  labelText: 'Correo Electrónico',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: localidad,
                onChanged: (newValue) {
                  setState(() {
                    localidad = newValue!;
                  });
                },
                items: <String>['General', 'Preferente', 'VIP'].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  labelText: 'Localidad',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: telefonoController,
                decoration: const InputDecoration(
                  labelText: 'Número de Teléfono',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: _handlePagar,
                child: const Text('Pagar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800],  // Corregido de 'primary' a 'backgroundColor'
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
