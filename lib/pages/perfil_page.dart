import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:JASAI_LIVE/models/auth_model.dart'; // Asegúrate de que la ruta de importación es correcta
import 'package:JASAI_LIVE/models/user_model.dart'; // Importación del modelo de usuario

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authModel = Provider.of<AuthModel>(context);
    final userName = authModel.currentUser?.nombre ?? 'Usuario no identificado';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración de la Cuenta'),
        backgroundColor: const Color(0xFF3F51B5),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.person, size: 100, color: Colors.blue),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  userName,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _showUpdateDialog(context, authModel);
            },
            child: const Text("Actualizar Datos"),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              _showDeleteConfirmDialog(context, authModel);
            },
            child: const Text("Borrar Cuenta"),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          ),
        ],
      ),
    );
  }

  void _showUpdateDialog(BuildContext context, AuthModel authModel) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController contrasenaController = TextEditingController();
    final TextEditingController telefonoController = TextEditingController();

    nameController.text = authModel.currentUser?.nombre ?? '';
    emailController.text = authModel.currentUser?.correo ?? '';
    contrasenaController.text = authModel.currentUser?.contrasena ?? '';
    telefonoController.text = authModel.currentUser?.telefono ?? '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Actualizar Datos"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Nombre"),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Correo"),
              ),
              TextField(
                controller: contrasenaController,
                decoration:  const InputDecoration(labelText: "Contraeña"),
              ),
              TextField(
                controller: telefonoController,
                decoration: const InputDecoration(labelText: "Telefono"),
              )
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () async {
                try {
                  await authModel.updateUserData(nameController.text, emailController.text, contrasenaController.text, telefonoController.text );
                  Navigator.of(context).pop(); // Cierra el diálogo después de actualizar
                } catch (e) {
                  // Manejo de errores
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Error"),
                        content: Text("Error al actualizar los datos: $e"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text("Cerrar"),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: const Text("Actualizar"),
            ),
          ],
        );
      },
    );
  }


  void _showDeleteConfirmDialog(BuildContext context, AuthModel authModel) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {  // Utilizamos dialogContext para diferenciar el contexto del diálogo
        return AlertDialog(
          title: const Text("Confirmar Eliminación"),
          content: const Text("¿Estás seguro de que quieres borrar tu cuenta? Esta acción no se puede deshacer."),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),  // Usamos dialogContext para cerrar el diálogo
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(dialogContext).pop();  // Cierra el diálogo antes de hacer la operación
                try {
                  await authModel.deleteUser();
                  Navigator.of(context).pushReplacementNamed('/');  // Usamos context del build para hacer la navegación
                } catch (e) {
                  showDialog(
                    context: context,  // Usamos el context original del build para mostrar otro diálogo
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Error"),
                        content: Text("No se pudo eliminar la cuenta: $e"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text("Cerrar"),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: const Text("Borrar"),
            ),
          ],
        );
      },
    );
  }
}
