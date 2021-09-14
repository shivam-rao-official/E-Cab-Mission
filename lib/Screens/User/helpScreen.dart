import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Instruction"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          manualText(
            'assets/icons/sport-car.png',
            "In the home menu TAP on this icon to book a CAR.",
          ),
          manualText(
            'assets/icons/ambulance.png',
            "In the home menu TAP on this icon to book an AMBULANCE.",
          ),
          manualText(
            'assets/icons/data.png',
            "In the home menu TAP on this icon to check your trip details.",
          ),
          manualText(
            'assets/icons/help.png',
            "Tap here for Instruction",
          ),
          manualText(
            'assets/icons/exit.png',
            "For Ending your session TAP on this icon to logout",
          ),
        ],
      ),
    );
  }

  Widget manualText(String imagePath, String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Table(
            children: [
              TableRow(
                children: [
                  CircleAvatar(
                    child: Image(
                      image: AssetImage(imagePath),
                    ),
                    radius: 40,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 20,
                      bottom: 30,
                    ),
                    child: Text(text),
                  ),
                ],
              ),
            ],
          ),
          Divider(
            indent: 100,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
