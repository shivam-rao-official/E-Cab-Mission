import 'package:flutter/material.dart';

Widget addDriverCard(BuildContext context, String label, String data) {
  return Card(
    elevation: 10,
    child: Container(
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
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

int _value = 1;
Widget cardOriginDropDown(BuildContext context, String label) {
  return Card(
    elevation: 10,
    child: Container(
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
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: DropdownButton(
                value: _value,
                items: [
                  DropdownMenuItem(
                    child: Text("First Item"),
                    value: 1,
                  ),
                  DropdownMenuItem(
                    child: Text("Second Item"),
                    value: 2,
                  )
                ],
                hint: Text("Select item"),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
