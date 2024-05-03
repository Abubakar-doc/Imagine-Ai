import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:imagineai/Ui/app_screens/crud.dart';
import 'package:imagineai/Ui/auth_screens/signin/signinWith_email_password.dart';
import 'package:imagineai/Ui/auth_screens/signup/signupWith_phoneNumber.dart';
import 'package:imagineai/Ui/auth_screens/signup/signupWith_email_password.dart';
import 'package:imagineai/Ui/themeStyle.dart';
import 'package:imagineai/utils/utils.dart';

class signinParentScreen extends StatelessWidget {
  const signinParentScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 100),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: Image.asset(
                  'assets/Imagine Ai logo round.png',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    const Text(
                      'Imagine AI',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Welcome let\'s dive into your account!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 50),
                    SizedBox(
                      height: 50, // Adjust the height as needed
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.black,
                          side: BorderSide(
                            color: Colors.grey.shade400,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .center, // Align items in the center horizontally
                            children: [
                              SizedBox(
                                width: 40,
                                height: 40,
                                child: Image.asset(
                                  'assets/material/thirdPartyIcons/googleIcon.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Continue with Google',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 50, // Adjust the height as needed
                      child: OutlinedButton(
                        // onPressed: () {
                        // },
                        onPressed: () async {
                          final UserCredential userCredential =
                          await signin_withFacebook(context);
                          if (context.mounted) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => crud()));
                          }
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.black,
                          side: BorderSide(
                            color: Colors.grey.shade400,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 30,
                                height: 30,
                                child: Image.asset(
                                  'assets/material/thirdPartyIcons/facebookIcon.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Continue with Facebook',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 50, // Adjust the height as needed
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const SigninScreenWith_PhoneNumber(),
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.black,
                          side: BorderSide(
                            color: Colors.grey.shade400,
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.phone,
                                size: 30,
                                color: Colors.black,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Continue with Phone no',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const SigninScreenWith_email_password(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            // backgroundColor: const Color(0xFF5C3DF6)
                            backgroundColor: customPurple),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          child: Text(
                            'Sign in with password',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don\'t have an account? ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color:
                                Colors.black, // Change the color here if needed
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const SignupScreenWith_email_password(),
                              ),
                            );
                          },
                          child: const Text(
                            'Sign up',
                            style: TextStyle(
                              color: customPurple,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  signin_withFacebook(BuildContext context) async {
    try {
      // final loginResult = await FacebookAuth.instance.login();
      // if (loginResult.status == LoginStatus.success) {
      //   final OAuthCredential facebookOAuthCredential =
      //   FacebookAuthProvider.credential(loginResult.accessToken!.token);
      //
      //   // Sign in with Facebook credential
      //   final UserCredential? userCredential = await FirebaseAuth.instance.signInWithCredential(facebookOAuthCredential);
      //
      //   if (userCredential != null) {
      //     // Navigate to the next screen upon successful authentication
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => crud()),
      //     );
      //   } else {
      //     Utils().toastmsg("Failed to sign in with Facebook", context);
      //   }
      // }
      // else {
      //   Utils().toastmsg("Facebook login failed", context);
      // }
    } catch (e) {
      print(e);
      Utils().toastmsg(e.toString(), context);
    }
  }


}
