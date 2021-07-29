import 'package:flutter/material.dart';
import 'package:healthify_testing/bottom_nav_screen.dart';
import 'package:healthify_testing/pages/google_sign_in/sign_in_google.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String uid;
  String username;
  @override
  Widget build(BuildContext context) {
    print(AuthProviderService.instance.user);
    if (AuthProviderService.instance.user != null) {
      var user = AuthProviderService.instance.user;
      uid = user.uid;
      username = user.displayName;
    }

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/sign-in-bgr.jpg"),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black45,
                    offset: Offset(0, 0),
                    blurRadius: 3.0,
                  ),
                ],
              ),
              child: Image.asset(
                "assets/images/logo_skripsi.png",
                height: 150,
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white38,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black45,
                    offset: Offset(0, 3),
                    blurRadius: 2.0,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AuthProviderService.instance.user == null
                        ? SignInButton(
                            elevation: 10,
                            buttonSize: ButtonSize.large,
                            buttonType: ButtonType.google,
                            onPressed: () async {
                              await AuthProviderService.instance.signIn();
                              var user = AuthProviderService.instance.user;
                              uid = user.uid;
                              username = user.displayName;
                              print(uid);
                              print(username);
                              setState(() {});
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BottomNavScreen(),
                                ),
                              );
                            },
                          )
                        : CircularProgressIndicator(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
