import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart'; // Importa la librería intl
import 'package:JASAI_LIVE/pages/pay_page.dart';

class BuyTicket extends StatelessWidget {
  final String eventId;

  const BuyTicket({super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Sobre Concierto'),
          backgroundColor: Colors.deepPurple,
        ),
        drawer: const Drawer(), // Drawer para el menú lateral
        body: ConcertDetails(eventId: eventId),
      ),
    );
  }
}

class ConcertDetails extends StatefulWidget {
  final String eventId;

  const ConcertDetails({super.key, required this.eventId});

  @override
  _ConcertDetailsState createState() => _ConcertDetailsState();
}

class _ConcertDetailsState extends State<ConcertDetails> {
  late Future<Map<String, dynamic>> eventDetails;

  @override
  void initState() {
    super.initState();
    eventDetails = fetchEventDetails(widget.eventId);
  }

  Future<Map<String, dynamic>> fetchEventDetails(String id) async {
    final String url = 'http://67.202.4.38:3000/api/eventos/$id';
    print('Fetching event details from: $url');  // Añade este print para depuración

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print('Response data: ${response.body}');  // Añade este print para ver la respuesta
      return json.decode(response.body);
    } else {
      print('Failed to load event details, status code: ${response.statusCode}');  // Añade este print para ver el código de estado
      throw Exception('Failed to load event details');
    }
  }

  String formatDate(String? date) {
    if (date == null) return 'Fecha no disponible';
    try {
      DateTime parsedDate = DateTime.parse(date);
      return DateFormat('dd/MM/yyyy').format(parsedDate);
    } catch (e) {
      return date;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: eventDetails,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No event details available'));
        } else {
          final event = snapshot.data!;
          final String vipPrice = event['vip']?.toString() ?? 'N/A';
          final String preferentePrice = event['preferente']?.toString() ?? 'N/A';
          final String generalPrice = event['general']?.toString() ?? 'N/A';

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
                                  // Cambia la imagen seleccionada según sea necesario
                                });
                              },
                              child: Image.network(
                                event['imagen'] ?? 'https://via.placeholder.com/150',
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              // Cambia la imagen seleccionada según sea necesario
                            });
                          },
                          child: Image.network(
                            event['imagen'] ?? 'https://via.placeholder.com/150',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          event['nombre'] ?? 'Nombre no disponible',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0),
                        ),
                        Text(event['lugar'] ?? 'Lugar no disponible'),
                        const SizedBox(height: 8.0),
                        Text('VIP \$${vipPrice}'),
                        Text('PREFERENTE \$${preferentePrice}'),
                        Text('GENERAL \$${generalPrice}'),
                        const SizedBox(height: 8.0),
                        Text(formatDate(event['fecha'])),
                        const SizedBox(height: 8.0),
                        ElevatedButton(
                          onPressed: () {
                            // Acción del botón
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor:
                            Colors.white, // Aquí cambias el color del texto
                          ),
                          child: Text('CONSULTA POR WHATSAPP'),
                        ),
                        OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PayPage()),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.purple),
                          ),
                          child: Text('AÑADIR AL CARRITO',
                              style: TextStyle(color: Colors.purple)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  const Center(
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
                  const SizedBox(height: 8.0),
                  const Row(
                    children: [
                      SizedBox(width: 8.0),
                      Text('Paypal'),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  EventCard(
                    imagePath: 'assets/images/image1.png',
                    title: 'Junior H - Tapachula, Chiapas',
                  ),
                  const SizedBox(height: 8.0),
                  EventCard(
                    imagePath: 'assets/images/image9.png',
                    title: 'Bad Bunny - Puebla',
                  ),
                  const SizedBox(height: 8.0),
                  EventCard(
                    imagePath: 'assets/images/image6.png',
                    title: 'Luis Miguel - El Parral, Chiapas',
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

class EventCard extends StatelessWidget {
  final String imagePath;
  final String title;

  const EventCard({super.key, required this.imagePath, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
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
          const SizedBox(height: 8.0),
          Text(
            title,
            style: const TextStyle(color: Colors.blue),
          ),
        ],
      ),
    );
  }
}
