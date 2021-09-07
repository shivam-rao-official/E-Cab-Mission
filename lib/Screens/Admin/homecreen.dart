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
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
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

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                  SizedBox(
                    width: 30,
                  ),
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
                  SizedBox(
                    width: 30,
                  ),
                  homeTab(
                      context,
                      20,
                      90,
                      MediaQuery.of(context).size.height / 5,
                      MediaQuery.of(context).size.width / 5,
                      'assets/icons/positive-vote.png',
                      "Feedback", () {
                    Navigator.of(context).pushNamed('/account');
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30.0),
        child: FloatingActionButton.extended(
          onPressed: () {
            setState(() {
              logOut();
              Navigator.of(context).pushReplacementNamed('/login');
            });
          },
          label: Text(
            "Logout",
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          backgroundColor: Color(0xff233d4d),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   // TODO: implement build
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text(
  //         "Trip Details",
  //         style: TextStyle(
  //           color: Colors.black,
  //           fontWeight: FontWeight.bold,
  //           fontFamily: "Satisfy",
  //         ),
  //       ),
  //       iconTheme: IconThemeData(color: Colors.black),
  //       centerTitle: true,
  //       backgroundColor: Colors.white,
  //       elevation: 0,
  //     ),
  //     drawer: customDrawer(context, _name == null ? "Admin" : _name),
  //     body: RefreshIndicator(
  //       onRefresh: refreshData,
  //       backgroundColor: Colors.black87,
  //       strokeWidth: 3,
  //       child: FutureBuilder(
  //         builder: (context, snapshot) {
  //           if (snapshot.connectionState == ConnectionState.waiting) {
  //             return Center(child: CircularProgressIndicator());
  //           }
  //           if (snapshot.connectionState == ConnectionState.done) {
  //             if (snapshot.hasError) {
  //               return Center(
  //                 child: Text('Oops some has occured'),
  //               );
  //             }
  //             if (!snapshot.hasData)
  //               return Center(
  //                 child: Text("No Data in the DB"),
  //               );
  //             return ListView.builder(
  //                 itemCount: snapshot.data.length,
  //                 itemBuilder: (context, index) {
  //                   return snapshot.data[index]['confirmed']
  //                       ? Padding(
  //                           padding: const EdgeInsets.all(8.0),
  //                           child: ListTile(
  //                             tileColor: Colors.green[50],
  //                             title: Row(
  //                               children: [
  //                                 Row(
  //                                   children: [
  //                                     Text("Origin ->"),
  //                                     SizedBox(width: 10),
  //                                     Text(snapshot.data[index]['origin']),
  //                                   ],
  //                                 ),
  //                                 Spacer(),
  //                                 Row(
  //                                   children: [
  //                                     Text("Destination ->"),
  //                                     SizedBox(width: 10),
  //                                     Text(snapshot.data[index]['destination']),
  //                                   ],
  //                                 ),
  //                               ],
  //                             ),
  //                             subtitle: Row(
  //                               children: [
  //                                 Row(
  //                                   children: [
  //                                     Text("Employee ID ->"),
  //                                     SizedBox(width: 10),
  //                                     Text(snapshot.data[index]['empId']),
  //                                   ],
  //                                 ),
  //                                 Spacer(),
  //                                 Row(
  //                                   children: [
  //                                     Text("Raised Date ->"),
  //                                     SizedBox(width: 10),
  //                                     Text(snapshot.data[index]['createdAt']),
  //                                   ],
  //                                 ),
  //                               ],
  //                             ),
  //                             onTap: () {
  //                               Navigator.push(
  //                                 context,
  //                                 MaterialPageRoute(
  //                                   builder: (context) => TripSummary(
  //                                     tripId: snapshot.data[index]['_id'],
  //                                   ),
  //                                 ),
  //                               );
  //                               print(snapshot.data[index]['_id']);
  //                             },
  //                           ))
  //                       : Padding(
  //                           padding: const EdgeInsets.all(8.0),
  //                           child: ListTile(
  //                             tileColor: Colors.amber[50],
  //                             title: Row(
  //                               children: [
  //                                 Row(
  //                                   children: [
  //                                     Text("Origin ->"),
  //                                     SizedBox(width: 10),
  //                                     Text(snapshot.data[index]['origin']),
  //                                   ],
  //                                 ),
  //                                 Spacer(),
  //                                 Row(
  //                                   children: [
  //                                     Text("Destination ->"),
  //                                     SizedBox(width: 10),
  //                                     Text(snapshot.data[index]['destination']),
  //                                   ],
  //                                 ),
  //                               ],
  //                             ),
  //                             subtitle: Row(
  //                               children: [
  //                                 Row(
  //                                   children: [
  //                                     Text("Employee ID ->"),
  //                                     SizedBox(width: 10),
  //                                     Text(snapshot.data[index]['empId']),
  //                                   ],
  //                                 ),
  //                                 Spacer(),
  //                                 Row(
  //                                   children: [
  //                                     Text("Raised Date ->"),
  //                                     SizedBox(width: 10),
  //                                     Text(snapshot.data[index]['createdAt']),
  //                                   ],
  //                                 ),
  //                               ],
  //                             ),
  //                             onTap: () {
  //                               Navigator.push(
  //                                 context,
  //                                 MaterialPageRoute(
  //                                   builder: (context) => ConfirmBookScreens(
  //                                     tripId: snapshot.data[index]['_id'],
  //                                   ),
  //                                 ),
  //                               );
  //                             },
  //                           ));
  //                 });
  //           }
  //           return Center(child: Text("No Data Found"));
  //         },
  //         future: retrieveData(),
  //       ),
  //     ),
  //     floatingActionButton: FloatingActionButton.extended(
  //       onPressed: () {
  //         refreshData();
  //       },
  //       label: Text("Refresh"),
  //     ),
  //   );
  // }

  Future logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('Name');
    await prefs.remove('PhoneNum');
    await prefs.remove('EmpID');
    await prefs.remove('Role');
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
