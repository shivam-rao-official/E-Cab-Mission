import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gmaps_demo/Widgets/tripSummaryText.dart';

class TripSummary extends StatefulWidget {
  var tripId;

  TripSummary({this.tripId});

  @override
  _TripSummaryState createState() => _TripSummaryState();
}

class _TripSummaryState extends State<TripSummary> {
  var origin;
  var dest;
  var vehicleType;
  var vehicleNum;
  var driverNum;
  var confirmedBy;
  Future getTripData() async {
    var res = await Dio().post(
        'https://cab-server.herokuapp.com/trip/tripDetail/' + widget.tripId);

    if (res.statusCode == 200)
      setState(() {
        origin = res.data['msg']['origin'];
        dest = res.data['msg']['destination'];
        vehicleType = res.data['msg']['vehicleType'];
        vehicleNum = res.data['msg']['vehicleNum'];
        driverNum = res.data['msg']['driverNum'];
        confirmedBy = res.data['msg']['confirmedBy'];
      });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTripData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Trip Details",
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
      body: Column(
        children: [
          Align(
              alignment: Alignment.topLeft,
              child: tripSummaryText(
                "Origin",
                origin,
                context,
              )),
          Align(
            alignment: Alignment.topLeft,
            child: tripSummaryText("Destination", dest, context),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: tripSummaryText("Vehicle Type", vehicleType, context),
          ),
          Align(
              alignment: Alignment.topLeft,
              child: tripSummaryText("Vehicle Number", vehicleNum, context)),
          Align(
            alignment: Alignment.topLeft,
            child: tripSummaryText("Driver Number", driverNum, context),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: tripSummaryText("Confirmed By", confirmedBy, context),
          ),
        ],
      ),
    );
  }
}
