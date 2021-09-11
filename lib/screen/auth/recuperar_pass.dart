import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app_workos/screen/auth/register.dart';

class RecuperarPass extends StatefulWidget {
  RecuperarPass({Key? key}) : super(key: key);

  @override
  _RecuperarPassState createState() => _RecuperarPassState();
}

class _RecuperarPassState extends State<RecuperarPass>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late TextEditingController _recuperarpassTextController =
      TextEditingController(text: '');

  @override
  void dispose() {
    _animationController.dispose();
    _recuperarpassTextController.dispose();

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

  void _recuperarPassFTC() {}

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
                  'Recuperar Contraseña',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 35),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Correo Electronico',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20),
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
                    _recuperarPassFTC();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Resetear ahora',
                          style: TextStyle(
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
