import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Widget customLoginButton(BuildContext context) {
  return MaterialButton(
    child: Padding(
      padding: const EdgeInsets.only(
        top: 15.0,
        bottom: 15.0,
        right: 40,
        left: 40,
      ),
      child: Text(
        "LOGIN",
        style: TextStyle(
          fontSize: 25,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    color: Color(0xfff2400FF),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
    onPressed: () {
      getData();
      // Navigator.of(context).pushReplacementNamed('/home');
    },
  );
}

// String url = "http://localhost:3000/rout/";
Future<void> getData() async {
  var req =
      await http.post("http://localhost:5000/user/api/login" as Uri, body: {
    "U_Id": "T1203",
    "Password": "it@dept",
  });
  if (req.statusCode == 200) {
    print(req.body);
  }
}
