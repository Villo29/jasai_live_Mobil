import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:JASAI_LIVE/models/auth_model.dart';
import 'package:JASAI_LIVE/pages/home_page.dart'; // Asegúrate de que esta ruta es correcta para tu página de inicio
import 'package:JASAI_LIVE/pages/perfil_page.dart'; // Asegúrate de que esta ruta es correcta para la página de detalles de la cuenta

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Cuenta'),
        backgroundColor: const Color(0xFF3F51B5),
      ),
      body: SingleChildScrollView(
        child: Column(
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'MI CUENTA',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'En este apartado puedes actualizar los detalles de tu cuenta. También puedes cerrar sesión para mantener tu cuenta segura.',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      // Navega a la página de detalles de la cuenta
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AccountPage(), // Asegúrate de que AccountPage es la correcta
                        ),
                      );
                    },
                    child: const Card(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.person,
                              size: 40.0,
                              color: Colors.red,
                            ),
                            SizedBox(width: 20),
                            Text(
                              'DETALLES DE LA CUENTA',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _logout(context),
                    child: const Card(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.logout,
                              size: 40.0,
                              color: Colors.red,
                            ),
                            SizedBox(width: 20),
                            Text(
                              'CERRAR SESIÓN',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Divider(),
            // Otros widgets aquí...
          ],
        ),
      ),
    );
  }

  void _logout(BuildContext context) {
    Provider.of<AuthModel>(context, listen: false).logout();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const MyHomePage()),
      ModalRoute.withName('/'),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: PerfilPage(),
  ));
}
