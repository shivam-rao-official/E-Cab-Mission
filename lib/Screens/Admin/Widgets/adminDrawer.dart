import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget customDrawer(BuildContext context, String name, String empId) {
  Future logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('Name');
    await prefs.remove('PhoneNum');
    await prefs.remove('EmpID');
  }

  return Drawer(
    child: Column(
      children: [
        UserAccountsDrawerHeader(
          accountName: Text(
            name,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          accountEmail: Text(
            empId,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          decoration: BoxDecoration(color: Color(0xfffFFC700)),
        ),
        // Align(
        //   alignment: Alignment.topLeft,
        //   child: TextButton(
        //     onPressed: () {},
        //     child: Text(
        //       "Add Vehicle",
        //       style: TextStyle(
        //         color: Colors.black,
        //         fontWeight: FontWeight.bold,
        //         fontSize: 20,
        //       ),
        //     ),
        //   ),
        // ),
        // SizedBox(),
        // Align(
        //   alignment: Alignment.topLeft,
        //   child: TextButton(
        //     onPressed: () {
        //       Navigator.of(context).pushNamed('/addDriver');
        //     },
        //     child: Text(
        //       "Add Driver",
        //       style: TextStyle(
        //         color: Colors.black,
        //         fontWeight: FontWeight.bold,
        //         fontSize: 20,
        //       ),
        //     ),
        //   ),
        // ),
        // SizedBox(),
        Align(
          alignment: Alignment.topLeft,
          child: TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/bookTrip');
            },
            child: Text(
              "Trip Booking",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
        SizedBox(),
        Align(
          alignment: Alignment.topLeft,
          child: TextButton(
            onPressed: () {
              logOut();
              Navigator.of(context).pushReplacementNamed('/login');
            },
            child: Text(
              "Logout",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
        SizedBox(),
      ],
    ),
  );
}
