import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:imagineai/firebase_options.dart';
import 'Ui/app_screens/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    precacheImages(context);
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }

  void precacheImages(BuildContext context) {
    const imagePaths = [
      'assets/Imagine Ai logo.png',
      'assets/Imagine Ai logo 2.png',
      'assets/Imagine Ai transparent logo.png',
      'assets/material/Introscreens/intro1.png',
      'assets/material/Introscreens/intro2.png',
      'assets/material/Introscreens/intro3.png',
      'assets/Imagine Ai logo round.png',
      'assets/material/thirdPartyIcons/googleIcon.png',
      'assets/material/thirdPartyIcons/facebookIcon.png',
    ];

    for (final imagePath in imagePaths) {
      precacheImage(AssetImage(imagePath), context);
    }
  }
}
