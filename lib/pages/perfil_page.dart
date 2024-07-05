import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:JASAI_LIVE/models/auth_model.dart'; // Asegúrate de importar tu AuthModel

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtener el modelo de autenticación desde el Provider
    final authModel = Provider.of<AuthModel>(context);
    final userName = authModel.currentUser?.nombre ?? 'Usuario no identificado';

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: const Color(0xFF3F51B5),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      drawer: Drawer(
        // Contenido del drawer aquí...
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            color: const Color(0xFF3F51B5),
            child: const Center(
              child: Text(
                "“TU CONFIANZA ES NUESTRA MEJOR RECOMPENSA”",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Icon(Icons.landscape, size: 80, color: Colors.purple),
              Column(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.red,
                    child: Icon(Icons.person, size: 40, color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.pink),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Text(
                      userName, // Muestra el nombre del usuario obtenido desde AuthModel
                      style: const TextStyle(fontSize: 18.0),
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Otros widgets...
        ],
      ),
    );
  }
}
