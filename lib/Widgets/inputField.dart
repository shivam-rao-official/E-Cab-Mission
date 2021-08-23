import 'package:flutter/material.dart';

Widget textFieldEmpID() {
  return TextFormField(
    decoration: InputDecoration(
      labelText: "Emp ID",
      labelStyle: TextStyle(
        fontSize: 20,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      fillColor: Color(0xffC4C4C4).withOpacity(.2),
      filled: true,
    ),
  );
}

Widget textFieldPasswd() {
  return TextFormField(
    decoration: InputDecoration(
      labelText: "Password",
      labelStyle: TextStyle(
        fontSize: 20,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        // borderSide: BorderSide(
        //   color: Color(0xffC4C4C4),
        // ),
      ),
      fillColor: Color(0xffC4C4C4).withOpacity(.2),
      filled: true,
    ),
  );
}

Widget textFieldName() {
  return TextFormField(
    decoration: InputDecoration(
      labelText: "Emp Name",
      labelStyle: TextStyle(
        fontSize: 20,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        // borderSide: BorderSide(
        //   color: Color(0xffC4C4C4),
        // ),
      ),
      fillColor: Color(0xffC4C4C4).withOpacity(.2),
      filled: true,
    ),
  );
}

Widget textFieldPhnNumber() {
  return TextFormField(
    decoration: InputDecoration(
      labelText: "Phone Number",
      labelStyle: TextStyle(
        fontSize: 20,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        // borderSide: BorderSide(
        //   color: Color(0xffC4C4C4),
        // ),
      ),
      fillColor: Color(0xffC4C4C4).withOpacity(.2),
      filled: true,
    ),
  );
}
