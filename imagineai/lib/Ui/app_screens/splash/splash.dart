import 'package:flutter/material.dart';
import 'package:imagineai/firebaseServices/SplashServices.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashscreen = SplashServices();

  @override
  void initState() {
    super.initState();
    splashscreen.isSignedIn(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFF5C3DF6),
              Color(0xFF30ABF3),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: Image.asset('assets/Imagine Ai transparent logo.png'),
              ),
              const SizedBox(
                width: double.infinity, // Take full width
                child: Text(
                  'Imagine Ai',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center, // Center align the text
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
