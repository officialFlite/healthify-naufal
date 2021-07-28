import 'package:flutter/material.dart';
import 'package:healthify_testing/pages/google_sign_in/sign_in_google.dart';
import 'package:healthify_testing/pages/workout_cat/easy_work.dart';
import 'package:healthify_testing/widgets/revised_button.dart';

import 'google_sign_in/sign_in.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
        title: Text('Healthify'),
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 178, 34, 34),
      ),
      body: Container(
        color: Colors.grey[300],
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      offset: Offset(3, 3),
                      blurRadius: 2.0,
                    ),
                  ],
                ),
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Text(
                      "Welcome to Healthify",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Your personal health trainer",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 5),
                    Image.asset(
                      "assets/images/logo_skripsi.png",
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
              SizedBox(height: 5),
              RevisedButton(
                boxImage: AssetImage("assets/images/easy_jog.png"),
                descButton: 'Easy',
                descText: 'For those beginners',
                color: Color.fromARGB(255, 55, 60, 77),
                textColor: Colors.white,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EasyWork(),
                    ),
                  );
                },
              ),
              RevisedButton(
                boxImage: AssetImage("assets/images/medium_yog.png"),
                descButton: 'Medium',
                descText: 'For those beginners',
                color: Color.fromARGB(255, 55, 60, 77),
                textColor: Colors.white,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EasyWork(),
                    ),
                  );
                },
              ),
              RevisedButton(
                boxImage: AssetImage("assets/images/muscle.png"),
                descButton: 'Hard',
                descText: 'For those beginners',
                color: Color.fromARGB(255, 55, 60, 77),
                textColor: Colors.white,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EasyWork(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
