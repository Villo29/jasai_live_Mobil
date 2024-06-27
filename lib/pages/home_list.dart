import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
              icon: Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
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
                leading: Icon(Icons.home),
                title: Text('Inicio'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.event),
                title: Text('Eventos'),
                onTap: () {
                  // Acción al presionar Eventos
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Perfil'),
                onTap: () {
                  // Acción al presionar Perfil
                  Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PerfilPage(), // Navegar a Buy_Ticket
                ),
              );
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Configuración'),
                onTap: () {
                  // Acción al presionar Configuración
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
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
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
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
                SizedBox(height: 20),
                Text('FILTRAR POR CATEGORIA', style: TextStyle(fontSize: 20)),
                SizedBox(height: 20),
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
                SizedBox(height: 20),
                Text('POPULAR', style: TextStyle(fontSize: 20)),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _popularItem('assets/images/image1.png', 'Junior H'),
                    _popularItem('assets/images/image12.png', 'Peso Pluma'),
                    _popularItem('assets/images/image6.png', 'Luis Miguel'),
                  ],
                ),
                SizedBox(height: 20),
                Text('PRÓXIMOS A REALIZAR', style: TextStyle(fontSize: 20)),
                SizedBox(height: 20),
                Column(
                  children: [
                    _eventItem('assets/images/image12.png', 'Peso Pluma',
                        'Suchiapa, Chiapas'),
                    SizedBox(height: 20), // Espacio entre los ítems
                    _eventItem('assets/images/image4.png', 'Dani Flow',
                        'Tuxtla Gutierrez, Chiapas'),
                    SizedBox(height: 20), // Espacio entre los ítems
                    _eventItem('assets/images/image5.png', 'Miguel Bose',
                        'Suchiapa, Chiapas'),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Acción del botón "Ver Más"
                  },
                  child: Text('VER MÁS'),
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
        // Acción del botón de categoría
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

  Widget _eventItem(String imagePath, String name, String location) {
    return Container(
      padding: EdgeInsets.all(10.0),
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
                  builder: (context) => Buy_Ticket(), // Navegar a Buy_Ticket
                ),
              );
            },
            child: Image.asset(
              imagePath,
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            name,
            style: TextStyle(color: Colors.blue),
          ),
          SizedBox(height: 4.0),
          Text(location),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomeList(title: 'BIENVENIDO A JASAI'),
  ));
}
