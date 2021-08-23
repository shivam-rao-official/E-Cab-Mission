import 'package:flutter/material.dart';
import 'package:gmaps_demo/Screens/Admin/demo.dart';
import 'package:gmaps_demo/Screens/Admin/homecreen.dart';
import 'package:gmaps_demo/Screens/Login/loginScreen.dart';
import 'package:gmaps_demo/Screens/SignUp/signup.dart';
import 'package:gmaps_demo/Screens/User/bookingPage.dart';
import 'package:gmaps_demo/Screens/User/homecreen.dart';
import 'package:gmaps_demo/Screens/User/splash.dart';
import 'package:gmaps_demo/Screens/User/splash2.dart';
import 'package:gmaps_demo/Screens/User/tripSummary.dart';

import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var EmpID = prefs.getString('EmpID');
  var PhoneNum = prefs.getString('PhoneNum');
  var Name = prefs.getString('Name');
  var role = prefs.getString('Role');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      routes: <String, WidgetBuilder>{
        '/splash2': (BuildContext ctxt) => Splash2(),
        '/login': (BuildContext ctxt) => LoginScreen(),
        '/signup': (BuildContext ctxt) => SignupScreen(),
        '/home': (BuildContext ctxt) => HomeScreen(),
        '/bookTrip': (BuildContext ctxt) => TripBooking(),
        '/tripSummary': (BuildContext ctxt) => TripSummary(),
        '/admin': (BuildContext ctxt) => AdminHomeScreen(),
      },
      home: Splash(),
    );
  }
}
