import 'package:flutter/material.dart';
import 'package:flutter_firebase_app_workos/screen/constants/constants.dart';

class DetallesTareasView extends StatefulWidget {
  @override
  _DetallesTareasViewState createState() => _DetallesTareasViewState();
}

class _DetallesTareasViewState extends State<DetallesTareasView> {
  var _textStyle = TextStyle(
    color: Constants.darkBlue,
    fontSize: 15,
    fontWeight: FontWeight.normal,
  );
  var _tituloStyle = TextStyle(
      color: Colors.green.shade400, fontWeight: FontWeight.bold, fontSize: 15);

  var _titStyle = TextStyle(
      color: Constants.darkBlue, fontWeight: FontWeight.bold, fontSize: 15);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              'Titulo',
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
                                  image: NetworkImage(
                                      'https://cdn-icons-png.flaticon.com/512/149/149071.png'),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Nombre : ', style: _textStyle),
                              Text('Cargo : ', style: _textStyle)
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
                          Text(' 25/09/21', style: _textStyle),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Fecha limite :', style: _titStyle),
                          SizedBox(width: 3),
                          Text(' 25/10/21',
                              style: TextStyle(
                                  color: Colors.red.shade400,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15)),
                        ],
                      ),
                      SizedBox(height: 10),
                      Center(
                        child: Text(' Todavia tienes tiempo',
                            style: TextStyle(
                                color: Colors.green.shade600,
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                      ),
                      _dividerWidget(),
                      Text('Estado :', style: _titStyle),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {},
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
                            opacity: 1,
                            child: Icon(
                              Icons.check_box,
                              color: Colors.green.shade400,
                            ),
                          ),
                          SizedBox(width: 40),
                          TextButton(
                            onPressed: () {},
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
                            opacity: 0,
                            child: Icon(
                              Icons.check_box,
                              color: Colors.red.shade400,
                            ),
                          )
                        ],
                      ),
                      _dividerWidget(),
                      Text('Detalle Tarea :', style: _titStyle),
                      Text('Descripcion : ', style: _textStyle),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: MaterialButton(
                          color: Colors.green.shade300,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 14),
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
