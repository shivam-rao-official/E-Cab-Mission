import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gmaps_demo/Widgets/appbar.dart';

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
      // appBar: CustomAppBar(context),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.width / 4,
              child: Image(
                image: AssetImage('assets/icons/ambulance.png'),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "The Mission e-Cab",
              style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Satisfy',
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 40,
                  left: MediaQuery.of(context).size.width / 5,
                  right: MediaQuery.of(context).size.width / 5),
              child: LinearProgressIndicator(
                color: Color(0xff203b62),
              ),
            )
          ],
        ),
      ),
    );
  }
}
