import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      setState(() {
        Navigator.of(context).pushReplacementNamed('/splash2');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Color(0xffFFF5D0),
        child: Center(
          child: Image(
            image: AssetImage('assets/icons/taxi.png'),
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width / 2,
          ),
        ),
      ),
    );
  }
}
