import 'package:flutter/material.dart';

Widget CustomAppBar(BuildContext context) {
  return PreferredSize(
    preferredSize: Size.fromHeight(MediaQuery.of(context).size.height / 3),
    child: Container(
      width: MediaQuery.of(context).size.width / 2,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0xff203b62),
            spreadRadius: 5,
            blurRadius: 20,
          )
        ],
        image: DecorationImage(
          image: AssetImage('assets/image/missionlogo420.png'),
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      height: MediaQuery.of(context).size.height / 4,
    ),
  );
}
