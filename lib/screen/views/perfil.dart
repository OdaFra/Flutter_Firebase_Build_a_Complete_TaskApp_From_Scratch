import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app_workos/screen/auth/accesso_login.dart';
import 'package:flutter_firebase_app_workos/user_state.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:flutter_firebase_app_workos/screen/constants/constants.dart';
import 'package:flutter_firebase_app_workos/screen/widgets/drawer_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class PerfilViews extends StatefulWidget {
  final String userID;

  const PerfilViews({required this.userID});
  @override
  _PerfilViewsState createState() => _PerfilViewsState();
}

class _PerfilViewsState extends State<PerfilViews> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var _titletextStyle = TextStyle(
      fontSize: 18, fontStyle: FontStyle.normal, fontWeight: FontWeight.bold);

  var _contentTextStyle = TextStyle(
      color: Constants.darkBlue,
      fontSize: 16,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.bold);

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  bool _isLoading = false;
  String phoneNumber = '';
  String email = '';
  String? name;
  String job = '';
  String imageUrl = '';
  String joinedAt = '';
  bool _isSameUser = false;

  void getUserData() async {
    try {
      _isLoading = true;
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userID)
          .get();
      if (userDoc == null) {
        return;
      } else {
        setState(() {
          email = userDoc.get('email');
          name = userDoc.get('name');
          job = userDoc.get('posicionCompany');
          phoneNumber = userDoc.get('phoneNumber');
          imageUrl = userDoc.get('userImage');
          Timestamp joinedAtTimeStamp = userDoc.get('createAT');
          var joinedDate = joinedAtTimeStamp.toDate();
          joinedAt = '${joinedDate.day}/${joinedDate.month}/${joinedDate.year}';
        });
        User? user = _auth.currentUser;
        final _uid = user!.uid;
        setState(() {
          _isSameUser = _uid == widget.userID;
        });
      }
    } catch (e) {} finally {
      _isLoading = false;
    }
  }

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
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
                              '$name :' == null ? 'Nombre' : name!,
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
                              '$job desde : $joinedAt',
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
                              'Informacion Contacto',
                              style: _titletextStyle,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: userInfo(title: 'Email:', content: '$email'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: userInfo(
                                title: 'Telefono:', content: '$phoneNumber'),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          _isSameUser
                              ? Container()
                              : Divider(
                                  thickness: 1,
                                ),
                          SizedBox(
                            height: 15,
                          ),
                          _isSameUser
                              ? Container()
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    _contact(
                                        color: Colors.green,
                                        fct: () {
                                          openWhatsapp();
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
                          !_isSameUser
                              ? Container()
                              : Divider(
                                  thickness: 1,
                                ),
                          SizedBox(
                            height: 15,
                          ),
                          !_isSameUser
                              ? Container()
                              : Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 30),
                                    child: MaterialButton(
                                      color: Colors.green.shade300,
                                      elevation: 8,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      onPressed: () {
                                        _auth.signOut();
                                        // Navigator.pop(context);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UserState()));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 14),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                            image: DecorationImage(
                                image: NetworkImage(imageUrl == null
                                    ? 'https://cdn-icons-png.flaticon.com/512/149/149071.png'
                                    : imageUrl),
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
  void openWhatsapp() async {
    var url = 'https://wa.me/$phoneNumber?text=HolaMundo';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Error');
      throw 'Ah ocurrido un error';
    }
  }

// Para enviar Correo
  void _mailto() async {
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
