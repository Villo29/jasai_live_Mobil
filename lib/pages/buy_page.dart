import 'package:flutter/material.dart';
import 'package:JASAI_LIVE/pages/pay_page.dart';

void main() {
  runApp(Buy_Ticket());
}

class Buy_Ticket extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Sobre Concierto'),
          backgroundColor: Colors.deepPurple,
        ),
        drawer: Drawer(), // Drawer para el menú lateral
        body: ConcertDetails(),
      ),
    );
  }
}

class ConcertDetails extends StatefulWidget {
  @override
  _ConcertDetailsState createState() => _ConcertDetailsState();
}

class _ConcertDetailsState extends State<ConcertDetails> {
  String selectedImage = 'assets/images/image2.png';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedImage = 'assets/images/image1.png';
                          });
                        },
                        child: Image.asset(
                          'assets/images/image1.png',
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedImage = 'assets/images/image13.png';
                          });
                        },
                        child: Image.asset(
                          'assets/images/image13.png',
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedImage = 'assets/images/image12.png';
                      });
                    },
                    child: Image.asset(
                      selectedImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'PESO PLUMA, TUXTLA GUTIERREZ',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  Text('16 de mayo de 2024'),
                  SizedBox(height: 8.0),
                  Text('VIP \$1,300'),
                  Text('PREFERENTE \$1,000'),
                  Text('GENERAL \$799'),
                  SizedBox(height: 8.0),
                  Text('2024'),
                  SizedBox(height: 8.0),
                  ElevatedButton(
                    onPressed: () {
                      // Acción del botón
                    },
                    child: Text('CONSULTA POR WHATSAPP'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor:
                          Colors.white, // Aquí cambias el color del texto
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PayPage ()),
                      );
                    },
                    child: Text('AÑADIR AL CARRITO',
                        style: TextStyle(color: Colors.purple)),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.purple),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.0),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('• Compra segura.'),
                  Text('• Certificado de autenticidad'),
                  SizedBox(height: 8.0),
                  Text('Cuota sin interés'),
                ],
              ),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                SizedBox(width: 8.0),
                Text('Paypal'),
              ],
            ),
            SizedBox(height: 16.0),
            EventCard(
              imagePath: 'assets/images/image1.png',
              title: 'Junior H - Tapachula, Chiapas',
            ),
            SizedBox(height: 8.0),
            EventCard(
              imagePath: 'assets/images/image9.png',
              title: 'Bad Bunny - Puebla',
            ),
            SizedBox(height: 8.0),
            EventCard(
              imagePath: 'assets/images/image6.png',
              title: 'Luis Miguel - El Parral, Chiapas',
            ),
          ],
        ),
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final String imagePath;
  final String title;

  EventCard({required this.imagePath, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(255, 47, 43, 173),
          width: 2.5, // Aquí ajustas el grosor del borde
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          Center(
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            title,
            style: TextStyle(color: Colors.blue),
          ),
        ],
      ),
    );
  }
}

