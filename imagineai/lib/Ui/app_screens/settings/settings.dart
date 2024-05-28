import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:imagineai/Ui/app_screens/intro/intro.dart';
import 'package:imagineai/Ui/app_screens/settings/account_info.dart';
import 'package:imagineai/Ui/theme/themeProvider.dart';
import 'package:imagineai/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../theme/themeStyle.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class settings extends StatefulWidget {
  const settings({super.key});

  @override
  State<settings> createState() => _settingsState();
}

class _settingsState extends State<settings> {
  late String _selectedTheme;
  late SharedPreferences _prefs;
  final auth = FirebaseAuth.instance;
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    _loadSelectedTheme();
  }

  Future<void> _loadSelectedTheme() async {
    _prefs = await SharedPreferences.getInstance();
    final savedTheme = _prefs.getString('theme');
    setState(() {
      _selectedTheme = savedTheme ?? 'System';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
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
            mainAxisAlignment: MainAxisAlignment
                .spaceBetween, // Align children with space between them
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Text(
                          'App Settings',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                            width:
                                10), // Add some spacing between the text and the divider
                        Flexible(
                          child: Divider(
                            color: Colors.grey.shade200,
                            thickness: 2,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(
                              Icons.color_lens_outlined,
                              size: 25,
                              color: customPurple,
                            ),
                            SizedBox(
                              width: 28,
                            ),
                            Text(
                              'Select theme',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        DropdownButton<String>(
                          value: _selectedTheme,
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: customPurple,
                            size: 30,
                          ),
                          style: const TextStyle(
                              color: customPurple,
                              fontSize: 20), // Set text color and size
                          underline: Container(), // Remove underline
                          onChanged: (String? newValue) async {
                            if (newValue != null) {
                              setState(() {
                                _selectedTheme = newValue;
                              });
                              final themeProvider = Provider.of<ThemeProvider>(
                                  context,
                                  listen: false);
                              if (newValue == 'light') {
                                themeProvider.setTheme(ThemeMode.light);
                              } else if (newValue == 'dark') {
                                themeProvider.setTheme(ThemeMode.dark);
                              } else {
                                themeProvider.setTheme(ThemeMode.system);
                              }
                              await _prefs.setString('theme', newValue);
                            }
                          },
                          items: const [
                            DropdownMenuItem(
                              value: 'System',
                              child: Text('System',
                                  style: TextStyle(
                                      color:
                                          customPurple)), // Set color for selected item
                            ),
                            DropdownMenuItem(
                              value: 'light',
                              child: Text('Light',
                                  style: TextStyle(
                                      color:
                                          customPurple)), // Set color for selected item
                            ),
                            DropdownMenuItem(
                              value: 'dark',
                              child: Text('Dark',
                                  style: TextStyle(
                                      color:
                                          customPurple)), // Set color for selected item
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.people_alt,
                              size: 25,
                              color: customPurple,
                            ),
                            SizedBox(
                              width: 28,
                            ),
                            Text(
                              'About Imagine Ai',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Icon(Icons.arrow_forward_ios_outlined)
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Account Settings',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                            width:
                                10), // Add some spacing between the text and the divider
                        Flexible(
                          child: Divider(
                            color: Colors.grey.shade200,
                            thickness: 2,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Utils()
                            .pushSlideTransition(context, const AccountInfo());
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.person,
                                size: 25,
                                color: customPurple,
                              ),
                              SizedBox(
                                width: 28,
                              ),
                              Text(
                                'Account Info',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Icon(Icons.arrow_forward_ios_outlined)
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        _DeleteAccountConfirmationPopup(context);
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.lock,
                                size: 25,
                                color: customPurple,
                              ),
                              SizedBox(
                                width: 28,
                              ),
                              Text(
                                'Delete Account',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Icon(Icons.arrow_forward_ios_outlined)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: ElevatedButton(
                  onPressed: () {
                    _logOutConfirmationPopup(context);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.grey.shade500,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    minimumSize: const Size(
                        double.infinity, 0), // Set button width to match parent
                  ),
                  child: const Text(
                    'Log Out',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _logOutConfirmationPopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Center(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min, // Added to minimize height
                children: [
                  const Text(
                    'Logout',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Divider(
                    color: Colors.grey.shade400,
                    thickness: 1,
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    'Are you sure you want to log out?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 70,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 0),
                            ),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                color:
                                    customPurple, // Assuming customPurple is Colors.purple
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 70,
                          child: ElevatedButton(
                            onPressed: () {
                              auth.signOut().then((value) {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => IntroScreen(),
                                  ),
                                  (route) => false,
                                );
                              }).onError((error, stackTrace) {
                                Utils().toastmsg(error.toString(), context);
                              });
                              final themeProvider = Provider.of<ThemeProvider>(
                                  context,
                                  listen: false);
                              themeProvider.setTheme(ThemeMode.light);
                              _prefs.setString('theme', 'light');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  customPurple, // Assuming customPurple is Colors.purple
                              minimumSize: const Size(double.infinity, 0),
                            ),
                            child: const Center(
                              child: Text(
                                'Yes, Logout',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _DeleteAccountConfirmationPopup(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Center(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min, // Added to minimize height
                children: [
                  const Text(
                    'Request Account Deletion',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Divider(
                    color: Colors.grey.shade400,
                    thickness: 1,
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    'Are you sure you want to request account deletion?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 70,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: customPurple,
                              minimumSize: const Size(double.infinity, 0),
                            ),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 70,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Utils().greytoastmsg('Your request for account deletion is registered and will be served soon.', context);
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 0),
                            ),
                            child: const Center(
                              child: Text(
                                'Send Request',
                                style: TextStyle(
                                  color: customPurple,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        );
      },
    );
  }


}
