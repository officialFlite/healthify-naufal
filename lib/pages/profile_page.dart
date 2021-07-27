import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:healthify_testing/dataBadan.dart';
import 'package:healthify_testing/pages/google_sign_in/sign_in.dart';

import 'google_sign_in/sign_in_google.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String logbadan = 'logBadan';
  String selected;
  String selected1;

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

  double hitunganKalori;
  double activityValue;

  void uploadHitunganKaloriVoid(DataBadan _dataBadan) async {
    uploadHitunganKalori.update({
      'hitunganKalori': hitunganKalori,
    });
  }

  void uploadRiwayatKalori(DataBadan _dataBadan) async {
    uploadRiwayatProfil.push().set({
      'beratBadan': double.parse(weightController.text),
      'jenisKelamin': selected,
      'kalori': hitunganKalori,
      'tinggiBadan': double.parse(heightController.text),
      'umur': double.parse(ageController.text),
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Healthify'),
        backgroundColor: Color.fromARGB(255, 178, 34, 34),
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
          child: Column(
            children: [
              Container(
                width: double.infinity,
                margin: EdgeInsets.all(7),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color.fromARGB(255, 255, 255, 224),
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
                                'Calculate',
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
                      width: 150,
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
                          uploadRiwayatKalori(_dataBadan);
                          FocusScopeNode currentFocus = FocusScope.of(context);

                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
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
                    SizedBox(height: 20),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      offset: Offset(4, 4),
                      blurRadius: 4.0,
                    ),
                  ],
                ),
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    await AuthProviderService.instance.logOut();
                    Navigator.of(context).pop();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignIn(),
                      ),
                      ModalRoute.withName("/loginpage"),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.exit_to_app,
                        color: Colors.black,
                      ),
                      Text(
                        "Log out",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
