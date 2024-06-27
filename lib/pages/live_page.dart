import 'package:JASAI_LIVE/pages/home_list.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:JASAI_LIVE/pages/account_page.dart';

class LivePage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<LivePage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      'https://www.example.com/video.mp4', // Reemplaza esta URL con la URL de tu video
    )
      ..initialize().then((_) {
        setState(() {});
      })
      ..setLooping(true)
      ..play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Color(0xFF3F51B5),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF3F51B5),
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
                // Acción al presionar "Inicio"
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeList(title: 'BIENVENIDO A JASAI'),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.event),
              title: Text('Eventos'),
              onTap: () {
                // Acción al presionar "Eventos"
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Perfil'),
              onTap: () {
                // Acción al presionar "Perfil"
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
                // Acción al presionar "Configuración"
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            color: Color(0xFF3F51B5),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.landscape, size: 80, color: Colors.purple),
            ],
          ),
          SizedBox(height: 20),
          _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Container(
                  height: 200,
                  color: Colors.black,
                  child: Center(child: CircularProgressIndicator()),
                ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Acción al presionar "Ver en Vivo"
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              side: BorderSide(color: Colors.pink),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            child: Text('EN VIVO'),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Jasai_live@',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LivePage(),
  ));
}
