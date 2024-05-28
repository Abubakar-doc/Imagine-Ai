import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:imagineai/Ui/app_screens/home/home.dart';
import '../Ui/app_screens/profile/personal_info.dart';
import '../Ui/auth_screens/signup/phoneNumberSignup_codeVerify.dart';
import '../utils/utils.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<void> _navigateUser(BuildContext context, bool isOldUser) async {
    if (isOldUser) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => Home(), // Replace with your actual home screen widget
        ),
            (route) => false,
      );
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => PersonalInfo(),
        ),
            (route) => false,
      );
    }
  }

  static Future<void> _checkUserStatusAndNavigate(BuildContext context, String userId) async {
    CollectionReference userDataRef = FirebaseFirestore.instance.collection('UserData');
    QuerySnapshot querySnapshot = await userDataRef.where('UserId', isEqualTo: userId).get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot userDoc = querySnapshot.docs.first;
      bool isOldUser = userDoc['IsOldUser'];
      await _navigateUser(context, isOldUser);
    } else {
      await _navigateUser(context, false);
    }
  }

  static Future<void> signin(BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      String userId = _auth.currentUser!.email!;
      await _checkUserStatusAndNavigate(context, userId);
    } catch (error) {
      Utils().toastmsg('Sign in failed: $error', context);
    }
  }

  static Future<void> signup(BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String userId = _auth.currentUser!.email!;
      await _checkUserStatusAndNavigate(context, userId);
    } catch (error) {
      Utils().toastmsg('Sign up failed: $error', context);
    }
  }

  static Future<void> signinWithGoogle(BuildContext context) async {
    try {
      await GoogleSignIn().signOut();

      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        GoogleSignInAuthentication? googleAuth = await googleUser.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
        if (userCredential.user != null) {
          String userId = userCredential.user!.email!;
          await _checkUserStatusAndNavigate(context, userId);
        }
      } else {
        print('User cancelled account selection.');
      }
    } catch (e) {
      Utils().toastmsg(e.toString(), context);
    }
  }

  static Future<void> signUpWithPhoneNo(
      BuildContext context,
      final fullPhoneNumber,
      Function() onVerificationCompleted,
      Function() onVerificationFailed,
      ) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: fullPhoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          onVerificationCompleted();
          String phoneNumber = _auth.currentUser!.phoneNumber!;
          await _checkUserStatusAndNavigate(context, phoneNumber);
        },
        verificationFailed: (FirebaseAuthException e) {
          Utils().toastmsg('Verification failed: ${e.message}', context);
          onVerificationFailed();
        },
        codeSent: (String verificationID, int? token) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PhoneNumberSigninCodeVerify(verificationID: verificationID),
            ),
          ).then((_) {
            Utils().toastmsg('OTP sent but not verified, initiate process again!', context);
            return;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          Utils().toastmsg('Verification timeout', context);
        },
      );
    } catch (e) {
      Utils().toastmsg(e.toString(), context);
    }
  }

  static Future<void> otpVerification(BuildContext context, String verificationId, String otp) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );

      await _auth.signInWithCredential(credential);
      String phoneNumber = _auth.currentUser!.phoneNumber!;
      await _checkUserStatusAndNavigate(context, phoneNumber);
    } catch (error) {
      Utils().toastmsg('Error: $error', context);
    }
  }

  static Future<void> signinwithFacebook(
    BuildContext context,
  ) async {
    Utils().toastmsg(
        'Under maintenance Kindly use another method to sign in', context);
  }

  static Future<void> passwordResetEmail(
      BuildContext context, String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Utils().greytoastmsg(
        "Password reset email sent to ${email.toString().trim()} successfully, check inbox or spam!",
        context,
      );
      Navigator.pop(context);
    } catch (error) {
      Utils().toastmsg(error.toString(), context);
      return;
    }
  }
}
