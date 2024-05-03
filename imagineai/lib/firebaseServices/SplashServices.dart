import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Ui/app_screens/crud.dart';
import '../Ui/app_screens/intro.dart';
import '../Ui/auth_screens/signup/phoneNumberSignup_codeVerify.dart';

class SplashServices{
  void isSignedIn(BuildContext context){
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if(user!=null){
      Timer(const Duration(seconds: 1), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => crud(),
          ),
        );
      });
    }
    else{
      Timer(const Duration(seconds: 1), () {
        print('hello');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            // builder: (context) => PhoneNumberSigninCodeVerify(verificationID: '111',),
            builder: (context) => IntroScreen(),
          ),
        );
      });
    }

}
}