import 'package:flutter/material.dart';
import 'package:flutter_firebase_app_workos/screen/constants/constants.dart';
import 'package:flutter_firebase_app_workos/screen/widgets/colaboradres_widget.dart';
import 'package:flutter_firebase_app_workos/screen/widgets/drawer_widgets.dart';
import 'package:flutter_firebase_app_workos/screen/widgets/tareas_widgets.dart';

class TodosColaboradores extends StatefulWidget {
  @override
  _TodosColaboradoresState createState() => _TodosColaboradoresState();
}

class _TodosColaboradoresState extends State<TodosColaboradores> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: DrawerWidgets(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black45),
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Colaboradores',
          style: TextStyle(
            color: Colors.green.shade500,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: ListView.builder(itemBuilder: (ctx, index) {
        return TodosColaboradoresWidgets();
      }),
    );
  }
}
