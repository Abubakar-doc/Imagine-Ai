// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class AccountInfo extends StatefulWidget {
//   const AccountInfo({Key? key}) : super(key: key);
//
//   @override
//   State<AccountInfo> createState() => _AccountInfoState();
// }
//
// class _AccountInfoState extends State<AccountInfo> {
//   late User? _user;
//   String? _userId;
//   DateTime? _accountCreationDate;
//
//   @override
//   void initState() {
//     super.initState();
//     _initFirebaseAuth();
//   }
//
//   void _initFirebaseAuth() {
//     FirebaseAuth.instance.authStateChanges().listen((User? user) {
//       setState(() {
//         _user = user;
//         if (_user != null) {
//           if (_user!.email != null) {
//             _userId = _user!.email!;
//           } else if (_user!.phoneNumber != null) {
//             _userId = _user!.phoneNumber!;
//           } else {
//             _userId = null;
//           }
//           _accountCreationDate = _user!.metadata.creationTime;
//         } else {
//           _userId = null;
//           _accountCreationDate = null;
//         }
//       });
//     });
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Account Info',
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             fontSize: 25,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       body: SizedBox(
//         height: MediaQuery.of(context).size.height,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     if (_user != null)
//                       ListTile(
//                         title: Text('Account Created With: $_userId'),
//                       ),
//                     if (_accountCreationDate != null)
//                       ListTile(
//                         title: Text('Account Creation Date: $_accountCreationDate'),
//                       ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class AccountInfo extends StatefulWidget {
  const AccountInfo({Key? key}) : super(key: key);

  @override
  State<AccountInfo> createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  late User? _user;
  String? _userId;
  String? _accountCreationDate;
  String? _accountSignInDate;

  @override
  void initState() {
    super.initState();
    _initFirebaseAuth();
  }

  void _initFirebaseAuth() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() {
        _user = user;
        if (_user != null) {
          if (_user!.email != null) {
            _userId = _user!.email!;
          } else if (_user!.phoneNumber != null) {
            _userId = _user!.phoneNumber!;
          } else {
            _userId = null;
          }
          _accountCreationDate = DateFormat('dd-MM-yyyy').format(_user!.metadata.creationTime!);
          _accountSignInDate = DateFormat('dd-MM-yyyy').format(_user!.metadata.lastSignInTime!);
        } else {
          _userId = null;
          _accountCreationDate = null;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Account Info',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      "For the Imagine AI team, safeguarding your data and privacy is paramount. We adhere to strict policies to ensure that your personal information remains secure and confidential. Additionally, we are committed to transparency and accountability, providing clear explanations of how your data is collected, stored, and utilized within our platform. Your trust is invaluable to us, and we continuously strive to maintain the highest standards of data protection and ethical practices.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 17),
                    ),
                    const SizedBox(height: 10),
                    if (_user != null)
                      ListTile(
                        title: Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Account Created Using: ',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: '$_userId',
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (_accountCreationDate != null)
                      ListTile(
                        title: Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Account Created on: ',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: '$_accountCreationDate',
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (_accountSignInDate != null)
                      ListTile(
                        title: Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Last Signed in on: ',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: '$_accountSignInDate',
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),

              ),
            ],
          ),
        ),
      ),
    );
  }
}
