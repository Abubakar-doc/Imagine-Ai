// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// // import '../Ui/app_screens/crud.dart';
// // import '../Ui/auth_screens/signup/phoneNumberSignup_codeVerify.dart';
// // import '../utils/utils.dart';
// //
// // class AuthService {
// //   static final FirebaseAuth _auth = FirebaseAuth.instance;
// //
// //   static Future<void> Signin(BuildContext context, String email, String password) async {
// //     try {
// //       UserCredential userCredential = await _auth.signInWithEmailAndPassword(
// //         email: email,
// //         password: password,
// //       );
// //
// //       Navigator.pushAndRemoveUntil(
// //         context,
// //         MaterialPageRoute(
// //           builder: (context) => crud(), // Replace HomeScreen with your actual home screen widget
// //         ),
// //             (route) => false, // Remove all routes from the stack
// //       );
// //     } catch (error) {
// //       Utils().toastmsg('Sign in failed: $error', context);
// //     }
// //   }
// //
// //   static Future<void> signUp(BuildContext context, String email, String password) async {
// //     try {
// //       UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
// //         email: email,
// //         password: password,
// //       );
// //
// //       Navigator.pushAndRemoveUntil(
// //         context,
// //         MaterialPageRoute(
// //           builder: (context) => crud(),
// //         ),
// //             (route) => false,
// //       );
// //     } catch (error) {
// //       Utils().toastmsg('Sign up failed: $error', context);
// //     }
// //   }
// //
// //   static Future<void> signUpWithPhoneNo(BuildContext context, String phoneNumber, String selectedCountryCode) async {
// //     try {
// //       final fullPhoneNumber = '$selectedCountryCode$phoneNumber';
// //       await _auth.verifyPhoneNumber(
// //         phoneNumber: fullPhoneNumber,
// //         verificationCompleted: (PhoneAuthCredential credential) async {
// //           // This callback will be called if the auto-resolution succeeds with a phone auth credential.
// //           // You can use this credential to sign in the user.
// //           await _auth.signInWithCredential(credential);
// //         },
// //         verificationFailed: (FirebaseAuthException e) {
// //           // This callback will be called if the verification failed for some reason.
// //           Utils().toastmsg('Verification failed: ${e.message}', context);
// //         },
// //         codeSent: (String verificationID, int? token) {
// //           // This callback will be called when the verification code is sent to the provided phone number.
// //           // You can navigate to the verification screen and pass the verification ID to it.
// //           Navigator.push(
// //             context,
// //             MaterialPageRoute(
// //               builder: (context) => PhoneNumberSigninCodeVerify(verificationID: verificationID),
// //             ),
// //           );
// //         },
// //         codeAutoRetrievalTimeout: (String verificationID) {
// //           // This callback will be called when the auto-resolution timeout has been reached.
// //           // You can handle this scenario if needed.
// //           Utils().toastmsg('Verification timeout', context);
// //         },
// //       );
// //     } catch (error) {
// //       Utils().toastmsg('Error: $error', context);
// //     }
// //   }
// // }
// //
// //
// //
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import '../Ui/app_screens/crud.dart';
// import '../Ui/auth_screens/signup/phoneNumberSignup_codeVerify.dart';
// import '../utils/utils.dart';
//
// class AuthService {
//   static final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   static Future<void> signin(BuildContext context, String email, String password) async {
//     try {
//       UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//
//       Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(
//           builder: (context) => crud(), // Replace Crud with your actual home screen widget
//         ),
//             (route) => false, // Remove all routes from the stack
//       );
//     } catch (error) {
//       Utils().toastmsg('Sign in failed: $error', context);
//     }
//   }
//
//   static Future<void> signup(BuildContext context, String email, String password) async {
//     try {
//       UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//
//       Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(
//           builder: (context) => crud(),
//         ),
//             (route) => false,
//       );
//     } catch (error) {
//       Utils().toastmsg('Sign up failed: $error', context);
//     }
//   }
//
//   static Future<void> signUpWithPhoneNo(BuildContext context, String phoneNumber, String selectedCountryCode) async {
//     try {
//       final fullPhoneNumber = '$selectedCountryCode$phoneNumber';
//       await _auth.verifyPhoneNumber(
//         phoneNumber: fullPhoneNumber,
//         verificationCompleted: (PhoneAuthCredential credential) async {
//           // This callback will be called if the auto-resolution succeeds with a phone auth credential.
//           // You can use this credential to sign in the user.
//           await _auth.signInWithCredential(credential);
//         },
//         verificationFailed: (FirebaseAuthException e) {
//           // This callback will be called if the verification failed for some reason.
//           Utils().toastmsg('Verification failed: ${e.message}', context);
//         },
//         codeSent: (String verificationID, int? token) {
//           // This callback will be called when the verification code is sent to the provided phone number.
//           // You can navigate to the verification screen and pass the verification ID to it.
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => PhoneNumberSigninCodeVerify(verificationID: verificationID),
//             ),
//           );
//         },
//         codeAutoRetrievalTimeout: (String verificationID) {
//           // This callback will be called when the auto-resolution timeout has been reached.
//           // You can handle this scenario if needed.
//           Utils().toastmsg('Verification timeout', context);
//         },
//       );
//     } catch (error) {
//       Utils().toastmsg('Error: $error', context);
//     }
//   }
//
//   static Future<void> otpVerification(BuildContext context, String verificationId, String otp) async {
//     try {
//       final credential = PhoneAuthProvider.credential(
//         verificationId: verificationId,
//         smsCode: otp,
//       );
//
//       await _auth.signInWithCredential(credential);
//
//       Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(
//           builder: (context) => crud(),
//         ),
//             (route) => false,
//       );
//     } catch (error) {
//       Utils().toastmsg('Error: $error', context);
//     }
//   }
//
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../Ui/app_screens/profile/personal_info.dart';
import '../Ui/auth_screens/signup/phoneNumberSignup_codeVerify.dart';
import '../utils/utils.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<void> signin(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const personalInfo(),
        ),
        (route) => false,
      );
    } catch (error) {
      Utils().toastmsg('Sign in failed: $error', context);
    }
  }

  static Future<void> signup(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const personalInfo(),
        ),
        (route) => false,
      );
    } catch (error) {
      Utils().toastmsg('Sign up failed: $error', context);
    }
  }

  static Future<void> signUpWithPhoneNo(
    BuildContext context,
    final fullPhoneNumber,
    Function() onVerificationCompleted,
    Function() onVerificationFailed, // Add a callback for verification failure
  ) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: fullPhoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // This callback will be called if the auto-resolution succeeds with a phone auth credential.
        // You can use this credential to sign in the user.
        await _auth.signInWithCredential(credential);
        // Call the provided callback to indicate verification completion
        onVerificationCompleted();
      },
      verificationFailed: (FirebaseAuthException e) {
        Utils().toastmsg('Verification failed: ${e.message}', context);
        // Call the provided callback to indicate verification failure
        onVerificationFailed();
      },
      codeSent: (String verificationID, int? token) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                PhoneNumberSigninCodeVerify(verificationID: verificationID),
          ),
        ).then((_) {
          Utils().toastmsg(
              'OTP sent but not verified, initiate process again!', context);
          return;
        });
      },
      codeAutoRetrievalTimeout: (String verificationID) {
        Utils().toastmsg('Verification timeout', context);
      },
    );
  }

  static Future<void> otpVerification(
      BuildContext context, String verificationId, String otp) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );

      await _auth.signInWithCredential(credential);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const personalInfo(),
        ),
        (route) => false,
      );
    } catch (error) {
      Utils().toastmsg('Error: $error', context);
    }
  }

  static Future<void> signinWithGoogle(
    BuildContext context,
  ) async {
    try {
      await GoogleSignIn().signOut();

      // Sign in with Google
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        // Get authentication details
        GoogleSignInAuthentication? googleAuth =
            await googleUser.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );

        // Sign in with Firebase Auth using the obtained credential
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        if (userCredential != null) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const personalInfo(),
            ),
            (route) => false,
          );
        }
      } else {
        print('User cancelled account selection.');
      }
    } catch (e) {
      Utils().toastmsg(e, context);
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
