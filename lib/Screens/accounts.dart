import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String _name;
  String _empId;
  String _phnNum;

  Future getEmpData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString("Name");
      _empId = prefs.getString("EmpID");
      _phnNum = prefs.getString("PhoneNum");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEmpData();
    Future.delayed(Duration(seconds: 5));
    retrieveData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image(
            image: AssetImage('assets/image/missionlogo420.png'),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.white.withOpacity(0.9),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Row(
                    children: [
                      Spacer(),
                      CircleAvatar(
                        maxRadius: MediaQuery.of(context).size.width / 10,
                        backgroundColor: Color(0xff203b62),
                        child: Text(
                          _name.substring(0, 1),
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 10,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "$_name",
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width / 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "$_empId",
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width / 23,
                            ),
                          ),
                          Text(
                            "$_phnNum",
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width / 26,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                    ],
                  ),
                ),
                Divider(
                  indent: 30,
                  endIndent: 30,
                  thickness: 3,
                  color: Colors.black54,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Trips",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 26,
                      ),
                    ),
                    Text(
                      "Total Confirmed Trips",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 26,
                      ),
                    ),
                    // Text(
                    //   "Latest Trip",
                    //   style: TextStyle(
                    //     fontSize: MediaQuery.of(context).size.width / 26,
                    //   ),
                    // ),
                    Text(
                      "Logout",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 26,
                      ),
                    ),
                    // Text(
                    //   "Total Trips",
                    //   style: TextStyle(
                    //     fontSize: MediaQuery.of(context).size.width / 26,
                    //   ),
                    // ),
                    // Text(
                    //   "Total Trips",
                    //   style: TextStyle(
                    //     fontSize: MediaQuery.of(context).size.width / 26,
                    //   ),
                    // ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future retrieveData() async {
    var res = await Dio().post(
        'https://cab-server.herokuapp.com/trip/viewTrips',
        data: {"empId": _empId});

    print(res.data['msg']);
    // return res.data["msg"];
  }
}
