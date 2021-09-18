import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app_workos/screen/constants/constants.dart';
import 'package:flutter_firebase_app_workos/screen/tareas_screen.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late TextEditingController _fullnameTextController =
      TextEditingController(text: '');
  late TextEditingController _emailTextController =
      TextEditingController(text: '');
  late TextEditingController _passTextController =
      TextEditingController(text: '');
  late TextEditingController _positionCPTextController =
      TextEditingController(text: '');
  late TextEditingController _numeroContactoController =
      TextEditingController(text: '');

  FocusNode _emailfocusNode = FocusNode();
  FocusNode _passfocusNode = FocusNode();
  FocusNode _positionfocusNode = FocusNode();
  FocusNode _numeroContactofocusNode = FocusNode();

  bool _obscureText = true;
  final _signUpFromKey = GlobalKey<FormState>();

  File? imageFiel;

  @override
  void dispose() {
    _animationController.dispose();
    _fullnameTextController.dispose();
    _emailTextController.dispose();
    _passTextController.dispose();
    _positionCPTextController.dispose();
    _numeroContactoController.dispose();
    _emailfocusNode.dispose();
    _passfocusNode.dispose();
    _positionfocusNode.dispose();
    _numeroContactofocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 20),
    );
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.linear)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((animationStatus) {
            if (animationStatus == AnimationStatus.completed) {
              _animationController.reset();
              _animationController.forward();
            }
          });
    _animationController.forward();

    super.initState();
  }

  void _submitFormOnSignUp() {
    final isValid = _signUpFromKey.currentState!.validate();
    // print(':Es Valido $isValid');
    if (isValid) {}
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          CachedNetworkImage(
            imageUrl:
                "https://images.pexels.com/photos/5412270/pexels-photo-5412270.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
            placeholder: (context, url) => Image.asset(
              'assets/images/wallpaper.jpg',
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            alignment: FractionalOffset(_animation.value, 0),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: ListView(
              children: [
                SizedBox(
                  height: size.height * 0.1,
                ),
                Text(
                  'Regístrate ahora',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 35),
                ),
                SizedBox(height: 10),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Ya tienes cuenta ',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      TextSpan(text: '  '),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Navigator.canPop(context)
                              ? Navigator.pop(context)
                              : null,
                        text: 'Login ',
                        style: TextStyle(
                            // decoration: TextDecoration.underline,
                            color: Colors.green.shade700,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Form(
                  key: _signUpFromKey,
                  child: Column(
                    children: [
                      //Full name
                      Row(
                        children: [
                          Flexible(
                            flex: 2,
                            child: TextFormField(
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () => FocusScope.of(context)
                                  .requestFocus(_emailfocusNode),
                              keyboardType: TextInputType.name,
                              controller: _fullnameTextController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Por favor ingrese su nombre';
                                } else {
                                  return null;
                                }
                              },
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  hintText: 'Nombre',
                                  hintStyle: TextStyle(color: Colors.white),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  errorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  )),
                            ),
                          ),
                          Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  width: size.width * 0.30,
                                  height: size.height * 0.15,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: imageFiel == null
                                        ? Image.network(
                                            'https://cdn-icons-png.flaticon.com/512/149/149071.png',
                                            fit: BoxFit.fill)
                                        : Image.file(
                                            imageFiel!,
                                            fit: BoxFit.fill,
                                          ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: InkWell(
                                  onTap: () {
                                    print('Show imagen picker dialog');
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.green.shade400,
                                      border: Border.all(
                                          width: 2, color: Colors.white),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        imageFiel == null
                                            ? Icons.add_a_photo
                                            : Icons.edit_outlined,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      //Email
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () =>
                            FocusScope.of(context).requestFocus(_passfocusNode),
                        focusNode: _emailfocusNode,
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailTextController,
                        validator: (value) {
                          if (value!.isEmpty || !value.contains('@')) {
                            return 'Por favor ingrese un correo valido';
                          } else {
                            return null;
                          }
                        },
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            hintText: 'Correo electronico',
                            hintStyle: TextStyle(color: Colors.white),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            )),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      //Password
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => FocusScope.of(context)
                            .requestFocus(_numeroContactofocusNode),
                        focusNode: _passfocusNode,
                        obscureText: _obscureText,
                        keyboardType: TextInputType.visiblePassword,
                        controller: _passTextController,
                        validator: (value) {
                          if (value!.isEmpty || value.length < 7) {
                            return 'Por favor ingrese una contraseña valida';
                          } else {
                            return null;
                          }
                        },
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              child: Icon(
                                _obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.white,
                              ),
                            ),
                            hintText: 'Contraseña',
                            hintStyle: TextStyle(color: Colors.white),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            )),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      //Numero de telefono
                      TextFormField(
                        focusNode: _numeroContactofocusNode,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => FocusScope.of(context)
                            .requestFocus(_positionfocusNode),
                        keyboardType: TextInputType.phone,
                        controller: _numeroContactoController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Por favor ingrese su nombre';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (v) {
                          print(
                              'Numero de Telefono: ${_numeroContactoController.text}');
                        },
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            hintText: 'Numero de contacto',
                            hintStyle: TextStyle(color: Colors.white),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            )),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      //Position
                      GestureDetector(
                        onTap: () {
                          _MostrarCategoriaTareas(size: size);
                        },
                        child: TextFormField(
                          enabled: false,
                          textInputAction: TextInputAction.done,
                          onEditingComplete: () => _submitFormOnSignUp(),
                          focusNode: _positionfocusNode,
                          keyboardType: TextInputType.name,
                          controller: _positionCPTextController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor ingrese una posicion';
                            } else {
                              return null;
                            }
                          },
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Posicion en la compañia',
                            hintStyle: TextStyle(color: Colors.white),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            disabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                MaterialButton(
                  color: Colors.green.shade300,
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  onPressed: () {
                    // _submitFormOnSignUp();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TareasScreen()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Crear cuenta',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Icon(
                          Icons.person_add,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _MostrarCategoriaTareas({required Size size}) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text(
              'Escoge una posición',
              style: TextStyle(fontSize: 20, color: Colors.green.shade500),
            ),
            content: Container(
              width: size.width * 0.8,
              child: ListView.builder(
                  itemCount: Constants.listaTrabajos.length,
                  shrinkWrap: true,
                  itemBuilder: (ctxx, index) {
                    return InkWell(
                      onTap: () {
                        // print(
                        //     'Constants.CategoriaTareas[index] ${Constants.CategoriaTareas[index]}');
                        setState(() {
                          _positionCPTextController.text =
                              Constants.listaTrabajos[index];
                        });
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.work_outline,
                            color: Colors.green.shade500,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              Constants.listaTrabajos[index],
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
