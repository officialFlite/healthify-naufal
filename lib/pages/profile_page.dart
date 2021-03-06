import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:healthify_testing/dataBadan.dart';
import 'package:healthify_testing/pages/data_history.dart';
import 'package:healthify_testing/pages/google_sign_in/sign_in.dart';
import 'package:intl/intl.dart';
import 'google_sign_in/sign_in_google.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  DateTime now = DateTime.now();

  String logbadan = 'logBadan';
  String selected;
  String selected1;
  String statusIMT = 'none';

  double hitunganKalori;
  double hitunganIMT;
  double activityValue;

  List<String> data = [
    "Male",
    "Female",
  ];

  List<String> data1 = [
    "Very Light",
    "Light",
    "Moderate",
    "Heavy",
    "Very Heavy",
  ];

  DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference().child('dataBadan');

  DatabaseReference uploadDataDiri = FirebaseDatabase.instance
      .reference()
      .child('dataBadan')
      .child('dataDiri');

  DatabaseReference uploadHitunganKalori = FirebaseDatabase.instance
      .reference()
      .child('dataBadan')
      .child('dataHitunganKalori');

  DatabaseReference uploadHitunganIMT = FirebaseDatabase.instance
      .reference()
      .child('dataBadan')
      .child('dataHitunganIMT');

  DatabaseReference uploadRiwayatProfil = FirebaseDatabase.instance
      .reference()
      .child('dataBadan')
      .child('riwayatKalori');

  final weightController = TextEditingController();
  final heightController = TextEditingController();
  final ageController = TextEditingController();
  final genderController = TextEditingController();
  final caloriesController = TextEditingController();
  final activitiesController = TextEditingController();

  double weightCont;

  showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alert"),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: EdgeInsets.all(10),
      content: Text("Data Saved on Database"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void dispose() {
    weightController.dispose();
    heightController.dispose();
    ageController.dispose();
    genderController.dispose();
    caloriesController.dispose();
    activitiesController.dispose();

    super.dispose();
  }

  clearTextInput() {
    weightController.clear();
    heightController.clear();
    ageController.clear();
    genderController.clear();
    activitiesController.clear();
  }

  void uploadHitunganKaloriVoid(DataBadan _dataBadan) async {
    uploadHitunganKalori.update({
      'hitunganKalori': hitunganKalori,
    });
  }

  void uploadHitunganIMTVoid(DataBadan _dataBadan) async {
    uploadHitunganIMT.update({
      'hitunganIMT': hitunganIMT,
      'statusIMT': statusIMT,
    });
  }

  void uploadRiwayatKalori(DataBadan _dataBadan) async {
    String formattedDate = DateFormat('dd-MM-yyyy').format(now);
    String uploadTime = DateFormat('kk:mm:s').format(now);
    String uploadDay = DateFormat('EEEE').format(now);

    var value = {
      'hari': uploadDay,
      'jam': uploadTime,
      'tanggal': formattedDate,
      'usernameSaved': user.displayName,
      'beratBadan': double.parse(weightController.text),
      'jenisKelamin': selected,
      'kalori': hitunganKalori,
      'tinggiBadan': double.parse(heightController.text),
      'umur': double.parse(ageController.text),
      'imt': hitunganIMT,
      'statusIMT': statusIMT,
    };
    uploadRiwayatProfil.push().set(
          value,
        );
  }

  void activityRateCalc() {
    if (selected1 == "Very Light") {
      activityValue = 1.2;
    } else if (selected1 == "Light") {
      activityValue = 1.375;
    } else if (selected1 == "Moderate") {
      activityValue = 1.55;
    } else if (selected1 == "Heavy") {
      activityValue = 1.725;
    } else if (selected1 == "Very Heavy") {
      activityValue = 1.9;
    } else {
      activityValue = 666;
    }
  }

  void kalkulasiIndeksMassaTubuh(DataBadan _dataBadan) {
    hitunganIMT = double.parse(weightController.text) /
        ((double.parse(heightController.text) / 100) *
            (double.parse(heightController.text) / 100));

    if (hitunganIMT < 18.5) {
      statusIMT = "Less";
    } else if (hitunganIMT >= 18.5 && hitunganIMT < 25) {
      statusIMT = "Ideal";
    } else if (hitunganIMT >= 25 && hitunganIMT < 30) {
      statusIMT = "Excessive";
    } else if (hitunganIMT >= 30 && hitunganIMT < 40) {
      statusIMT = "Fat";
    } else {
      statusIMT = "Obesity";
    }
    uploadHitunganIMTVoid(_dataBadan);
  }

  void kalkulasiKalori(DataBadan _dataBadan) {
    activityRateCalc();
    if (selected == 'Male') {
      hitunganKalori = activityValue *
          (66 +
              (13.7 * double.parse(weightController.text)) +
              (5 * double.parse(heightController.text)) -
              (6.78 * double.parse(ageController.text)));
      uploadHitunganKaloriVoid(_dataBadan);
    } else if (selected == 'Female') {
      hitunganKalori = activityValue *
          (655 +
              (9.6 * double.parse(weightController.text)) +
              (1.8 * double.parse(heightController.text)) -
              (4.7 * double.parse(ageController.text)));
      uploadHitunganKaloriVoid(_dataBadan);
    } else {
      hitunganKalori = 666;
      uploadHitunganKaloriVoid(_dataBadan);
    }
  }

  void handleClick(String value) async {
    switch (value) {
      case 'Sign Out':
        await AuthProviderService.instance.logOut();
        Navigator.of(context).pop();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => SignIn(),
          ),
          ModalRoute.withName("/loginpage"),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Healthify'),
        backgroundColor: Color.fromARGB(255, 178, 34, 34),
        actions: [
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Sign Out'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: databaseReference.onValue,
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              !snapshot.hasError &&
              snapshot.data.snapshot.value != null) {
            var _dataBadan =
                DataBadan.fromJson(snapshot.data.snapshot.value[logbadan]);
            return tampilData(_dataBadan);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  var user = AuthProviderService.instance.user;

  Widget userShow() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.orange[400],
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            offset: Offset(4.0, 4.0), //(x,y)
            blurRadius: 5.0,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Hi there!',
            style: TextStyle(
              fontSize: 20,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(4, 4),
                  blurRadius: 3.0,
                ),
              ],
            ),
            child: Text(
              user.displayName,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(300),
              image: DecorationImage(
                image: NetworkImage(user.photoURL),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            "UID : ",
            style: TextStyle(
              fontSize: 20,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(4, 4),
                  blurRadius: 3.0,
                ),
              ],
            ),
            child: Text(
              user.uid,
              style: TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Ready to begin some workout?',
            style: TextStyle(
              fontSize: 20,
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget tampilData(DataBadan _dataBadan) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              userShow(),
              Container(
                width: double.infinity,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.cyan[50],
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      offset: Offset(4.0, 4.0), //(x,y)
                      blurRadius: 5.0,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 45, 50, 67),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Calculator",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Body Weight (Kg)",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      width: 150,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(3, 3),
                            blurRadius: 4.0,
                          ),
                        ],
                      ),
                      child: TextField(
                        textAlign: TextAlign.start,
                        controller: weightController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Body Height (Cm)",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      width: 150,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(3, 3),
                            blurRadius: 4.0,
                          ),
                        ],
                      ),
                      child: TextField(
                        textAlign: TextAlign.start,
                        controller: heightController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Age",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      width: 150,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(3, 3),
                            blurRadius: 4.0,
                          ),
                        ],
                      ),
                      child: TextField(
                        textAlign: TextAlign.start,
                        controller: ageController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Activity Rate",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      width: 150,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(3, 3),
                            blurRadius: 4.0,
                          ),
                        ],
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 10),
                          DropdownButtonHideUnderline(
                            child: DropdownButton(
                              autofocus: true,
                              elevation: 8,
                              value: selected1,
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Color.fromARGB(0, 1, 1, 1),
                              ),
                              hint: Text(
                                "Choose",
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Color.fromARGB(0, 1, 1, 1),
                                ),
                              ),
                              onChanged: (value) {
                                print(value);
                                setState(() {
                                  selected1 = value;
                                });
                              },
                              items: data1
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Center(
                                        child: Text(
                                          e,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Gender",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      width: 150,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(3, 3),
                            blurRadius: 4.0,
                          ),
                        ],
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 10),
                          DropdownButtonHideUnderline(
                            child: DropdownButton(
                              autofocus: true,
                              elevation: 8,
                              value: selected,
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Color.fromARGB(0, 1, 1, 1),
                              ),
                              hint: Text(
                                "Choose",
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Color.fromARGB(0, 1, 1, 1),
                                ),
                              ),
                              onChanged: (value) {
                                print(value);
                                setState(() {
                                  selected = value;
                                });
                              },
                              items: data
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Center(
                                        child: Text(
                                          e,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 150,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.greenAccent,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.grey),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(3, 3),
                                blurRadius: 4.0,
                              ),
                            ],
                          ),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              alignment: Alignment.center,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: () {
                              kalkulasiKalori(_dataBadan);
                              FocusScopeNode currentFocus =
                                  FocusScope.of(context);

                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                'Calculate Cal',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 150,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.greenAccent,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.grey),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(3, 3),
                                blurRadius: 4.0,
                              ),
                            ],
                          ),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              alignment: Alignment.center,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: () {
                              kalkulasiIndeksMassaTubuh(_dataBadan);
                              FocusScopeNode currentFocus =
                                  FocusScope.of(context);

                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                'Calculate IMT',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Your Calorie is",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              width: 170,
                              height: 45,
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(3, 3),
                                    blurRadius: 4.0,
                                  ),
                                ],
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(hitunganKalori.toString()),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Your IMT is",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              width: 170,
                              height: 45,
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(3, 3),
                                    blurRadius: 4.0,
                                  ),
                                ],
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        statusIMT,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        ' at',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    hitunganIMT.toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Container(
                      width: 150,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.grey),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(3, 3),
                            blurRadius: 4.0,
                          ),
                        ],
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          alignment: Alignment.center,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {
                          showAlertDialog(context);
                          uploadRiwayatKalori(_dataBadan);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            'Save Data',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: 150,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.grey),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(3, 3),
                            blurRadius: 4.0,
                          ),
                        ],
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          alignment: Alignment.center,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DataHistory(),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            'Data History',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
