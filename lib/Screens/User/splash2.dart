import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash2 extends StatefulWidget {
  @override
  _Splash2State createState() => _Splash2State();
}

class _Splash2State extends State<Splash2> {
  var _empId;
  var _role;
  @override
  void initState() {
    super.initState();
    getData();
    Timer(Duration(seconds: 3), () {
      _empId == null
          ? Navigator.of(context).pushReplacementNamed('/login')
          : _role == 'admin'
              ? Navigator.of(context).pushReplacementNamed('/admin')
              : Navigator.of(context).pushReplacementNamed('/home');
    });
  }

  Future getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _empId = prefs.getString('EmpID');
    _role = prefs.getString('Role');
    print(_role);
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


/**
 * 
 Center(
          child: Image(
            image: AssetImage('assets/icons/taxi.png'),
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width / 2,
          ),
        ),
 */