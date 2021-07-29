import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class DataHistory extends StatefulWidget {
  @override
  _DataHistoryState createState() => _DataHistoryState();
}

class _DataHistoryState extends State<DataHistory> {
  Query _ref;

  @override
  void initState() {
    super.initState();
    _ref = FirebaseDatabase.instance
        .reference()
        .child('dataBadan')
        .child('riwayatKalori')
        .orderByChild('usernameSaved');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Healthify'),
        backgroundColor: Color.fromARGB(255, 178, 34, 34),
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        height: double.infinity,
        child: Container(
          child: FirebaseAnimatedList(
            query: _ref,
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              Map dataBadan = snapshot.value;
              return _manualMonitorSensor(dataBadan: dataBadan);
            },
          ),
        ),
      ),
    );
  }

  Widget _manualMonitorSensor({Map dataBadan}) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.cyan[50],
        boxShadow: [
          BoxShadow(
            color: Colors.black45,
            offset: Offset(0, 3),
            blurRadius: 5.0,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        width: double.infinity,
                        height: size.height * 0.065,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 45, 50, 67),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            dataBadan['usernameSaved'],
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.calendar_today_rounded,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  'Date : ',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  dataBadan['hari'],
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  ', ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  dataBadan['tanggal'],
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(
                                  Icons.wc_rounded,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  "Gender : ",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  dataBadan['jenisKelamin'].toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[850],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.cake_rounded,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  "Age : ",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  dataBadan['umur'].toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[850],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(
                                  Icons.height_rounded,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  "Body Height : ",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  dataBadan['tinggiBadan'].toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[850],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.speed_rounded,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  "Body Weight:",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  dataBadan['beratBadan'].toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[850],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.whatshot_rounded,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  "Calorie :",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  dataBadan['kalori'].toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[850],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.equalizer_rounded,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  "IMT Value :",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  dataBadan['imt'].toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[850],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.accessibility_new_rounded,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  "IMT Category :",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  dataBadan['statusIMT'],
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[850],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
