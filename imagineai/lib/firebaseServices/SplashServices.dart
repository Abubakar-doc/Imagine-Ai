import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:imagineai/Ui/app_screens/home.dart';
import '../Ui/app_screens/intro.dart';

class SplashServices{
  void isSignedIn(BuildContext context){
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if(user!=null){
      Timer(const Duration(seconds: 1), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>  Home(),
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