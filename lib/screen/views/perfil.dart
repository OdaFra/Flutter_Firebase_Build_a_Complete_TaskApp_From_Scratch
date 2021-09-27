import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:flutter_firebase_app_workos/screen/constants/constants.dart';
import 'package:flutter_firebase_app_workos/screen/widgets/drawer_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class PerfilViews extends StatefulWidget {
  @override
  _PerfilViewsState createState() => _PerfilViewsState();
}

class _PerfilViewsState extends State<PerfilViews> {
  var _titletextStyle = TextStyle(
      fontSize: 18, fontStyle: FontStyle.normal, fontWeight: FontWeight.bold);

  var _contentTextStyle = TextStyle(
      color: Constants.darkBlue,
      fontSize: 16,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: DrawerWidgets(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black45),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 0),
          child: Stack(
            children: [
              Card(
                margin: EdgeInsets.all(30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 85,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Nombre :',
                        style: TextStyle(
                            fontSize: 22,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Trabajando desde :',
                        style: _contentTextStyle,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                      ),
                      child: Text(
                        'Contacto :',
                        style: _titletextStyle,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: userInfo(
                          title: 'Email:', content: 'google@google.com'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child:
                          userInfo(title: 'Telefono:', content: '0981888825'),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _contact(
                            color: Colors.green,
                            fct: () {
                              _openWhatsapp();
                            },
                            icon: FontAwesome.whatsapp),
                        _contact(
                            color: Colors.orange,
                            fct: () {
                              _mailto();
                            },
                            icon: Icons.email_outlined),
                        _contact(
                            color: Colors.blue,
                            fct: () {
                              _llamadaNumeroContacto();
                            },
                            icon: Icons.call_outlined),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: MaterialButton(
                          color: Colors.green.shade300,
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Cerrar Sesion',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.login_outlined,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: size.width * 0.30,
                    height: size.width * 0.30,
                    decoration: BoxDecoration(
                      color: Colors.green.shade400,
                      shape: BoxShape.circle,
                      border: Border.all(
                          width: 8,
                          color: Theme.of(context).scaffoldBackgroundColor),
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://cdn-icons-png.flaticon.com/512/149/149071.png'),
                          fit: BoxFit.fill),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

// Para Whatsapp
  void _openWhatsapp() async {
    String phone = '+595981888825';
    var url = 'https://wa.me/$phone?text=HolaMundo';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Error');
      throw 'Ah ocurrido un error';
    }
  }

// Para enviar Correo
  void _mailto() async {
    String email = 'networkernel@gmail.com';
    var emailurl = 'mailto:$email';
    if (await canLaunch(emailurl)) {
      await launch(emailurl);
    } else {
      print('Error');
      throw 'Ah ocurrido un error';
    }
  }

  //Para llamar o contactar
  void _llamadaNumeroContacto() async {
    String phoneNumber = '+595981888825';
    var contacturl = 'tel://$phoneNumber';
    if (await canLaunch(contacturl)) {
      await launch(contacturl);
    } else {
      print('Error');
      throw 'Ah ocurrido un error';
    }
  }

  Widget _contact(
      {required Color color, required Function fct, required IconData icon}) {
    return CircleAvatar(
      backgroundColor: color,
      radius: 25,
      child: CircleAvatar(
          radius: 23,
          backgroundColor: Colors.white,
          child: IconButton(
            icon: Icon(
              icon,
              color: color,
            ),
            onPressed: () {
              fct();
            },
          )),
    );
  }

  Widget userInfo({required String title, required String content}) {
    return Row(
      children: [
        Text(
          title,
          style: _titletextStyle,
        ),
        SizedBox(
          width: 5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            content,
            style: _contentTextStyle,
          ),
        )
      ],
    );
  }
}
