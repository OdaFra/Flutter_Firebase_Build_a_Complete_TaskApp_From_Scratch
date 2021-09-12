import 'package:flutter/material.dart';
import 'package:flutter_firebase_app_workos/screen/constants/constants.dart';

class CrearTareas extends StatefulWidget {
  @override
  _CrearTareasState createState() => _CrearTareasState();
}

class _CrearTareasState extends State<CrearTareas> {
  Constants _constants = Constants();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50, right: 10, left: 10),
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Todos los campos son obligatorios',
                    style: TextStyle(
                        color: _constants.darkBlue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Divider(
                thickness: 1,
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                    child: Column(
                  children: [
                    _textField(label: 'Categorias de Tareas*'),
                    TextFormField(
                        // controller: ,
                        enabled: true,
                        key: ValueKey(''),
                        style: TextStyle(color: _constants.darkBlue),
                        maxLines: 3,
                        maxLength: 20,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Theme.of(context).scaffoldBackgroundColor,
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.green.shade400),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                        ))

                    // _textField(label: 'Categorias de Tareas*'),
                    // _textField(label: 'Categorias de Tareas*'),
                    // _textField(label: 'Categorias de Tareas*'),
                  ],
                )),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _textField({
    required String label,
  }) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Text(
        label,
        style: TextStyle(
            color: Colors.green.shade400,
            fontSize: 16,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
