import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase_app_workos/screen/constants/constants.dart';
import 'package:flutter_firebase_app_workos/screen/widgets/comentarios.dart';
import 'package:flutter_firebase_app_workos/services/metodos_globales.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

class DetallesTareasView extends StatefulWidget {
  final String uploadedBy;
  final String taskId;
  const DetallesTareasView({required this.uploadedBy, required this.taskId});
  @override
  _DetallesTareasViewState createState() => _DetallesTareasViewState();
}

class _DetallesTareasViewState extends State<DetallesTareasView> {
  var _textStyle = TextStyle(
      color: Constants.darkBlue, fontSize: 15, fontWeight: FontWeight.normal);
  var _tituloStyle = TextStyle(
      color: Colors.green.shade400, fontWeight: FontWeight.bold, fontSize: 15);

  var _titStyle = TextStyle(
      color: Constants.darkBlue, fontWeight: FontWeight.bold, fontSize: 15);

  TextEditingController _comentarioController = TextEditingController();

  bool _isComentario = false;

  String? authorName;
  String? authorPosition;
  String? taskCategory;
  String? taskDescription;
  String? taskTitle;

  String? userImageUrl;
  bool? _isDone;
  Timestamp? postedDateTimeStamp;
  Timestamp? deadlinDateTimeStamp;
  String? postedDate;
  String? deadlineDate;
  bool isDeadlineAvailable = false;

  @override
  void initState() {
    super.initState();
    getTaskData();
  }

  void getTaskData() async {
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.uploadedBy)
        .get();
    if (userDoc == null) {
      return;
    } else {
      setState(() {
        authorName = userDoc.get('name');
        authorPosition = userDoc.get('posicionCompany');
        userImageUrl = userDoc.get('userImage');
      });
    }
    final DocumentSnapshot taskDatabase = await FirebaseFirestore.instance
        .collection('task')
        .doc(widget.taskId)
        .get();
    if (taskDatabase == null) {
      return;
    } else {
      setState(() {
        taskTitle = taskDatabase.get('taskTitle');
        taskDescription = taskDatabase.get('taskDescription');
        _isDone = taskDatabase.get('isDone');
        postedDateTimeStamp = taskDatabase.get('createAt');
        deadlinDateTimeStamp = taskDatabase.get('deadlineDateTimeStamp');
        deadlineDate = taskDatabase.get('deadlineDate');
        var postDate = postedDateTimeStamp!.toDate();
        postedDate = '${postDate.day}-${postDate.month}-${postDate.year}';
      });
      var date = postedDateTimeStamp!.toDate();
      isDeadlineAvailable = date.isAfter(DateTime.now());
    }
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Volver',
            style: TextStyle(
                color: Colors.green.shade400,
                fontSize: 20,
                fontStyle: FontStyle.italic),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 15),
            Text(
              taskTitle == null ? '' : taskTitle!,
              style: TextStyle(
                  color: Colors.green.shade400,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Publicado por',
                            style: _tituloStyle,
                          ),
                          Spacer(),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 3,
                                color: Colors.green.shade400,
                              ),
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(userImageUrl == null
                                      ? 'https://cdn-icons-png.flaticon.com/512/149/149071.png'
                                      : userImageUrl!),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                authorName == null ? '' : authorName!,
                                style: _textStyle,
                              ),
                              Text(
                                authorPosition == null ? '' : authorPosition!,
                                style: _textStyle,
                              )
                            ],
                          ),
                        ],
                      ),
                      _dividerWidget(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Publicado el :', style: _titStyle),
                          SizedBox(width: 3),
                          Text(
                            postedDate == null ? '' : postedDate!,
                            style: _textStyle,
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Fecha limite :', style: _titStyle),
                          SizedBox(width: 3),
                          Text(deadlineDate == null ? '' : deadlineDate!,
                              style: TextStyle(
                                  color: Colors.red.shade400,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15)),
                        ],
                      ),
                      SizedBox(height: 10),
                      Center(
                        child: Text(
                            isDeadlineAvailable
                                ? ' El tiempo ya ha culminado'
                                : ' Todavia tienes tiempo',
                            style: TextStyle(
                                color: isDeadlineAvailable
                                    ? Colors.red.shade600
                                    : Colors.green.shade600,
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                      ),
                      _dividerWidget(),
                      Text('Estado :', style: _titStyle),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              User? user = _auth.currentUser;
                              final _uid = user!.uid;
                              if (_uid == widget.uploadedBy) {
                                try {
                                  FirebaseFirestore.instance
                                      .collection('task')
                                      .doc(widget.taskId)
                                      .update({'isDone': true});
                                } catch (e) {
                                  MetodoGlobal.showErrorDialog(
                                      error:
                                          'La accion fue realizada con exito!',
                                      ctx: context);
                                }
                              } else {
                                MetodoGlobal.showErrorDialog(
                                    error: 'No puedes realizar esta acción',
                                    ctx: context);
                              }
                              getTaskData();
                            },
                            child: Text(
                              'Hecho ',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                decoration: TextDecoration.underline,
                                color: Constants.darkBlue,
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Opacity(
                            opacity: _isDone == true ? 1 : 0,
                            child: Icon(
                              Icons.check_box,
                              color: Colors.green.shade400,
                            ),
                          ),
                          SizedBox(width: 40),
                          TextButton(
                            onPressed: () {
                              User? user = _auth.currentUser;
                              final _uid = user!.uid;
                              if (_uid == widget.uploadedBy) {
                                try {
                                  FirebaseFirestore.instance
                                      .collection('task')
                                      .doc(widget.taskId)
                                      .update({'isDone': false});
                                } catch (e) {
                                  MetodoGlobal.showErrorDialog(
                                      error:
                                          'La accion fue realizada con exito!',
                                      ctx: context);
                                }
                              } else {
                                MetodoGlobal.showErrorDialog(
                                    error: 'No puedes realizar esta acción',
                                    ctx: context);
                              }
                              getTaskData();
                            },
                            child: Text(
                              'No hecho ',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                decoration: TextDecoration.underline,
                                color: Constants.darkBlue,
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Opacity(
                            opacity: _isDone == false ? 1 : 0,
                            child: Icon(
                              Icons.check_box,
                              color: Colors.red.shade400,
                            ),
                          )
                        ],
                      ),
                      _dividerWidget(),
                      Text('Detalle Tarea :', style: _titStyle),
                      SizedBox(
                        height: 10,
                      ),
                      Text(taskDescription == null ? ' ' : taskDescription!,
                          style: _textStyle),
                      SizedBox(
                        height: 40,
                      ),
                      AnimatedSwitcher(
                        duration: Duration(
                          milliseconds: 500,
                        ),
                        child: _isComentario
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    flex: 3,
                                    child: TextField(
                                      controller: _comentarioController,
                                      style: TextStyle(
                                        color: Constants.darkBlue,
                                      ),
                                      maxLength: 200,
                                      keyboardType: TextInputType.text,
                                      maxLines: 6,
                                      decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.green.shade400),
                                          )),
                                    ),
                                  ),
                                  Flexible(
                                      child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                        ),
                                        child: MaterialButton(
                                          color: Colors.green.shade300,
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          onPressed: () async {
                                            if (_comentarioController
                                                    .text.length <
                                                7) {
                                              MetodoGlobal.showErrorDialog(
                                                  error:
                                                      'Por favor ingrese un comentario con mas de 7 caracteres',
                                                  ctx: context);
                                            } else {
                                              final _generatedId = Uuid().v4();
                                              await FirebaseFirestore.instance
                                                  .collection('task')
                                                  .doc(widget.taskId)
                                                  .update({
                                                'taskComents':
                                                    FieldValue.arrayUnion([
                                                  {
                                                    'userId': widget.uploadedBy,
                                                    'commentId': _generatedId,
                                                    'name': authorName,
                                                    'userImageUrl':
                                                        userImageUrl,
                                                    'commentBody':
                                                        _comentarioController
                                                            .text,
                                                    'time': Timestamp.now()
                                                  }
                                                ])
                                              });
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Se ha agregado su comentario",
                                                  toastLength:
                                                      Toast.LENGTH_LONG,
                                                  // gravity: ToastGravity.CENTER,
                                                  // timeInSecForIosWeb: 1,
                                                  // backgroundColor: Colors.red,
                                                  // textColor: Colors.white,
                                                  fontSize: 18.0,
                                                  backgroundColor:
                                                      Colors.grey.shade700);
                                              _comentarioController.clear();
                                            }
                                            setState(() {});
                                          },
                                          child: Text(
                                            'Post',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            setState(() {
                                              _isComentario = !_isComentario;
                                            });
                                          },
                                          child: Text('Cancelar'))
                                    ],
                                  ))
                                ],
                              )
                            : Center(
                                child: MaterialButton(
                                  color: Colors.green.shade300,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  onPressed: () {
                                    setState(() {
                                      _isComentario = !_isComentario;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14),
                                    child: Text(
                                      'Agregar Comentarios',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                  ),
                                ),
                              ),
                      ),
                      SizedBox(height: 40),
                      FutureBuilder<DocumentSnapshot>(
                          future: FirebaseFirestore.instance
                              .collection('task')
                              .doc(widget.taskId)
                              .get(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              if (snapshot.data == null) {
                                return Center(
                                  child: Text(
                                      'No posee ningun comentario esta tarea'),
                                );
                              }
                            }
                            return ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return ComentariosViews(
                                  commentId: snapshot.data!['taskComents']
                                      [index]['commentId'],
                                  commenterId: snapshot.data!['taskComents']
                                      [index]['userId'],
                                  commentBody: snapshot.data!['taskComents']
                                      [index]['commentBody'],
                                  commenterImageUrl:
                                      snapshot.data!['taskComents'][index]
                                          ['userImageUrl'],
                                  commenterName: snapshot.data!['taskComents']
                                      [index]['name'],
                                );
                              },
                              separatorBuilder: (context, index) {
                                return Divider(thickness: 1);
                              },
                              itemCount: snapshot.data!['taskComents'].length,
                            );
                          })
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _dividerWidget() {
    return Column(
      children: [
        SizedBox(height: 10),
        Divider(thickness: 1),
        SizedBox(height: 10),
      ],
    );
  }
}
