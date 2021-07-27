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
      body: Center(
        child: AuthProviderService.instance.user == null
            ? SignInButton(
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
      ),
    );
  }
}
