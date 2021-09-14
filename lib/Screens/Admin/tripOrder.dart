import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gmaps_demo/Screens/Admin/cnfrmBookingPage.dart';
import 'package:gmaps_demo/Screens/User/tripSummary.dart';

import 'demo.dart';

class TripOrder extends StatefulWidget {
  var empId;
  TripOrder({this.empId});
  @override
  _TripOrderState createState() => _TripOrderState();
}

class _TripOrderState extends State<TripOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Trip List",
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: refreshData,
        backgroundColor: Colors.black87,
        strokeWidth: 3,
        child: FutureBuilder(
          builder: (context, snapshot) {
            if (ConnectionState.active != null && !snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            if (ConnectionState.done != null && snapshot.hasError) {
              return Center(
                child: Text('Oops some has occured'),
              );
            }
            if (ConnectionState.done != null &&
                snapshot.hasData &&
                snapshot.data.toString() == '[{msg: No Data found}]') {
              return Center(
                child: Text(
                  "No Trips has been done yet",
                  style: TextStyle(fontSize: 30),
                ),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return snapshot.data[index]['confirmed']
                      ? confirmTripCards(
                          context,
                          snapshot.data[index]['confirmed'],
                          snapshot.data[index]['vehicleType'],
                          snapshot.data[index]['origin'],
                          snapshot.data[index]['destination'],
                          snapshot.data[index]['empId'],
                          snapshot.data[index]['createdAt'],
                          snapshot.data[index]['_id'],
                        )
                      : confirmTripCards(
                          context,
                          snapshot.data[index]['confirmed'],
                          snapshot.data[index]['vehicleType'],
                          snapshot.data[index]['origin'],
                          snapshot.data[index]['destination'],
                          snapshot.data[index]['empId'],
                          snapshot.data[index]['createdAt'],
                          snapshot.data[index]['_id'],
                        );
                });
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
    var res =
        await Dio().get('https://cab-server.herokuapp.com/trip/viewAllTrips');

    return res.data["msg"];
  }
}
