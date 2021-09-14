import 'package:flutter/material.dart';
import 'package:gmaps_demo/Screens/User/tripSummary.dart';

import 'cnfrmBookingPage.dart';
import 'package:intl/intl.dart';

Widget tripCards(
    BuildContext context,
    bool isConfirmed,
    String vehicleType,
    String origin,
    String destination,
    String empId,
    String date,
    String route) {
  DateTime timestamp = DateTime.parse(date);
  String formattedDate = DateFormat('EEE dd/MM/yyyy').format(timestamp);
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 200,
    child: GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TripSummary(
              tripId: route,
            ),
          ),
        );
      },
      child: Card(
        color: !isConfirmed ? Colors.amber[50] : Colors.green[50],
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Image(
                image: vehicleType == "CAR"
                    ? AssetImage('assets/icons/sport-car.png')
                    : AssetImage('assets/icons/ambulance.png'),
                height: 100,
              ),
            ),
            SizedBox(
              width: 40,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "Origin ->",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 30,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        origin,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "Destination ->",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 30,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        destination,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "Employee ID ->",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 30,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        empId,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "Raised Date ->",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 30,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        formattedDate,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget confirmTripCards(
    BuildContext context,
    bool isConfirmed,
    String vehicleType,
    String origin,
    String destination,
    String empId,
    String date,
    String route) {
  DateTime timestamp = DateTime.parse(date);
  String formattedDate = DateFormat('EEE dd/MM/yyyy').format(timestamp);
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 200,
    child: GestureDetector(
      onTap: () {
        // print("Hello");
        !isConfirmed
            ? Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ConfirmBookScreens(
                    tripId: route,
                    empId: empId,
                  ),
                ),
              )
            : Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TripSummary(
                    tripId: route,
                  ),
                ),
              );
      },
      child: Card(
        color: !isConfirmed ? Colors.amber[50] : Colors.green[50],
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Image(
                image: vehicleType == "CAR"
                    ? AssetImage('assets/icons/sport-car.png')
                    : AssetImage('assets/icons/ambulance.png'),
                height: 100,
              ),
            ),
            SizedBox(
              width: 40,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "Origin ->",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 30,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        origin,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "Destination ->",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 30,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        destination,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "Employee ID ->",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 30,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        empId,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "Raised Date ->",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 30,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        formattedDate,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
