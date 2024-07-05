import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:JASAI_LIVE/models/user_model.dart'; // Asegúrate de que la ruta de importación es correcta

class AuthModel extends ChangeNotifier {
  bool _isLoggedIn = false;
  String _token = '';
  String _userId = ''; // Agregamos una variable para almacenar el ID del usuario
  UserModel? _currentUser;

  UserModel? get currentUser => _currentUser;

  // Constructor que puede inicializar el modelo si es necesario
  AuthModel();

  // Getter para saber si el usuario está logueado
  bool get isLoggedIn => _isLoggedIn;

  // Método para realizar la autenticación y obtener el token
  Future<void> login(String correo, String contrasena) async {
    var url = Uri.parse('http://67.202.4.38:3000/api/usuarios/login');
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json', // Correcto manejo de Content-Type
      },
      body: json.encode({ // Codifica el cuerpo a formato JSON
        'correo': correo,
        'contraseña': contrasena,
      }),
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      _token = data['token'];
      _userId = data['usuario']['_id']; // Almacenamos el ID del usuario
      _isLoggedIn = true;
      await fetchUserData(); // Llama a fetchUserData después de obtener el token
      notifyListeners();
    } else {
      print('Failed to log in with status: ${response.statusCode}');
      print('Response: ${response.body}');
      throw Exception('Failed to log in');
    }
  }

  // Método para cerrar la sesión
  void logout() {
    _isLoggedIn = false;
    _token = '';
    _userId = '';
    _currentUser = null;
    notifyListeners();
  }

  // Método para obtener los datos del usuario desde la API
  Future<void> fetchUserData() async {
    var url = Uri.parse('http://67.202.4.38:3000/api/usuarios/${_userId}'); // Usamos el ID del usuario en la URL
    var response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_token',
      },
    );

    if (response.statusCode == 200) {
      var userData = json.decode(response.body);
      if (userData != null) {
        _currentUser = UserModel.fromJson(userData);
        notifyListeners();
      } else {
        throw Exception('User data is null');
      }
    } else {
      print('Failed to load user data with status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to load user data');
    }
  }
}
