import 'dart:async';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gmaps_demo/Screens/User/bookingPage.dart';
import 'package:gmaps_demo/Screens/User/helpScreen.dart';
import 'package:gmaps_demo/Screens/User/tripList.dart';
import 'package:gmaps_demo/Screens/User/userFeedback.dart';
import 'package:gmaps_demo/Widgets/HomeTabs.dart';
import 'package:gmaps_demo/Widgets/appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _name;
  var _empId;

  Future getEmpId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _empId = prefs.getString('EmpID');
    _name = prefs.getString('Name');
    Timer(Duration(seconds: 4), () {
      retrieveData();
    });
  }

  @override
  void initState() {
    super.initState();
    getEmpId();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: CustomAppBar(context),

      /**
       *  Custom Drawer
       */
      // drawer: customDrawer(context, _name == null ? "User" : _name),
      body: Column(
        children: [
          /**
           *    Car and Cab Booking
           */
          SizedBox(
            height: 70,
          ),
          Row(
            children: [
              Expanded(
                child: new Container(
                    margin: const EdgeInsets.only(left: 30.0, right: 30.0),
                    child: Divider(
                      color: Colors.black,
                      height: 36,
                    )),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Choose a vehicle?",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 20,
                  ),
                ),
              ),
              Expanded(
                child: new Container(
                    margin: const EdgeInsets.only(left: 20.0, right: 30.0),
                    child: Divider(
                      color: Colors.black,
                      height: 36,
                    )),
              ),
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                homeTab(
                    context,
                    20,
                    90,
                    MediaQuery.of(context).size.height / 5,
                    MediaQuery.of(context).size.width / 5,
                    'assets/icons/sport-car.png',
                    "Cab", () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TripBooking(
                          vehicle: "CAR",
                        ),
                      ),
                    );
                  });
                }),
                homeTab(
                    context,
                    20,
                    90,
                    MediaQuery.of(context).size.height / 5,
                    MediaQuery.of(context).size.width / 5,
                    'assets/icons/ambulance.png',
                    "Ambulance", () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TripBooking(
                          vehicle: "AMBULANCE",
                        ),
                      ),
                    );
                  });
                }),
              ],
            ),
          ),
          Divider(
            thickness: 3,
            indent: 30,
            endIndent: 30,
          ),

          /**
           *    Report, Help, Feedback
           *    Not Implemented
           */

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                homeTab(
                    context,
                    20,
                    90,
                    MediaQuery.of(context).size.height / 5,
                    MediaQuery.of(context).size.width / 5,
                    'assets/icons/data.png',
                    "Trip History", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TripList(empId: _empId),
                    ),
                  );
                }),
                homeTab(
                    context,
                    20,
                    90,
                    MediaQuery.of(context).size.height / 5,
                    MediaQuery.of(context).size.width / 5,
                    'assets/icons/help.png',
                    "Help", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HelpScreen(),
                    ),
                  );
                }),
                homeTab(
                    context,
                    20,
                    90,
                    MediaQuery.of(context).size.height / 5,
                    MediaQuery.of(context).size.width / 5,
                    'assets/icons/exit.png',
                    "Logout", () {
                  logOut();
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('Name');
    await prefs.remove('PhoneNum');
    await prefs.remove('EmpID');
    await prefs.remove('Role');
    Navigator.of(context).pushReplacementNamed('/login');
  }

  Future refreshData() async {
    await Future.delayed(
      Duration(seconds: 3),
    );
    setState(() {
      retrieveData();
    });
  }

  Future retrieveData() async {
    var res = await Dio().post(
        'https://cab-server.herokuapp.com/trip/viewTrips',
        data: {"empId": _empId});

    return res.data["msg"];
  }
}
