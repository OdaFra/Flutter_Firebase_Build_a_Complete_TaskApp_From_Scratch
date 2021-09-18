import 'package:flutter/material.dart';
import 'package:flutter_firebase_app_workos/screen/constants/constants.dart';

class TodosColaboradoresWidgets extends StatefulWidget {
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
          onTap: () {},
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
              child: Image.network(
                  'https://cdn-icons-png.flaticon.com/512/149/149071.png'),
            ),
          ),
          title: Text(
            'Nombre Colaborador',
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
                'Cargo actual - +595981 888825',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 15),
              )
            ],
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.mail_outline,
              size: 30,
              color: Colors.green.shade600,
            ),
          )),
    );
  }
}
