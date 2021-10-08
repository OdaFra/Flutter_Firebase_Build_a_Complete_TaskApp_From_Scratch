import 'package:flutter/material.dart';
import 'package:flutter_firebase_app_workos/screen/constants/constants.dart';
import 'package:flutter_firebase_app_workos/screen/views/perfil.dart';
import 'package:url_launcher/url_launcher.dart';

class TodosColaboradoresWidgets extends StatefulWidget {
  final String userID;
  final String userName;
  final String userEmail;
  final String positionCompany;
  final String phoneNumber;
  final String userImageUrl;

  const TodosColaboradoresWidgets(
      {required this.userID,
      required this.userName,
      required this.userEmail,
      required this.positionCompany,
      required this.phoneNumber,
      required this.userImageUrl});

  @override
  _TodosColaboradoresWidgetsState createState() =>
      _TodosColaboradoresWidgetsState();
}

class _TodosColaboradoresWidgetsState extends State<TodosColaboradoresWidgets> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: ListTile(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => PerfilViews(userID: widget.userID),
              ),
            );
          },
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
              child: Image.network(widget.userImageUrl == null
                  ? 'https://cdn-icons-png.flaticon.com/512/149/149071.png'
                  : widget.userImageUrl),
            ),
          ),
          title: Text(
            widget.userName,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Constants.darkBlue),
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
                '${widget.positionCompany}- ${widget.phoneNumber}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 15),
              )
            ],
          ),
          trailing: IconButton(
            onPressed: () {
              _mailto();
            },
            icon: Icon(
              Icons.mail_outline,
              size: 30,
              color: Colors.green.shade600,
            ),
          )),
    );
  }

  // Para enviar Correo
  void _mailto() async {
    var emailurl = 'mailto:${widget.userEmail}';
    if (await canLaunch(emailurl)) {
      await launch(emailurl);
    } else {
      print('Error');
      throw 'Ah ocurrido un error';
    }
  }
}
