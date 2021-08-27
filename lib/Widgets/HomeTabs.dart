import 'package:flutter/material.dart';

Widget homeTabs() {
  return Container(
    child: GestureDetector(
      onTap: () {
        print("Tap Tap");
      },
      child: Card(
        color: Colors.blue,
        child: Image(
          image: AssetImage(
            'assets/icons/sport-car.png',
          ),
        ),
        elevation: 20,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(90)),
      ),
    ),
    height: 150,
    width: 150,
  );
}

Widget homeTab(double elevation, double radius, double height, double width,
    String image, String label, Function onTap) {
  return Column(
    children: [
      Container(
        child: GestureDetector(
          onTap: onTap,
          child: Card(
            color: Colors.blue,
            child: Image(
              image: AssetImage(
                image,
              ),
            ),
            elevation: elevation,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
        ),
        height: height,
        width: width,
      ),
      SizedBox(
        height: 30,
      ),
      Text(
        label,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}
