import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gmaps_demo/Screens/Admin/tripOrder.dart';
import 'package:gmaps_demo/Screens/User/bookingPage.dart';
import 'package:gmaps_demo/Screens/User/tripList.dart';
import 'package:gmaps_demo/Widgets/HomeTabs.dart';
import 'package:gmaps_demo/Widgets/appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminHomeScreen extends StatefulWidget {
  var empId;

  AdminHomeScreen({this.empId});
  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  var _empId;
  var _name;

  Future getEmpId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _empId = prefs.getString('EmpID');
    _name = prefs.getString('Name');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEmpId();
    retrieveData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: CustomAppBar(context),

      /**
       *  Custom Drawer
       */
      body: Column(
        children: [
          /**
           *    Car and Cab Booking
           */
          SizedBox(
            height: 70,
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
                    "Cab Booking", () {
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
                SizedBox(
                  width: 30,
                ),
                homeTab(
                    context,
                    20,
                    90,
                    MediaQuery.of(context).size.height / 5,
                    MediaQuery.of(context).size.width / 5,
                    'assets/icons/ambulance.png',
                    "Ambulance Booking", () {
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
                    'assets/icons/confirmation.png',
                    "Trip Confirmation", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TripOrder(
                        empId: _empId,
                      ),
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
                  setState(() {
                    logOut();
                  });
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

  Future<void> refreshData() async {
    await Future.delayed(
      Duration(seconds: 1),
    );
    setState(() {
      retrieveData();
    });
  }

  Future<void> retrieveData() async {
    var res =
        await Dio().get('https://cab-server.herokuapp.com/trip/viewAllTrips');

    if (res.data["status"]) {
      return res.data['msg'];
    } else {
      print(res.data["msg"]);
    }
  }
}
