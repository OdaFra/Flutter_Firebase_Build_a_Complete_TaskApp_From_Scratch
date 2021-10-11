import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app_workos/screen/constants/constants.dart';
import 'package:flutter_firebase_app_workos/screen/views/detalles_tareas.dart';
import 'package:flutter_firebase_app_workos/services/metodos_globales.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TareasWidgets extends StatefulWidget {
  final String taskTitle;
  final String taskDescription;
  final String taskId;
  final String taskuploadBy;
  final bool isDone;

  const TareasWidgets(
      {required this.taskTitle,
      required this.taskDescription,
      required this.taskId,
      required this.taskuploadBy,
      required this.isDone});
  @override
  _TareasWidgetsState createState() => _TareasWidgetsState();
}

class _TareasWidgetsState extends State<TareasWidgets> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetallesTareasView(
                        uploadedBy: widget.taskuploadBy,
                        taskId: widget.taskId,
                      )));
        },
        onLongPress: () => _eliminarDialog(),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        leading: Container(
          padding: EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(width: 1, color: Colors.grey.shade300),
            ),
          ),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            //https://cdn-icons-png.flaticon.com/512/1010/1010627.png
            radius: 20,
            child: Image.network(widget.isDone
                ? 'https://cdn-icons-png.flaticon.com/512/753/753318.png'
                : 'https://cdn-icons-png.flaticon.com/512/1010/1010627.png'),
          ),
        ),
        title: Text(
          widget.taskTitle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Constants.darkBlue),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.linear_scale_outlined,
              color: Colors.grey.shade400,
            ),
            Text(
              widget.taskDescription,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 15),
            )
          ],
        ),
        trailing: Icon(
          Icons.keyboard_arrow_right_outlined,
          size: 30,
          color: Colors.green.shade600,
        ),
      ),
    );
  }

  _eliminarDialog() {
    User? user = _auth.currentUser;
    final _uid = user!.uid;

    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            actions: [
              TextButton(
                onPressed: () async {
                  try {
                    if (widget.taskuploadBy == _uid) {
                      await FirebaseFirestore.instance
                          .collection('task')
                          .doc(widget.taskId)
                          .delete();
                      await Fluttertoast.showToast(
                          msg: "La tarea fue eliminada",
                          toastLength: Toast.LENGTH_LONG,
                          // gravity: ToastGravity.CENTER,
                          // timeInSecForIosWeb: 1,
                          // backgroundColor: Colors.red,
                          // textColor: Colors.white,
                          fontSize: 18.0,
                          backgroundColor: Colors.grey.shade700);
                      Navigator.canPop(ctx) ? Navigator.pop(ctx) : null;
                    } else {
                      MetodoGlobal.showErrorDialog(
                          error: 'No puede eliminar el registro', ctx: ctx);
                    }
                  } catch (e) {
                    MetodoGlobal.showErrorDialog(
                        error: 'Esta tarea no la puede eliminar', ctx: context);
                  } finally {}
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Eliminar',
                      style: TextStyle(color: Colors.red),
                    )
                  ],
                ),
              )
            ],
          );
        });
  }
}
