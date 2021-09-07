import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gmaps_demo/Screens/User/tripSummary.dart';

class TripList extends StatefulWidget {
  var empId;
  TripList({@required this.empId});

  @override
  _TripListState createState() => _TripListState();
}

class _TripListState extends State<TripList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Trip List",
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: refreshData,
        backgroundColor: Colors.black87,
        strokeWidth: 3,
        child: FutureBuilder(
          builder: (context, snapshot) {
            if (ConnectionState.active != null && !snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            if (ConnectionState.done != null && snapshot.hasError) {
              return Center(
                child: Text('Oops some has occured'),
              );
            }
            if (ConnectionState.done != null &&
                snapshot.hasData &&
                snapshot.data.toString() == '[{msg: No Data found}]') {
              return Center(
                child: Text(
                  "No Trips has been done yet",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 20),
                ),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return snapshot.data[index]['confirmed']
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            tileColor: Colors.green[50],
                            title: Row(
                              children: [
                                Row(
                                  children: [
                                    Text("Origin ->"),
                                    SizedBox(width: 10),
                                    Text(snapshot.data[index]['origin']),
                                  ],
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    Text("Destination ->"),
                                    SizedBox(width: 10),
                                    Text(snapshot.data[index]['destination']),
                                  ],
                                ),
                              ],
                            ),
                            subtitle: Row(
                              children: [
                                Row(
                                  children: [
                                    Text("Employee ID ->"),
                                    SizedBox(width: 10),
                                    Text(snapshot.data[index]['empId']),
                                  ],
                                ),
                                // Spacer(),
                                // Row(
                                //   children: [
                                //     Text("Raised Date ->"),
                                //     SizedBox(width: 10),
                                //     Text(snapshot.data[index]['createdAt']),
                                //   ],
                                // ),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TripSummary(
                                    tripId: snapshot.data[index]['_id'],
                                  ),
                                ),
                              );
                            },
                          ))
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            tileColor: Colors.amber[50],
                            title: Row(
                              children: [
                                Row(
                                  children: [
                                    Text("Origin ->"),
                                    SizedBox(width: 10),
                                    Text(snapshot.data[index]['origin']),
                                  ],
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    Text("Destination ->"),
                                    SizedBox(width: 10),
                                    Text(snapshot.data[index]['destination']),
                                  ],
                                ),
                              ],
                            ),
                            subtitle: Row(
                              children: [
                                Row(
                                  children: [
                                    Text("Employee ID ->"),
                                    SizedBox(width: 10),
                                    Text(snapshot.data[index]['empId']),
                                  ],
                                ),
                                // Spacer(),
                                // Row(
                                //   children: [
                                //     Text("Raised Date ->"),
                                //     SizedBox(width: 10),
                                //     Text(snapshot.data[index]['createdAt']),
                                //   ],
                                // ),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TripSummary(
                                    tripId: snapshot.data[index]['_id'],
                                  ),
                                ),
                              );
                            },
                          ));
                });
          },
          future: retrieveData(),
        ),
      ),
    );
  }

  Future refreshData() async {
    await Future.delayed(
      Duration(seconds: 3),
    );
    setState(() {
      retrieveData();
    });
  }

  Future retrieveData() async {
    var res = await Dio().post(
        'https://cab-server.herokuapp.com/trip/viewTrips',
        data: {"empId": widget.empId});

    print(res.data['msg']);
    return res.data["msg"];
  }
}
