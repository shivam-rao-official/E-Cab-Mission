import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TripBooking extends StatefulWidget {
  @override
  _TripBookingState createState() => _TripBookingState();
}

class _TripBookingState extends State<TripBooking> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEmpID();
  }

  Future<void> getEmpID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _empId = prefs.getString('EmpID');
  }

  final _tripBookKey = GlobalKey<FormState>();
  String _empId;
  String _origin;
  String _destination;
  String _vehicleType;

  bool isSubmit = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "TRIP DETAILS",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w900,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Form(
            key: _tripBookKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 10,
                ),
                /**
                 *  From Field
                 */
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "From",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              fillColor: Color(0xffC4C4C4).withOpacity(.2),
                              filled: true,
                            ),
                            onChanged: (val) {
                              _origin = val;
                            },
                            onSaved: (val) {
                              _origin = val;
                            },
                            // ignore: missing_return
                            validator: (val) {
                              if (val.isEmpty) return 'Field is Required';
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Destination",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              fillColor: Color(0xffC4C4C4).withOpacity(.2),
                              filled: true,
                            ),
                            onChanged: (val) {
                              _destination = val;
                            },
                            onSaved: (val) {
                              _destination = val;
                            },
                            // ignore: missing_return
                            validator: (val) {
                              if (val.isEmpty) return 'Destination is Required';
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Vehicle Type",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              fillColor: Color(0xffC4C4C4).withOpacity(.2),
                              filled: true,
                            ),
                            onChanged: (val) {
                              _vehicleType = val;
                            },
                            onSaved: (val) {
                              _vehicleType = val;
                            },
                            // ignore: missing_return
                            validator: (val) {
                              if (val.isEmpty)
                                return 'Vehicle Type is Required';
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 10,
                ),
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
                            "Add Trip",
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
                          if (_tripBookKey.currentState.validate()) {
                            getData();
                          }
                          // Navigator.of(context).pushReplacementNamed('/home');
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getData() async {
    setState(() {
      isSubmit = true;
    });
    var res = await Dio()
        .post('https://cab-server.herokuapp.com/trip/createTrip', data: {
      "empId": _empId,
      "origin": _origin,
      "destination": _destination,
      "vehicleType": _vehicleType
    });

    if (res.statusCode == 200) {
      if (res.data["status"]) {
        signInMessage(res.data["status"], res.data["msg"]);
      }
    } else {
      signInMessage(res.data["status"], res.data["msg"]);
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
                title: Text("Success Alert"),
                content: Container(
                  height: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Message : $msg"),
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
                title: Text("Error Alert"),
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
                      _tripBookKey.currentState.reset();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
      },
    );
  }
}
