import 'package:flutter/material.dart';
import 'package:flutter_firebase_app_workos/screen/constants/constants.dart';

class CrearTareas extends StatefulWidget {
  @override
  _CrearTareasState createState() => _CrearTareasState();
}

class _CrearTareasState extends State<CrearTareas> {
  TextEditingController _categoriaTareaController =
      TextEditingController(text: 'Elija una categoria');
  TextEditingController _tituloTareaController = TextEditingController();
  TextEditingController _descripcionTareaController = TextEditingController();
  TextEditingController _fechaTareaController =
      TextEditingController(text: 'Elija una fecha');

  @override
  void dispose() {
    super.dispose();
    _categoriaTareaController.dispose();
    _tituloTareaController.dispose();
    _descripcionTareaController.dispose();
    _fechaTareaController.dispose();
  }

  Constants _constants = Constants();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50, right: 10, left: 10),
        child: SingleChildScrollView(
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
                      _textFormField(
                          valueKey: 'Categoriatareas',
                          controller: _categoriaTareaController,
                          enabled: false,
                          fct: () {},
                          maxLength: 100),
                      //
                      _textField(label: 'Titulo de la Tarea*'),
                      _textFormField(
                          valueKey: 'Titulotarea',
                          controller: _tituloTareaController,
                          enabled: true,
                          fct: () {},
                          maxLength: 100),
                      //
                      _textField(label: 'Descripcion de la Tarea'),
                      _textFormField(
                          valueKey: 'descripciontareas',
                          controller: _descripcionTareaController,
                          enabled: true,
                          fct: () {},
                          maxLength: 1000),
                      //
                      _textField(label: 'Fecha de Tareas*'),
                      _textFormField(
                          valueKey: 'fechatareas',
                          controller: _fechaTareaController,
                          enabled: false,
                          fct: () {},
                          maxLength: 100)
                    ],
                  )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textFormField({
    required String valueKey,
    required TextEditingController controller,
    required bool enabled,
    required Function fct,
    required int maxLength,
  }) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: () {
          fct();
        },
        child: TextFormField(
          controller: controller,
          enabled: enabled,
          // initialValue: 'Categoria de la tarea',
          key: ValueKey(valueKey),
          style: TextStyle(
            color: _constants.darkBlue,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
          maxLines: valueKey == 'descripciontareas' ? 3 : 1,
          maxLength: maxLength,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            filled: true,
            fillColor: Theme.of(context).scaffoldBackgroundColor,
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green.shade400),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            errorBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
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
