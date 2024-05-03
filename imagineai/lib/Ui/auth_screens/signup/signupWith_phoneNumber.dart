// import 'package:flutter/material.dart';
// import 'package:country_code_picker/country_code_picker.dart';
// import 'package:imagineai/Ui/auth_screens/signup/phoneNumberSignup_codeVerify.dart';
// import 'package:imagineai/Ui/auth_screens/signup/signupWith_email_password.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:imagineai/Ui/themeStyle.dart';
// import '../../../firebaseServices/auth_service.dart';
// import '../../../utils/utils.dart';
//
// class SigninScreenWith_PhoneNumber extends StatefulWidget {
//   const SigninScreenWith_PhoneNumber({Key? key}) : super(key: key);
//
//   @override
//   _SigninScreenWith_PhoneNumberState createState() =>
//       _SigninScreenWith_PhoneNumberState();
// }
//
// class _SigninScreenWith_PhoneNumberState
//     extends State<SigninScreenWith_PhoneNumber> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController phoneNumberController = TextEditingController();
//   final FirebaseAuth auth = FirebaseAuth.instance;
//   bool loading = false;
//   String _selectedCountryCode = '+92';
//   final AuthService _authService = AuthService();
//
//   String getHintText() {
//     // If the selected country code is +92, show hint for 9 digits
//     return _selectedCountryCode == '+92'
//         ? 'Enter 10 digits'
//         : 'Enter phone number';
//   }
//
//   void signupWithPhoneNo(BuildContext context) {
//     final String phoneNumber = phoneNumberController.text;
//     final String fullPhoneNumber = '$_selectedCountryCode$phoneNumber';
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         loading = true;
//       });
//       auth.verifyPhoneNumber(
//         phoneNumber: fullPhoneNumber!.toString(),
//         verificationCompleted: (_) {},
//         verificationFailed: (e) {
//           setState(() {
//             loading = false;
//           });
//           Utils().toastmsg(e.toString(), context);
//         },
//         codeSent: (String verificationID, int? token) {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) =>
//                   PhoneNumberSigninCodeVerify(verificationID: verificationID),
//             ),
//           );
//         },
//         codeAutoRetrievalTimeout: (e) {
//           setState(() {
//             loading = false;
//           });
//           Utils().toastmsg(e.toString(), context);
//         },
//       );
//     }
//   }
//
//   @override
//   void dispose() {
//     phoneNumberController.dispose();
//     super.dispose();
//   }
//
//   String? fullPhoneNumber;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Row(
//           children: [
//             Text(
//               'Hello there ',
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
//             ),
//             Text(
//               '👋 ',
//               style: TextStyle(fontSize: 25),
//             ),
//           ],
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               const Text(
//                 'Sign In',
//                 textAlign: TextAlign.left,
//                 style: TextStyle(
//                   fontSize: 30,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               const Text(
//                 'Please enter your Phone number to sign in',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 17),
//               ),
//               const SizedBox(height: 10),
//               const SizedBox(height: 30),
//               Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     TextFormField(
//                       controller: phoneNumberController,
//                       keyboardType: TextInputType.phone,
//                       decoration: InputDecoration(
//                         labelText: 'Phone Number',
//                         hintText:
//                         getHintText(), // Show appropriate hint text based on the selected country code
//                         enabledBorder: const UnderlineInputBorder(
//                           borderSide: BorderSide(color: Colors.grey),
//                         ),
//                         focusedBorder: const UnderlineInputBorder(
//                           borderSide: BorderSide(
//                               color: Colors
//                                   .purple), // Customize the color
//                         ),
//                         prefixIcon: CountryCodePicker(
//                           onChanged: (CountryCode? countryCode) {
//                             setState(() {
//                               _selectedCountryCode =
//                                   countryCode?.dialCode ?? '+92';
//                             });
//                           },
//                           initialSelection:
//                           'PK', // Initial country code
//                           favorite: const [
//                             '+92',
//                             'PK'
//                           ], // Optional: Set favorite country codes
//                           showCountryOnly:
//                           false, // Optional: Show country name and code together
//                           showFlagMain:
//                           true, // Optional: Show the main flag
//                           showFlagDialog:
//                           true, // Optional: Show flag in dialog to select country
//                           alignLeft:
//                           false, // Optional: Align left flag
//                         ),
//                       ),
//                       validator: (value) {
//                         if (value?.isEmpty ?? true) {
//                           return 'Please enter a phone number';
//                         }
//                         // Additional validation can be added here if needed
//                         return null;
//                       },
//                       onChanged: (value) {
//                         // Check if the selected country code is +92
//                         if (_selectedCountryCode == '+92') {
//                           // If the input length exceeds 9 digits, truncate it to 9 digits
//                           if (value.length > 10) {
//                             value = value.substring(0, 10);
//                             phoneNumberController.text =
//                                 value; // Update the text controller
//                             phoneNumberController.selection =
//                                 TextSelection.fromPosition(
//                                     TextPosition(offset: value.length));
//                           }
//                         }
//                         // Concatenate the selected country code with the input value
//                       },
//                     )
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 height: 110,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text(
//                     "Don't have an account? ",
//                     style: TextStyle(
//                       fontSize: 18,
//                       color: Colors.black, // Adjust color as needed
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) =>
//                           const SignupScreenWith_email_password(),
//                         ),
//                       );
//                     },
//                     child: RichText(
//                       textAlign: TextAlign.center,
//                       text: const TextSpan(
//                         children: [
//                           TextSpan(
//                             text: "Sign up",
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: Color(
//                                   0xFF5C3DF6), // Adjust color as needed
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 50,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Expanded(
//                     child: Divider(
//                       color: Colors.grey.shade200,
//                       thickness: 2,
//                     ),
//                   ),
//                   const Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 8),
//                     child: Text(
//                       "or continue with",
//                       style: TextStyle(
//                         fontSize: 18,
//                         color: Colors.black, // Adjust color as needed
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: Divider(
//                       color: Colors.grey.shade200,
//                       thickness: 2,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 40,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   OutlinedButton(
//                     onPressed: () {
//                       // Handle button press
//                     },
//                     style: OutlinedButton.styleFrom(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: Image.asset(
//                       'assets/material/thirdPartyIcons/googleIcon.png', // Replace with your image path
//                       width: 35,
//                       height: 35,
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   OutlinedButton(
//                     onPressed: () {
//                       // Handle button press
//                     },
//                     style: OutlinedButton.styleFrom(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: Image.asset(
//                       'assets/material/thirdPartyIcons/facebookIcon.png', // Replace with your image path
//                       width: 25,
//                       height: 25,
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   OutlinedButton(
//                     onPressed: () {
//                       // Handle button press
//                     },
//                     style: OutlinedButton.styleFrom(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: Icon(
//                       Icons.mail_outline,
//                       size: 25,
//                       color: Colors.grey.shade800,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 110,
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   setState(() {
//                     loading = true;
//                   });
//                   AuthService
//                       .signUpWithPhoneNo(context, phoneNumberController.text,
//                       _selectedCountryCode)
//                       .then((_) {
//                     setState(() {
//                       loading = false;
//                     });
//                   }).catchError((error) {
//                     setState(() {
//                       loading = false;
//                     });
//                     Utils().toastmsg(error.toString(), context);
//                   });
//                 },
//                 style: ElevatedButton.styleFrom(
//                   foregroundColor: Colors.white,
//                   backgroundColor: customPurple,
//                   padding: const EdgeInsets.symmetric(vertical: 15),
//                 ),
//                 child: loading
//                     ? const SizedBox(
//                   width: 26,
//                   height: 26,
//                   child: CircularProgressIndicator(
//                     strokeWidth: 3,
//                     color: Colors.white,
//                   ),
//                 )
//                     : const Text(
//                   'Continue',
//                   style: TextStyle(
//                     fontSize: 18,
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:imagineai/Ui/auth_screens/signup/phoneNumberSignup_codeVerify.dart';
import 'package:imagineai/Ui/auth_screens/signup/signupWith_email_password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:imagineai/Ui/themeStyle.dart';
import '../../../firebaseServices/auth_service.dart';
import '../../../utils/utils.dart';

class SigninScreenWith_PhoneNumber extends StatefulWidget {
  const SigninScreenWith_PhoneNumber({Key? key}) : super(key: key);

  @override
  _SigninScreenWith_PhoneNumberState createState() =>
      _SigninScreenWith_PhoneNumberState();
}

class _SigninScreenWith_PhoneNumberState
    extends State<SigninScreenWith_PhoneNumber> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController phoneNumberController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool loading = false;
  String _selectedCountryCode = '+92';
  final AuthService _authService = AuthService();

  String getHintText() {
    // If the selected country code is +92, show hint for 9 digits
    return _selectedCountryCode == '+92'
        ? 'Enter 10 digits'
        : 'Enter phone number';
  }

  void signupWithPhoneNo(BuildContext context) {
    final String phoneNumber = phoneNumberController.text;
    final String fullPhoneNumber = '$_selectedCountryCode$phoneNumber';
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      auth.verifyPhoneNumber(
        phoneNumber: fullPhoneNumber!.toString(),
        verificationCompleted: (_) {},
        verificationFailed: (e) {
          setState(() {
            loading = false;
          });
          Utils().toastmsg(e.toString(), context);
        },
        codeSent: (String verificationID, int? token) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  PhoneNumberSigninCodeVerify(verificationID: verificationID),
            ),
          );
        },
        codeAutoRetrievalTimeout: (e) {
          setState(() {
            loading = false;
          });
          Utils().toastmsg(e.toString(), context);
        },
      );
    }
  }

  @override
  void dispose() {
    phoneNumberController.dispose();
    super.dispose();
  }

  String? fullPhoneNumber;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Text(
              'Hello there ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            Text(
              '👋 ',
              style: TextStyle(fontSize: 25),
            ),
          ],
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Sign In',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Please enter your Phone number to sign in',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17),
                ),
                const SizedBox(height: 10),
                const SizedBox(height: 30),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: phoneNumberController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          hintText:
                          getHintText(), // Show appropriate hint text based on the selected country code
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors
                                    .purple), // Customize the color
                          ),
                          prefixIcon: CountryCodePicker(
                            onChanged: (CountryCode? countryCode) {
                              setState(() {
                                _selectedCountryCode =
                                    countryCode?.dialCode ?? '+92';
                              });
                            },
                            initialSelection:
                            'PK', // Initial country code
                            favorite: const [
                              '+92',
                              'PK'
                            ], // Optional: Set favorite country codes
                            showCountryOnly:
                            false, // Optional: Show country name and code together
                            showFlagMain:
                            true, // Optional: Show the main flag
                            showFlagDialog:
                            true, // Optional: Show flag in dialog to select country
                            alignLeft:
                            false, // Optional: Align left flag
                          ),
                        ),
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please enter a phone number';
                          }
                          // Additional validation can be added here if needed
                          return null;
                        },
                        onChanged: (value) {
                          // Check if the selected country code is +92
                          if (_selectedCountryCode == '+92') {
                            // If the input length exceeds 9 digits, truncate it to 9 digits
                            if (value.length > 10) {
                              value = value.substring(0, 10);
                              phoneNumberController.text =
                                  value; // Update the text controller
                              phoneNumberController.selection =
                                  TextSelection.fromPosition(
                                      TextPosition(offset: value.length));
                            }
                          }
                          // Concatenate the selected country code with the input value
                        },
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 110,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black, // Adjust color as needed
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                            const SignupScreenWith_email_password(),
                          ),
                        );
                      },
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: "Sign up",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(
                                    0xFF5C3DF6), // Adjust color as needed
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.grey.shade200,
                        thickness: 2,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        "or continue with",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black, // Adjust color as needed
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.grey.shade200,
                        thickness: 2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        // Handle button press
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Image.asset(
                        'assets/material/thirdPartyIcons/googleIcon.png', // Replace with your image path
                        width: 35,
                        height: 35,
                      ),
                    ),
                    const SizedBox(width: 16),
                    OutlinedButton(
                      onPressed: () {
                        // Handle button press
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Image.asset(
                        'assets/material/thirdPartyIcons/facebookIcon.png', // Replace with your image path
                        width: 25,
                        height: 25,
                      ),
                    ),
                    const SizedBox(width: 16),
                    OutlinedButton(
                      onPressed: () {
                        // Handle button press
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Icon(
                        Icons.mail_outline,
                        size: 25,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 110,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      loading = true;
                    });
                    AuthService
                        .signUpWithPhoneNo(context, phoneNumberController.text,
                        _selectedCountryCode)
                        .then((_) {
                      setState(() {
                        loading = false;
                      });
                    }).catchError((error) {
                      setState(() {
                        loading = false;
                      });
                      Utils().toastmsg(error.toString(), context);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: customPurple,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: loading
                      ? const SizedBox(
                    width: 26,
                    height: 26,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: Colors.white,
                    ),
                  )
                      : const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
