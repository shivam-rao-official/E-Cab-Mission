import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:shared_preferences/shared_preferences.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  SharedPreferences prefs;
  final _signupKey = GlobalKey<FormState>();
  String _empId;
  String _name;
  String _phoneNum;
  String _passwd;

  bool isSubmit = false;
  static var counter = 1;
  bool obscure = true;
  bool obscureCount() {
    counter++;
    return counter % 2 != 0 ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Form(
              key: _signupKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage('assets/icons/taxi.png'),
                      height: MediaQuery.of(context).size.height / 6,
                      width: MediaQuery.of(context).size.width / 6,
                    ),
                    /**
                   *    Email Field
                   */

                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
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
                        onChanged: (val) {
                          _empId = val;
                        },
                        onSaved: (val) {
                          _empId = val;
                        },
                        // ignore: missing_return
                        validator: (val) {
                          if (val.isEmpty) return 'Employee ID is Required';
                        },
                      ),
                    ),

                    /**
                     *  Name Field
                     */
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Name",
                          labelStyle: TextStyle(
                            fontSize: 20,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          fillColor: Color(0xffC4C4C4).withOpacity(.2),
                          filled: true,
                        ),
                        onChanged: (val) {
                          _name = val;
                        },
                        onSaved: (val) {
                          _name = val;
                        },
                        // ignore: missing_return
                        validator: (val) {
                          if (val.isEmpty) return 'Name is Required';
                        },
                      ),
                    ),
                    /**
                     * Phone Number Field
                     */
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Phone Number",
                          labelStyle: TextStyle(
                            fontSize: 20,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          fillColor: Color(0xffC4C4C4).withOpacity(.2),
                          filled: true,
                        ),
                        onChanged: (val) {
                          _phoneNum = val;
                        },
                        onSaved: (val) {
                          _phoneNum = val;
                        },
                        // ignore: missing_return
                        validator: (val) {
                          if (val.isEmpty) return 'Phone Number is Required';
                          if (val.length < 10 || val.length > 10)
                            return "Must be a valid Phone Number";
                        },
                      ),
                    ),
                    /**
                   *    Password Field
                   */
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            fontSize: 20,
                          ),
                          suffixIcon: IconButton(
                            icon: counter % 2 == 0
                                ? Icon(Icons.panorama_fish_eye_outlined)
                                : Icon(Icons.circle),
                            onPressed: () {
                              setState(() {
                                obscure = obscureCount();
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        obscureText: obscure,
                        obscuringCharacter: '*',
                        keyboardType: TextInputType.visiblePassword,
                        onChanged: (val) {
                          _passwd = val;
                        },
                        onSaved: (val) {
                          _passwd = val;
                        },
                        // ignore: missing_return
                        validator: (val) {
                          if (val.isEmpty)
                            return 'Password is Required';
                          else if (val.length < 6)
                            return 'Password must be of length 6';
                        },
                      ), //Password Field Ends
                    ),
                    SizedBox(height: 30),
                    SizedBox(height: 30),
                    isSubmit
                        ? CircularProgressIndicator()
                        : MaterialButton(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 15.0,
                                bottom: 15.0,
                                right: 40,
                                left: 40,
                              ),
                              child: Text(
                                "Sign Up",
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
                              if (_signupKey.currentState.validate()) {
                                setState(() {
                                  getData();
                                });
                              }
                            },
                          ),
                    Padding(
                      padding: EdgeInsets.all(30),
                      child: Divider(
                        thickness: 3,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account?"),
                        SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/login');
                          },
                          child: Text("Login"),
                        ),
                      ],
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getData() async {
    prefs = await SharedPreferences.getInstance();

    setState(() {
      isSubmit = true;
    });
    var res = await Dio().post('https://cab-server.herokuapp.com/user/signUp',
        data: {
          "name": _name,
          "empId": _empId,
          "phoneNum": _phoneNum,
          "passwd": _passwd
        });
    if (res.statusCode == 200) {
      if (res.data["status"]) {
        await prefs.setString('Name', _name);
        await prefs.setString('EmpID', _empId);
        await prefs.setString('PhoneNum', _phoneNum);

        signInMessage(res.data['status'], res.data['msg']);
      } else {
        signInMessage(res.data['status'], res.data['msg']);
      }
    }
    setState(() {
      isSubmit = false;
    });
  }

  signInMessage(bool success, String msg) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return success
            ? AlertDialog(
                title: Text("Sign Up Alert"),
                content: Container(
                  height: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Message : $msg"),
                      Text("Employee ID : $_empId"),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    child: Text("Proceed"),
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/home');
                    },
                  ),
                ],
              )
            : AlertDialog(
                title: Text("Login Alert"),
                content: Container(
                  height: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Oops Error Occured"),
                      Text("Error Message"),
                      Text("$msg"),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    child: Text("Retry"),
                    onPressed: () {
                      _signupKey.currentState.reset();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
      },
    );
  }
}
