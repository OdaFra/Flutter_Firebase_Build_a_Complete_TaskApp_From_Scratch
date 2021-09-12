import 'package:flutter/material.dart';
import 'package:flutter_firebase_app_workos/screen/widgets/drawer_widgets.dart';
import 'package:flutter_firebase_app_workos/screen/widgets/tareas_widgets.dart';

class TareasScreen extends StatefulWidget {
  @override
  _TareasScreenState createState() => _TareasScreenState();
}

class _TareasScreenState extends State<TareasScreen> {
  List<String> CategoriaTareas = [
    'Comercial',
    'Desarrollo',
    'Ingenieria',
    'Recursos Humanos',
    'Marketing',
    'Diseño',
    'Atención al cliente'
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: DrawerWidgets(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black45),
        // leading: Builder(builder: (ctx) {
        //   return IconButton(
        //       onPressed: () {
        //         Scaffold.of(ctx).openDrawer();
        //       },
        //       icon: Icon(
        //         Icons.menu_outlined,
        //         color: Colors.black45,
        //       ));
        // }),
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Tareas',
          style: TextStyle(
            color: Colors.green.shade500,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          IconButton(
              onPressed: () {
                _MostrarCategoriaTareas(size: size);
              },
              icon: Icon(
                Icons.filter_list_outlined,
                color: Colors.black45,
              )),
        ],
      ),
      body: ListView.builder(itemBuilder: (ctx, index) {
        return TareasWidgets();
      }),
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
                  itemCount: CategoriaTareas.length,
                  shrinkWrap: true,
                  itemBuilder: (ctxx, index) {
                    return InkWell(
                      onTap: () {},
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
                              CategoriaTareas[index],
                              style: TextStyle(
                                  fontSize: 18, fontStyle: FontStyle.italic),
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
                  SizedBox(
                    width: 8,
                  ),
                  TextButton(onPressed: () {}, child: Text('Cancelar filtro'))
                ],
              )
            ],
          );
        });
  }
}
