class UserModel {
  final String nombre;
  final String correo;

  UserModel({required this.nombre, required this.correo});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      nombre: json['nombre'] as String,
      correo: json['correo'] as String,
    );
  }
}
