// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:imagineai/Ui/auth_screens/signin/signinWith_email_password.dart';
// import 'package:imagineai/Ui/auth_screens/signup/signupWith_phoneNumber.dart';
// import 'package:imagineai/Ui/auth_screens/signup/signupWith_email_password.dart';
// import 'package:imagineai/Ui/themeStyle.dart';
// import 'package:imagineai/firebaseServices/auth_service.dart';
// import '../../../utils/utils.dart';
// import '../../widgets/loadingContainer.dart';
//
// class signinParentScreen extends StatefulWidget {
//   const signinParentScreen({Key? key});
//
//   @override
//   State<signinParentScreen> createState() => _signinParentScreenState();
// }
//
// class _signinParentScreenState extends State<signinParentScreen> {
//   bool loading = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             child: Center(
//               child: Column(
//                 children: [
//                   const SizedBox(height: 100),
//                   SizedBox(
//                     width: MediaQuery.of(context).size.width * 0.3,
//                     child: Image.asset(
//                       'assets/Imagine Ai logo round.png',
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 30,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 30),
//                     child: Column(
//                       children: [
//                         const Text(
//                           'Imagine AI',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontSize: 34,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         const Text(
//                           'Welcome let\'s dive into your account!',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         const SizedBox(height: 50),
//                         SizedBox(
//                           height: 50, // Adjust the height as needed
//                           child: OutlinedButton(
//                             onPressed: () async {
//                               setState(() {
//                                 loading = true;
//                               });
//                               await AuthService.signinWithGoogle(context);
//                               setState(() {
//                                 loading = false;
//                               });
//                             },
//                             style: OutlinedButton.styleFrom(
//                               foregroundColor: Colors.black,
//                               side: BorderSide(
//                                 color: Colors.grey.shade400,
//                               ),
//                             ),
//                             child: Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 12),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   loading
//                                       ? const SizedBox(
//                                           width: 26, // Set the desired width
//                                           height: 26, // Set the desired height
//                                           child: CircularProgressIndicator(
//                                             strokeWidth:
//                                                 3, // Adjust the thickness if needed
//                                             color: Colors
//                                                 .black, // Set color to white
//                                           ),
//                                         )
//                                       : SizedBox(
//                                           width: 40,
//                                           height: 40,
//                                           child: Image.asset(
//                                             'assets/material/thirdPartyIcons/googleIcon.png',
//                                             fit: BoxFit.contain,
//                                           ),
//                                         ),
//                                   const SizedBox(width: 8),
//                                   const Text(
//                                     'Continue with Google',
//                                     style: TextStyle(
//                                       fontSize: 18,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         SizedBox(
//                           height: 50, // Adjust the height as needed
//                           child: OutlinedButton(
//                             onPressed: () async {
//                               await AuthService.signinwithFacebook(context);
//                             },
//                             style: OutlinedButton.styleFrom(
//                               foregroundColor: Colors.black,
//                               side: BorderSide(
//                                 color: Colors.grey.shade400,
//                               ),
//                             ),
//                             child: Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 12),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   SizedBox(
//                                     width: 30,
//                                     height: 30,
//                                     child: Image.asset(
//                                       'assets/material/thirdPartyIcons/facebookIcon.png',
//                                       fit: BoxFit.contain,
//                                     ),
//                                   ),
//                                   const SizedBox(width: 8),
//                                   const Text(
//                                     'Continue with Facebook',
//                                     style: TextStyle(
//                                       fontSize: 18,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         SizedBox(
//                           height: 50, // Adjust the height as needed
//                           child: OutlinedButton(
//                             onPressed: () {
//                               Utils().pushSlideTransition(context, const SigninScreenWith_PhoneNumber());
//                             },
//                             style: OutlinedButton.styleFrom(
//                               foregroundColor: Colors.black,
//                               side: BorderSide(
//                                 color: Colors.grey.shade400,
//                               ),
//                             ),
//                             child: const Padding(
//                               padding: EdgeInsets.symmetric(horizontal: 12),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Icon(
//                                     Icons.phone,
//                                     size: 30,
//                                     color: Colors.black,
//                                   ),
//                                   SizedBox(width: 8),
//                                   Text(
//                                     'Continue with Phone no',
//                                     style: TextStyle(
//                                       fontSize: 18,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 50),
//                         SizedBox(
//                           height: 50,
//                           child: ElevatedButton(
//                             onPressed: () {
//                               Utils().pushSlideTransition(context, const SigninScreenWith_email_password());
//                             },
//                             style: ElevatedButton.styleFrom(
//                                 // backgroundColor: const Color(0xFF5C3DF6)
//                                 backgroundColor: customPurple),
//                             child: const Padding(
//                               padding: EdgeInsets.symmetric(horizontal: 50),
//                               child: Text(
//                                 'Sign in with password',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 18,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 40),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const Text(
//                               'Don\'t have an account? ',
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w500,
//                                 color: Colors
//                                     .black, // Change the color here if needed
//                               ),
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 Utils().pushSlideTransition(context, const SignupScreenWith_email_password());
//                               },
//                               child: const Text(
//                                 'Sign up',
//                                 style: TextStyle(
//                                   color: customPurple,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           if (loading) const loadingcontainer(),
//         ],
//       ),
//     );
//   }
// }


import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:imagineai/Ui/auth_screens/signin/signinWith_email_password.dart';
import 'package:imagineai/Ui/auth_screens/signup/signupWith_phoneNumber.dart';
import 'package:imagineai/Ui/auth_screens/signup/signupWith_email_password.dart';
import 'package:imagineai/Ui/theme/themeStyle.dart';
import 'package:imagineai/firebaseServices/auth_service.dart';
import '../../../utils/utils.dart';
import '../../widgets/loadingContainer.dart';

class signinParentScreen extends StatefulWidget {
  const signinParentScreen({Key? key});

  @override
  State<signinParentScreen> createState() => _signinParentScreenState();
}

class _signinParentScreenState extends State<signinParentScreen> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: lightTheme,
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
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
                              onPressed: () async {
                                setState(() {
                                  loading = true;
                                });
                                await AuthService.signinWithGoogle(context);
                                setState(() {
                                  loading = false;
                                });
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.black,
                                side: BorderSide(
                                  color: Colors.grey.shade400,
                                ),
                              ),
                              child: Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    loading
                                        ? const SizedBox(
                                      width: 26, // Set the desired width
                                      height: 26, // Set the desired height
                                      child: CircularProgressIndicator(
                                        strokeWidth:
                                        3, // Adjust the thickness if needed
                                        color: Colors
                                            .black, // Set color to white
                                      ),
                                    )
                                        : SizedBox(
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
                              onPressed: () async {
                                await AuthService.signinwithFacebook(context);
                              },
                              style: OutlinedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 50),
                                foregroundColor: Colors.black,
                                side: BorderSide(
                                  color: Colors.grey.shade400,
                                ),
                              ),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
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
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 50, // Adjust the height as needed
                            child: OutlinedButton(
                              onPressed: () {
                                Utils().pushSlideTransition(context, const SigninScreenWith_PhoneNumber());
                              },
                              style: OutlinedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 50),
                                foregroundColor: Colors.black,
                                side: BorderSide(
                                  color: Colors.grey.shade400,
                                ),
                              ),
                              child: const SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Padding(
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
                              )
                            ),
                          ),
                          const SizedBox(height: 50),
                          SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                Utils().pushSlideTransition(context, const SigninScreenWith_email_password());
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.zero, // Remove default padding
                                backgroundColor: customPurple,
                                minimumSize: const Size(double.infinity, 50), // Make button take all available horizontal space
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 30), // Adjust the horizontal padding as needed
                                child: Center(
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
                                  color: Colors
                                      .black, // Change the color here if needed
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Utils().pushSlideTransition(context, const SignupScreenWith_email_password());
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
            if (loading) const loadingcontainer(),
          ],
        ),
      ),
    );
  }
}
