import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:JASAI_LIVE/pages/buy_page.dart'; // Asegúrate de que la ruta sea correcta
import 'package:JASAI_LIVE/pages/account_page.dart';

class HomeList extends StatefulWidget {
  const HomeList({super.key, required this.title});
  final String title;

  @override
  State<HomeList> createState() => _HomeList();
}

class _HomeList extends State<HomeList> {
  final List<String> imgList = [
    'assets/images/image9.png',
    'assets/images/image2.png',
    'assets/images/image1.png',
  ];

  List<dynamic> allEvents = [];
  List<dynamic> filteredEvents = [];
  int currentPage = 0;
  final int pageSize = 3;
  bool isLoading = false;
  String selectedCategory = '';

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchEvents();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent && !isLoading) {
        fetchEvents();
      }
    });
  }

  Future<void> fetchEvents() async {
    setState(() {
      isLoading = true;
    });

    final response = await http.get(Uri.parse('http://67.202.4.38:3000/api/eventos'));

    if (response.statusCode == 200) {
      final List<dynamic> newEvents = json.decode(response.body);
      setState(() {
        allEvents.addAll(newEvents.skip(currentPage * pageSize).take(pageSize));
        filterEvents();
        currentPage++;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to load events');
    }
  }

  void filterEvents() {
    setState(() {
      if (selectedCategory.isEmpty) {
        filteredEvents = allEvents;
      } else {
        filteredEvents = allEvents.where((event) => event['genero'] == selectedCategory).toList();
      }
    });
  }

  Future<bool> _onWillPop() async {
    SystemNavigator.pop();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Menú',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Inicio'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.event),
                title: const Text('Eventos'),
                onTap: () {
                  // Acción al presionar Eventos
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.account_circle),
                title: const Text('Perfil'),
                onTap: () {
                  // Acción al presionar Perfil
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PerfilPage(), // Navegar a PerfilPage
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Configuración'),
                onTap: () {
                  // Acción al presionar Configuración
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Carrusel
                CarouselSlider(
                  options: CarouselOptions(
                    height: 200.0,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: const Duration(milliseconds: 800),
                    viewportFraction: 0.8,
                  ),
                  items: imgList
                      .map((item) => Container(
                    child: Center(
                      child: Image.asset(item,
                          fit: BoxFit.cover, width: 1000),
                    ),
                  ))
                      .toList(),
                ),
                const SizedBox(height: 20),
                const Text('FILTRAR POR CATEGORIA', style: TextStyle(fontSize: 20)),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 10,
                  children: [
                    _categoryButton('Comedia'),
                    _categoryButton('Entretenimiento'),
                    _categoryButton('Familiar'),
                    _categoryButton('Pop'),
                    _categoryButton('Festival'),
                  ],
                ),
                const SizedBox(height: 20),
                const Text('POPULAR', style: TextStyle(fontSize: 20)),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _popularItem('assets/images/image1.png', 'Junior H'),
                    _popularItem('assets/images/image12.png', 'Peso Pluma'),
                    _popularItem('assets/images/image6.png', 'Luis Miguel'),
                  ],
                ),
                const SizedBox(height: 20),
                const Text('PRÓXIMOS A REALIZAR', style: TextStyle(fontSize: 20)),
                const SizedBox(height: 20),
                Column(
                  children: filteredEvents.isNotEmpty
                      ? filteredEvents.map((event) {
                    return Column(
                      children: [
                        _eventItem(event['imagen'], event['nombre'], event['lugar'], event['_id']),
                        const SizedBox(height: 20),
                      ],
                    );
                  }).toList()
                      : [
                    const Text('No hay eventos disponibles en esta categoría'),
                  ],
                ),
                const SizedBox(height: 20),
                if (isLoading)
                  CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: fetchEvents,
                    child: const Text('VER MÁS'),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _categoryButton(String text) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedCategory = text;
          currentPage = 0;
          allEvents.clear();
          filteredEvents.clear();
          fetchEvents();
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.pink, // Color del botón
      ),
      child: Text(text),
    );
  }

  Widget _popularItem(String imagePath, String name) {
    return Column(
      children: [
        Image.asset(imagePath, width: 100, height: 100),
        Text(name),
      ],
    );
  }

  Widget _eventItem(String imagePath, String name, String location, String id) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      width: double.infinity, // Hace que el contenedor ocupe todo el ancho disponible
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(255, 47, 43, 173),
          width: 6.0, // Aumenta el grosor del borde
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              // Acción al hacer clic en la imagen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BuyTicket(eventId: id), // Navegar a BuyTicket con el ID
                ),
              );
            },
            child: Image.network(
              imagePath,
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            name,
            style: const TextStyle(color: Colors.blue),
          ),
          const SizedBox(height: 4.0),
          Text(location),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: HomeList(title: 'BIENVENIDO A JASAI'),
  ));
}