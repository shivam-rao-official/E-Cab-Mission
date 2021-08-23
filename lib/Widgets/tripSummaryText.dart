import 'package:flutter/material.dart';

Widget tripSummaryText(String label, String value, context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                enabled: false,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                fillColor: Color(0xffC4C4C4).withOpacity(.2),
                filled: true,
                labelText: value,
                labelStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
