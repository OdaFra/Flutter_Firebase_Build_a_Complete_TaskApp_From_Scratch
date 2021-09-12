import 'package:flutter/material.dart';

class TareasWidgets extends StatefulWidget {
  @override
  _TareasWidgetsState createState() => _TareasWidgetsState();
}

class _TareasWidgetsState extends State<TareasWidgets> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: ListTile(
        onTap: () {},
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
            child: Image.network(
                'https://cdn-icons-png.flaticon.com/512/753/753318.png'),
          ),
        ),
        title: Text(
          'Title',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontWeight: FontWeight.bold),
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
              'Descripcion de las Tareas,referente a los puntos a realizar',
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
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            actions: [
              TextButton(
                onPressed: () {},
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
