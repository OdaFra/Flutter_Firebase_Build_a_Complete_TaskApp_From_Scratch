import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app_workos/screen/auth/accesso_login.dart';
import 'package:flutter_firebase_app_workos/screen/tareas_screen.dart';

class UserState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, userSnapshot) {
          if (userSnapshot.data == null) {
            print('El usuario aun no ha iniciado sesion!');
            return Login();
          } else if (userSnapshot.hasData) {
            print('El usuario ya ha iniciado sesion!');
            return TareasScreen();
          } else if (userSnapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          } else if (userSnapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return Scaffold(
            body: Center(
              child: Text('Algo salio mal!'),
            ),
          );
        });
  }
}
