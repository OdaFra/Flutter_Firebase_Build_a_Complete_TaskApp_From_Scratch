import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app_workos/screen/widgets/colaboradres_widget.dart';
import 'package:flutter_firebase_app_workos/screen/widgets/drawer_widgets.dart';

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
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.data!.docs.isNotEmpty) {
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (ctx, index) {
                      return TodosColaboradoresWidgets(
                        userID: snapshot.data!.docs[index]['id'],
                        userName: snapshot.data!.docs[index]['name'],
                        userEmail: snapshot.data!.docs[index]['email'],
                        phoneNumber: snapshot.data!.docs[index]['phoneNumber'],
                        positionCompany: snapshot.data!.docs[index]
                            ['posicionCompany'],
                        userImageUrl: snapshot.data!.docs[index]['userImage'],
                      );
                    });
              } else {
                return Center(child: Text('No existe usuarios'));
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
}
