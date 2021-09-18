import 'package:flutter/material.dart';
import 'package:flutter_firebase_app_workos/screen/constants/constants.dart';
import 'package:flutter_firebase_app_workos/screen/widgets/drawer_widgets.dart';

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
  final _fromKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _categoriaTareaController.dispose();
    _tituloTareaController.dispose();
    _descripcionTareaController.dispose();
    _fechaTareaController.dispose();
  }

  void _crearTareas() {
    final isValid = _fromKey.currentState!.validate();
    // print(':Es Valido $isValid');
    if (isValid) {
      print('Tarea guardada');
    } else {
      print('Tarea NO guardada');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black45),
      ),
      drawer: DrawerWidgets(),
      body: Padding(
        padding: const EdgeInsets.all(7),
        // const EdgeInsets.only(top: 60, right: 10, left: 10),
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
                          color: Constants.darkBlue,
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
                    key: _fromKey,
                    child: Column(
                      children: [
                        _textField(label: 'Categorias de Tareas*'),
                        _textFormField(
                            valueKey: 'Categoriatareas',
                            controller: _categoriaTareaController,
                            enabled: false,
                            fct: () {
                              _MostrarCategoriaTareas(size: size);
                            },
                            maxLength: 100),
                        //
                        _textField(label: 'Titulo de la Tarea*'),
                        _textFormField(
                            valueKey: 'Titulotarea',
                            controller: _tituloTareaController,
                            enabled: true,
                            fct: () {},
                            maxLength: 20),
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
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: MaterialButton(
                      color: Colors.green.shade300,
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      onPressed: _crearTareas,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Crear Tarea',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Icon(
                              Icons.upload_file_outlined,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
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
          validator: (value) {
            if (value!.isEmpty) {
              return 'Campo vació, por favor ingrese un valor';
            }
            return null;
          },
          controller: controller,
          enabled: enabled,
          // initialValue: 'Categoria de la tarea',
          key: ValueKey(valueKey),
          style: TextStyle(
            color: Constants.darkBlue,
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
                        // print(
                        //     'Constants.CategoriaTareas[index] ${Constants.CategoriaTareas[index]}');
                        setState(() {
                          _categoriaTareaController.text =
                              Constants.CategoriaTareas[index];
                        });
                        Navigator.pop(context);
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
                ],
              )
            ],
          );
        });
  }
}
