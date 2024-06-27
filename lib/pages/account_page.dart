import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:JASAI_LIVE/pages/perfil_page.dart';


class PerfilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi Cuenta'),
        backgroundColor: Color(0xFF3F51B5), // Color del AppBar
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.0),
              color: Color(0xFF3F51B5), // Color de fondo del encabezado
              child: Center(
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
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'MI CUENTA',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'En este apartado puedes actualizar los detalles de tu cuenta. También puedes cerrar sesión para mantener tu cuenta segura.',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                  onTap: () {
              // Acción al hacer clic en la imagen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AccountPage(), // Navegar a Buy_Ticket
                ),
              );
            },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
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
                    onTap: () {
                        // Acción al hacer clic en la imagen
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
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
            SizedBox(height: 20),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CONTÁCTANOS',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      FaIcon(FontAwesomeIcons.whatsapp, color: Colors.green, size: 24.0),
                      SizedBox(width: 10),
                      Text(
                        '+52 968 109 6112',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'REDES SOCIALES',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FaIcon(FontAwesomeIcons.facebook, color: Colors.blue, size: 40.0),
                      FaIcon(FontAwesomeIcons.instagram, color: Colors.purple, size: 40.0),
                      FaIcon(FontAwesomeIcons.twitter, color: Colors.lightBlue, size: 40.0),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'MEDIOS DE PAGO',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: PerfilPage(),
  ));
}
