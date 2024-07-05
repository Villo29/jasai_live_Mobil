import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:JASAI_LIVE/pages/home_page.dart'; // Asegúrate de que la ruta a MyHomePage es correcta.
import 'package:JASAI_LIVE/models/auth_model.dart'; // Asegúrate de importar tu AuthModel.

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Envolver MaterialApp con ChangeNotifierProvider
    return ChangeNotifierProvider(
      create: (context) => AuthModel(), // Crea una instancia de AuthModel
      child: MaterialApp(
        title: 'JASAI LIVE',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
