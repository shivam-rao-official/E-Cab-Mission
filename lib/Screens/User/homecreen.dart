import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gmaps_demo/Screens/User/tripSummary.dart';
import 'package:gmaps_demo/Widgets/drawer.dart';
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
      appBar: AppBar(
        title: Text(
          "Your Trip List",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: "Satisfy",
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      drawer: customDrawer(context, _name, _empId),
      body: RefreshIndicator(
        onRefresh: refreshData,
        backgroundColor: Colors.black87,
        strokeWidth: 3,
        child: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('Oops some has occured'),
                );
              }
              if (!snapshot.hasData)
                return Center(
                  child: Text("No Data in the DB"),
                );
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return snapshot.data[index]['confirmed']
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              tileColor: Colors.green[50],
                              title: Row(
                                children: [
                                  Row(
                                    children: [
                                      Text("Origin ->"),
                                      SizedBox(width: 10),
                                      Text(snapshot.data[index]['origin']),
                                    ],
                                  ),
                                  Spacer(),
                                  Row(
                                    children: [
                                      Text("Destination ->"),
                                      SizedBox(width: 10),
                                      Text(snapshot.data[index]['destination']),
                                    ],
                                  ),
                                ],
                              ),
                              subtitle: Row(
                                children: [
                                  Row(
                                    children: [
                                      Text("Employee ID ->"),
                                      SizedBox(width: 10),
                                      Text(snapshot.data[index]['empId']),
                                    ],
                                  ),
                                  Spacer(),
                                  Row(
                                    children: [
                                      Text("Raised Date ->"),
                                      SizedBox(width: 10),
                                      Text(snapshot.data[index]['createdAt']),
                                    ],
                                  ),
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TripSummary(
                                      tripId: snapshot.data[index]['_id'],
                                    ),
                                  ),
                                );
                              },
                            ))
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              tileColor: Colors.amber[50],
                              title: Row(
                                children: [
                                  Row(
                                    children: [
                                      Text("Origin ->"),
                                      SizedBox(width: 10),
                                      Text(snapshot.data[index]['origin']),
                                    ],
                                  ),
                                  Spacer(),
                                  Row(
                                    children: [
                                      Text("Destination ->"),
                                      SizedBox(width: 10),
                                      Text(snapshot.data[index]['destination']),
                                    ],
                                  ),
                                ],
                              ),
                              subtitle: Row(
                                children: [
                                  Row(
                                    children: [
                                      Text("Employee ID ->"),
                                      SizedBox(width: 10),
                                      Text(snapshot.data[index]['empId']),
                                    ],
                                  ),
                                  Spacer(),
                                  Row(
                                    children: [
                                      Text("Raised Date ->"),
                                      SizedBox(width: 10),
                                      Text(snapshot.data[index]['createdAt']),
                                    ],
                                  ),
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TripSummary(
                                      tripId: snapshot.data[index]['_id'],
                                    ),
                                  ),
                                );
                              },
                            ));
                  });
            }
            return Center(child: Text("No Data Found"));
          },
          future: retrieveData(),
        ),
      ),
    );
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
