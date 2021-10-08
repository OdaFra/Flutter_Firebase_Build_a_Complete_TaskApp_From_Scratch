import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app_workos/screen/constants/constants.dart';
import 'package:flutter_firebase_app_workos/screen/tareas_screen.dart';
import 'package:flutter_firebase_app_workos/screen/todos_usuarios.dart';
import 'package:flutter_firebase_app_workos/screen/views/crear_tareas.dart';
import 'package:flutter_firebase_app_workos/screen/views/perfil.dart';

import '../../user_state.dart';

class DrawerWidgets extends StatefulWidget {
  @override
  _DrawerWidgetsState createState() => _DrawerWidgetsState();
}

class _DrawerWidgetsState extends State<DrawerWidgets> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green.shade300,
              ),
              child: Column(
                children: [
                  Flexible(
                    flex: 2,
                    child: Image.network(
                        'https://cdn-icons-png.flaticon.com/512/1055/1055687.png'),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Flexible(
                    child: Text(
                      'Work Os',
                      style: TextStyle(
                        color: Constants.darkBlue,
                        fontSize: 22,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )),
          SizedBox(
            height: 15,
          ),
          _listTiles(
              label: 'Todas las tareas',
              fct: () {
                _navigatorTodasTareas(context);
              },
              icon: Icons.task),
          _listTiles(
              label: 'Mi cuenta',
              fct: () {
                _navigatorPerfil(context);
              },
              icon: Icons.settings),
          _listTiles(
              label: 'Todos los usuarios',
              fct: () {
                _navigatorColaboradores(context);
              },
              icon: Icons.workspaces),
          _listTiles(
              label: 'Agregar tareas',
              fct: () {
                _navigatorCrearTareas();
              },
              icon: Icons.add_task),
          Divider(
            thickness: 1.5,
          ),
          _listTiles(
              label: 'Cerrar Sesión',
              fct: () {
                _cerrarSesion(context);
              },
              icon: Icons.logout),
        ],
      ),
    );
  }

  void _cerrarSesion(context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    'https://cdn-icons-png.flaticon.com/512/305/305703.png',
                    height: 20,
                    width: 20,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
                    'Cerrar Sesión',
                    style: TextStyle(fontSize: 18),
                  ),
                )
              ],
            ),
            content: Text(
              'Quieres cerrar sesión?',
              style: TextStyle(
                color: Constants.darkBlue,
                fontSize: 15,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.canPop(context)
                            ? Navigator.pop(context)
                            : null;
                      },
                      child: Text(
                        'Cancelar',
                      )),
                  SizedBox(
                    width: 8,
                  ),
                  TextButton(
                      onPressed: () {
                        _auth.signOut();
                        Navigator.canPop(context)
                            ? Navigator.pop(context)
                            : null;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserState()));
                      },
                      child: Text('OK', style: TextStyle(color: Colors.red)))
                ],
              )
            ],
          );
        });
  }

  void _navigatorPerfil(context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;
    final String uid = user!.uid;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => PerfilViews(userID: uid),
      ),
    );
  }

  void _navigatorColaboradores(context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => TodosColaboradores()));
  }

  void _navigatorTodasTareas(context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => TareasScreen()));
  }

  void _navigatorCrearTareas() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CrearTareas()));
  }

  Widget _listTiles(
      {required String label, required Function fct, required IconData icon}) {
    return ListTile(
      onTap: () {
        fct();
      },
      leading: Icon(icon, size: 25, color: Constants.darkBlue),
      title: Text(
        label,
        style: TextStyle(
          color: Constants.darkBlue,
          fontSize: 15,
          fontStyle: FontStyle.normal,
        ),
      ),
    );
  }
}
