// // import 'package:flutter/material.dart';
// // import 'package:flutter/widgets.dart';
// // import 'package:imagineai/Ui/auth_screens/signup/signupWith_email_password.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:imagineai/Ui/themeStyle.dart';
// // import 'package:imagineai/firebaseServices/auth_service.dart';
// //
// // import '../reset_password/enter_email.dart';
// //
// // class SigninScreenWith_email_password extends StatefulWidget {
// //   const SigninScreenWith_email_password({Key? key}) : super(key: key);
// //
// //   @override
// //   _SigninScreenWith_email_passwordState createState() =>
// //       _SigninScreenWith_email_passwordState();
// // }
// //
// // class _SigninScreenWith_email_passwordState
// //     extends State<SigninScreenWith_email_password> {
// //   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
// //   final TextEditingController emailController = TextEditingController();
// //   final TextEditingController passwordController = TextEditingController();
// //   final FirebaseAuth auth = FirebaseAuth.instance;
// //   bool loading = false;
// //   bool _isObscure = true;
// //
// //   @override
// //   void dispose() {
// //     emailController.dispose();
// //     passwordController.dispose();
// //     super.dispose();
// //   }
// //
// //   void signin() {
// //     if (_formKey.currentState!.validate()) {
// //       setState(() {
// //         loading = true;
// //       });
// //       AuthService.signin(context, emailController.text,
// //           passwordController.text); // Call AuthService's signin method
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Row(
// //           children: [
// //             Text(
// //               'Welcome back',
// //               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
// //             ),
// //             Text(
// //               '👋 ',
// //               style: TextStyle(fontSize: 25),
// //             ),
// //           ],
// //         ),
// //       ),
// //       body: Container(
// //         height: MediaQuery.of(context).size.height,
// //         alignment: Alignment.bottomCenter,
// //         child: SingleChildScrollView(
// //           child: Padding(
// //             padding: const EdgeInsets.all(20.0),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.stretch,
// //               children: [
// //                 const Text(
// //                   'Sign In',
// //                   textAlign: TextAlign.left,
// //                   style: TextStyle(
// //                     fontSize: 30,
// //                     fontWeight: FontWeight.bold,
// //                   ),
// //                 ),
// //                 const SizedBox(height: 10),
// //                 const Text(
// //                   'Please enter your email & password to sign in',
// //                   textAlign: TextAlign.center,
// //                   style: TextStyle(fontSize: 17),
// //                 ),
// //                 const SizedBox(height: 10),
// //                 const SizedBox(
// //                     height: 30), // Add space between title and input fields
// //                 Form(
// //                   key: _formKey,
// //                   child: Column(
// //                     children: [
// //                       TextFormField(
// //                         controller: emailController,
// //                         decoration: const InputDecoration(
// //                           labelText: 'Email',
// //                           enabledBorder: UnderlineInputBorder(
// //                             borderSide: BorderSide(
// //                                 color:
// //                                 Colors.grey), // Customize the color as needed
// //                           ),
// //                           focusedBorder: UnderlineInputBorder(
// //                             borderSide: BorderSide(
// //                                 color: customPurple), // Customize the color as needed
// //                           ),
// //                           suffixIcon: Icon(Icons.alternate_email),
// //                         ),
// //                         validator: (value) {
// //                           if (value?.isEmpty ?? true) {
// //                             return 'Enter Email';
// //                           }
// //                           return null;
// //                         },
// //                       ),
// //                       const SizedBox(
// //                         height: 20,
// //                       ),
// //                       TextFormField(
// //                         controller: passwordController,
// //                         obscureText: _isObscure,
// //                         decoration: InputDecoration(
// //                           labelText: 'Password',
// //                           enabledBorder: const UnderlineInputBorder(
// //                             borderSide: BorderSide(
// //                                 color:
// //                                 Colors.grey), // Customize the color as needed
// //                           ),
// //                           focusedBorder: const UnderlineInputBorder(
// //                             borderSide: BorderSide(
// //                                 color:
// //                                 customPurple), // Customize the color as needed
// //                           ),
// //                           suffixIcon: IconButton(
// //                             icon: Icon(
// //                               _isObscure
// //                                   ? Icons.visibility_off
// //                                   : Icons.visibility,
// //                             ),
// //                             onPressed: () {
// //                               setState(() {
// //                                 _isObscure = !_isObscure;
// //                               });
// //                             },
// //                           ),
// //                         ),
// //                         validator: (value) {
// //                           if (value?.isEmpty ?? true) {
// //                             return 'Enter password';
// //                           }
// //                           return null;
// //                         },
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //                 const SizedBox(
// //                   height: 40,
// //                 ),
// //                 Divider(
// //                   color: Colors.grey.shade200,
// //                   thickness: 2,
// //                 ),
// //                 const SizedBox(
// //                   height: 40,
// //                 ),
// //                 GestureDetector(
// //                   onTap:(){
// //                     Navigator.push(
// //                       context,
// //                       MaterialPageRoute(
// //                         builder: (context) => const emailTo_reset_password(),
// //                       ),
// //                     );
// //                   },
// //                   child: const Text(
// //                     'Forgot password?',
// //                     textAlign: TextAlign.center,
// //                     style: TextStyle(
// //                         fontSize: 18,
// //                         fontWeight: FontWeight.bold,
// //                         color: customPurple),
// //                   ),
// //                 ),
// //                 const SizedBox(
// //                   height: 30,
// //                 ),
// //                 Row(
// //                   mainAxisAlignment: MainAxisAlignment.center,
// //                   children: [
// //                     const Text(
// //                       "Don't have an account? ",
// //                       style: TextStyle(
// //                         fontSize: 18,
// //                         color: Colors.black, // Adjust color as needed
// //                       ),
// //                     ),
// //                     GestureDetector(
// //                       onTap: () {
// //                         Navigator.pushReplacement(
// //                           context,
// //                           MaterialPageRoute(
// //                             builder: (context) =>
// //                             const SignupScreenWith_email_password(),
// //                           ),
// //                         );
// //                       },
// //                       child: RichText(
// //                         textAlign: TextAlign.center,
// //                         text: const TextSpan(
// //                           children: [
// //                             TextSpan(
// //                               text: "Sign up",
// //                               style: TextStyle(
// //                                 fontSize: 18,
// //                                 fontWeight: FontWeight.bold,
// //                                 color:
// //                                 Color(0xFF5C3DF6), // Adjust color as needed
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //                 const SizedBox(
// //                   height: 30,
// //                 ),
// //                 Row(
// //                   mainAxisAlignment: MainAxisAlignment.center,
// //                   children: [
// //                     Expanded(
// //                       child: Divider(
// //                         color: Colors.grey.shade200,
// //                         thickness: 2,
// //                       ),
// //                     ),
// //                     const Padding(
// //                       padding: EdgeInsets.symmetric(horizontal: 8),
// //                       child: Text(
// //                         "or continue with",
// //                         style: TextStyle(
// //                           fontSize: 18,
// //                           color: Colors.black, // Adjust color as needed
// //                         ),
// //                       ),
// //                     ),
// //                     Expanded(
// //                       child: Divider(
// //                         color: Colors.grey.shade200,
// //                         thickness: 2,
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //                 const SizedBox(
// //                   height: 40,
// //                 ),
// //                 Row(
// //                   mainAxisAlignment: MainAxisAlignment.center,
// //                   children: [
// //                     OutlinedButton(
// //                       onPressed: () {
// //                         // Handle button press
// //                       },
// //                       style: OutlinedButton.styleFrom(
// //                         shape: RoundedRectangleBorder(
// //                           borderRadius: BorderRadius.circular(8),
// //                         ),
// //                       ),
// //                       child: Image.asset(
// //                         'assets/material/thirdPartyIcons/googleIcon.png',
// //                         // Replace with your image path
// //                         width: 35,
// //                         height: 35,
// //                       ),
// //                     ),
// //                     const SizedBox(width: 16),
// //                     OutlinedButton(
// //                       onPressed: () {
// //                         // Handle button press
// //                       },
// //                       style: OutlinedButton.styleFrom(
// //                         shape: RoundedRectangleBorder(
// //                           borderRadius: BorderRadius.circular(8),
// //                         ),
// //                       ),
// //                       child: Image.asset(
// //                         'assets/material/thirdPartyIcons/facebookIcon.png',
// //                         // Replace with your image path
// //                         width: 25,
// //                         height: 25,
// //                       ),
// //                     ),
// //                     const SizedBox(width: 16),
// //                     OutlinedButton(
// //                       onPressed: () {
// //                         // Handle button press
// //                       },
// //                       style: OutlinedButton.styleFrom(
// //                         shape: RoundedRectangleBorder(
// //                           borderRadius: BorderRadius.circular(8),
// //                         ),
// //                       ),
// //                       child: Icon(
// //                         Icons.phone,
// //                         size: 25,
// //                         color: Colors.grey.shade800,
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //                 const SizedBox(
// //                   height: 40,
// //                 ),
// //                 ElevatedButton(
// //                   onPressed: () {
// //                     signin();
// //                   },
// //                   style: ElevatedButton.styleFrom(
// //                     foregroundColor: Colors.white,
// //                     backgroundColor: customPurple, // Text color
// //                     padding: const EdgeInsets.symmetric(vertical: 15),
// //                   ),
// //                   child: loading
// //                       ? const SizedBox(
// //                     width: 26, // Set the desired width
// //                     height: 26, // Set the desired height
// //                     child: CircularProgressIndicator(
// //                       strokeWidth: 3, // Adjust the thickness if needed
// //                       color: Colors.white, // Set color to white
// //                     ),
// //                   )
// //                       : const Text(
// //                     'Sign In',
// //                     style: TextStyle(
// //                       fontSize: 18, // Button text size
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
//
//
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:imagineai/Ui/auth_screens/signup/signupWith_email_password.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:imagineai/Ui/themeStyle.dart';
// import 'package:imagineai/firebaseServices/auth_service.dart';
//
// import '../reset_password/enter_email.dart';
//
// class SigninScreenWith_email_password extends StatefulWidget {
//   const SigninScreenWith_email_password({Key? key}) : super(key: key);
//
//   @override
//   _SigninScreenWith_email_passwordState createState() =>
//       _SigninScreenWith_email_passwordState();
// }
//
// class _SigninScreenWith_email_passwordState
//     extends State<SigninScreenWith_email_password> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final FirebaseAuth auth = FirebaseAuth.instance;
//   bool loading = false;
//   bool _isObscure = true;
//
//   @override
//   void dispose() {
//     emailController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }
//
//   void signin() {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         loading = true;
//       });
//       AuthService.signin(context, emailController.text,
//           passwordController.text); // Call AuthService's signin method
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Row(
//           children: [
//             Text(
//               'Welcome back',
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
//             ),
//             Text(
//               '👋 ',
//               style: TextStyle(fontSize: 25),
//             ),
//           ],
//         ),
//       ),
//       body: Container(
//         height: MediaQuery.of(context).size.height,
//         alignment: Alignment.topCenter,
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 const Text(
//                   'Sign In',
//                   textAlign: TextAlign.left,
//                   style: TextStyle(
//                     fontSize: 30,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 const Text(
//                   'Please enter your email & password to sign in',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(fontSize: 17),
//                 ),
//                 const SizedBox(height: 10),
//                 const SizedBox(
//                     height: 30), // Add space between title and input fields
//                 Form(
//                   key: _formKey,
//                   child: Column(
//                     children: [
//                       TextFormField(
//                         controller: emailController,
//                         decoration: const InputDecoration(
//                           labelText: 'Email',
//                           enabledBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(
//                                 color:
//                                 Colors.grey), // Customize the color as needed
//                           ),
//                           focusedBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(
//                                 color: customPurple), // Customize the color as needed
//                           ),
//                           suffixIcon: Icon(Icons.alternate_email),
//                         ),
//                         validator: (value) {
//                           if (value?.isEmpty ?? true) {
//                             return 'Enter Email';
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       TextFormField(
//                         controller: passwordController,
//                         obscureText: _isObscure,
//                         decoration: InputDecoration(
//                           labelText: 'Password',
//                           enabledBorder: const UnderlineInputBorder(
//                             borderSide: BorderSide(
//                                 color:
//                                 Colors.grey), // Customize the color as needed
//                           ),
//                           focusedBorder: const UnderlineInputBorder(
//                             borderSide: BorderSide(
//                                 color:
//                                 customPurple), // Customize the color as needed
//                           ),
//                           suffixIcon: IconButton(
//                             icon: Icon(
//                               _isObscure
//                                   ? Icons.visibility_off
//                                   : Icons.visibility,
//                             ),
//                             onPressed: () {
//                               setState(() {
//                                 _isObscure = !_isObscure;
//                               });
//                             },
//                           ),
//                         ),
//                         validator: (value) {
//                           if (value?.isEmpty ?? true) {
//                             return 'Enter password';
//                           }
//                           return null;
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 40,
//                 ),
//                 Divider(
//                   color: Colors.grey.shade200,
//                   thickness: 2,
//                 ),
//                 const SizedBox(
//                   height: 40,
//                 ),
//                 GestureDetector(
//                   onTap:(){
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const emailTo_reset_password(),
//                       ),
//                     );
//                   },
//                   child: const Text(
//                     'Forgot password?',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: customPurple),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text(
//                       "Don't have an account? ",
//                       style: TextStyle(
//                         fontSize: 18,
//                         color: Colors.black, // Adjust color as needed
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) =>
//                             const SignupScreenWith_email_password(),
//                           ),
//                         );
//                       },
//                       child: RichText(
//                         textAlign: TextAlign.center,
//                         text: const TextSpan(
//                           children: [
//                             TextSpan(
//                               text: "Sign up",
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color:
//                                 Color(0xFF5C3DF6), // Adjust color as needed
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Expanded(
//                       child: Divider(
//                         color: Colors.grey.shade200,
//                         thickness: 2,
//                       ),
//                     ),
//                     const Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 8),
//                       child: Text(
//                         "or continue with",
//                         style: TextStyle(
//                           fontSize: 18,
//                           color: Colors.black, // Adjust color as needed
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: Divider(
//                         color: Colors.grey.shade200,
//                         thickness: 2,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 40,
//                 ),
//                 Container( // Wrapped ElevatedButton with Container
//                   height: 50,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       signin();
//                     },
//                     style: ElevatedButton.styleFrom(
//                       foregroundColor: Colors.white,
//                       backgroundColor: customPurple, // Text color
//                       padding: const EdgeInsets.symmetric(vertical: 15),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: loading
//                         ? const SizedBox(
//                       width: 26, // Set the desired width
//                       height: 26, // Set the desired height
//                       child: CircularProgressIndicator(
//                         strokeWidth: 3, // Adjust the thickness if needed
//                         color: Colors.white, // Set color to white
//                       ),
//                     )
//                         : const Text(
//                       'Sign In',
//                       style: TextStyle(
//                         fontSize: 18, // Button text size
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:imagineai/Ui/auth_screens/signup/signupWith_email_password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:imagineai/Ui/themeStyle.dart';
import 'package:imagineai/firebaseServices/auth_service.dart';

import '../reset_password/enter_email.dart';

class SigninScreenWith_email_password extends StatefulWidget {
  const SigninScreenWith_email_password({Key? key}) : super(key: key);

  @override
  _SigninScreenWith_email_passwordState createState() =>
      _SigninScreenWith_email_passwordState();
}

class _SigninScreenWith_email_passwordState
    extends State<SigninScreenWith_email_password> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool loading = false;
  bool _isObscure = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void signin() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      AuthService.signin(context, emailController.text,
          passwordController.text); // Call AuthService's signin method
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Text(
              'Welcome back',
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
        alignment: Alignment.bottomCenter,
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
                  'Please enter your email & password to sign in',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17),
                ),
                const SizedBox(height: 10),
                const SizedBox(
                    height: 30), // Add space between title and input fields
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color:
                                Colors.grey), // Customize the color as needed
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: customPurple), // Customize the color as needed
                          ),
                          suffixIcon: Icon(Icons.alternate_email),
                        ),
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Enter Email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: passwordController,
                        obscureText: _isObscure,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                                color:
                                Colors.grey), // Customize the color as needed
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                                color:
                                customPurple), // Customize the color as needed
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Enter password';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Divider(
                  color: Colors.grey.shade200,
                  thickness: 2,
                ),
                const SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap:(){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const emailTo_reset_password(),
                      ),
                    );
                  },
                  child: const Text(
                    'Forgot password?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: customPurple),
                  ),
                ),
                const SizedBox(
                  height: 30,
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
                                color:
                                Color(0xFF5C3DF6), // Adjust color as needed
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
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
                        'assets/material/thirdPartyIcons/googleIcon.png',
                        // Replace with your image path
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
                        'assets/material/thirdPartyIcons/facebookIcon.png',
                        // Replace with your image path
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
                        Icons.phone,
                        size: 25,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  onPressed: () {
                    signin();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: customPurple, // Text color
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: loading
                      ? const SizedBox(
                    width: 26, // Set the desired width
                    height: 26, // Set the desired height
                    child: CircularProgressIndicator(
                      strokeWidth: 3, // Adjust the thickness if needed
                      color: Colors.white, // Set color to white
                    ),
                  )
                      : const Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 18, // Button text size
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}