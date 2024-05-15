import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:imagineai/Ui/theme/themeProvider.dart';
import 'package:imagineai/firebase_options.dart';
import 'package:provider/provider.dart';
import 'Ui/app_screens/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: themeProvider.themeMode,
            theme: ThemeData.light(), // Provide your light theme here
            darkTheme: ThemeData.dark(), // Provide your dark theme here
            home: const SplashScreen(),
          );
        },
      ),
    );
  }

  void precacheImages(BuildContext context) {
    const imagePaths = [
      'assets/Imagine Ai logo.png',
      'assets/Imagine Ai logo 2.png',
      'assets/Imagine Ai transparent logo.png',
      'assets/Imagine Ai purple transparent logo.png',
      'assets/material/Introscreens/intro1.png',
      'assets/material/Introscreens/intro2.png',
      'assets/material/Introscreens/intro3.png',
      'assets/Imagine Ai logo round.png',
      'assets/material/thirdPartyIcons/googleIcon.png',
      'assets/material/cards place holders/cyberpunk.jpeg',
      'assets/material/cards place holders/colorful.jpeg',
      'assets/material/cards place holders/robot.jpeg',
      'assets/material/cards place holders/realistic.jpeg',
      'assets/material/cards place holders/artistic.jpeg',
    ];

    for (final imagePath in imagePaths) {
      precacheImage(AssetImage(imagePath), context);
    }
  }
}
