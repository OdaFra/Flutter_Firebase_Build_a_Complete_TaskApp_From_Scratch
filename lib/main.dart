import 'package:flutter/material.dart';
import 'package:flutter_firebase_app_workos/screen/auth/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter WorkOs',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Color(0xffede7dc),
          primarySwatch: Colors.blue,
        ),
        home: Login());
  }
}
