import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app_workos/screen/constants/constants.dart';
import 'package:flutter_firebase_app_workos/screen/widgets/drawer_widgets.dart';
import 'package:flutter_firebase_app_workos/screen/widgets/tareas_widgets.dart';

class TareasScreen extends StatefulWidget {
  @override
  _TareasScreenState createState() => _TareasScreenState();
}

class _TareasScreenState extends State<TareasScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: DrawerWidgets(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black45),
        // leading: Builder(builder: (ctx) {
        //   return IconButton(
        //       onPressed: () {
        //         Scaffold.of(ctx).openDrawer();
        //       },
        //       icon: Icon(
        //         Icons.menu_outlined,
        //         color: Colors.black45,
        //       ));
        // }),
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Tareas',
          style: TextStyle(
            color: Colors.green.shade500,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          IconButton(
              onPressed: () {
                _MostrarCategoriaTareas(size: size);
              },
              icon: Icon(
                Icons.filter_list_outlined,
                color: Colors.black45,
              )),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('task').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.data!.docs.isNotEmpty) {
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, index) {
                      return TareasWidgets(
                        taskId: snapshot.data!.docs[index]['taskID'],
                        taskTitle: snapshot.data!.docs[index]['taskTitle'],
                        taskDescription: snapshot.data!.docs[index]
                            ['taskDescription'],
                        taskuploadBy: snapshot.data!.docs[index]['uploadedBy'],
                        isDone: snapshot.data!.docs[index]['isDone'],
                      );
                    });
              } else {
                return Center(child: Text('No se ha publicado tareas'));
              }
            }
            return Center(
              child: Text(
                'Algo ha salido mal!',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            );
          }),
    );
  }

  _MostrarCategoriaTareas({required Size size}) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text(
              'Categoria de Tareas',
              style: TextStyle(fontSize: 20, color: Colors.green.shade500),
            ),
            content: Container(
              width: size.width * 0.8,
              child: ListView.builder(
                  itemCount: Constants.CategoriaTareas.length,
                  shrinkWrap: true,
                  itemBuilder: (ctxx, index) {
                    return InkWell(
                      onTap: () {
                        print(
                            'Constants.CategoriaTareas[index] ${Constants.CategoriaTareas[index]}');
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle_rounded,
                            color: Colors.green.shade500,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              Constants.CategoriaTareas[index],
                              style: TextStyle(
                                  color: Constants.darkBlue,
                                  fontSize: 18,
                                  fontStyle: FontStyle.italic),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
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
                      child: Text('Cerrar')),
                  SizedBox(
                    width: 8,
                  ),
                  TextButton(onPressed: () {}, child: Text('Cancelar filtro'))
                ],
              )
            ],
          );
        });
  }
}
