import 'package:flutter/material.dart';

Widget customORDivider() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Divider(
        thickness: 2,
        indent: 1,
      ),
      Text("OR"),
      Divider(),
    ],
  );
}
