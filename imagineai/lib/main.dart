import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:imagineai/Ui/theme/themeProvider.dart';
import 'package:imagineai/Ui/theme/themeStyle.dart';
import 'package:imagineai/firebaseServices/image_sevice.dart';
import 'package:imagineai/firebase_options.dart';
import 'package:provider/provider.dart';
import 'Ui/app_screens/splash/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<ThemeMode>? _savedThemeFuture;
  final ImageQueryService _imageQueryService = ImageQueryService();

  @override
  void initState() {
    super.initState();
    _savedThemeFuture = _initializeApp();
    _savedThemeFuture?.then((_) => _imageQueryService.precacheImages(context));
  }

  Future<ThemeMode> _initializeApp() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedTheme = prefs.getString('theme');
    if (savedTheme == 'light') {
      return ThemeMode.light;
    } else if (savedTheme == 'dark') {
      return ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ThemeMode>(
      future: _savedThemeFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(child: CircularProgressIndicator(color:customPurple)),
            ),
          );
        } else if (snapshot.hasError) {
          // Handle error case
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: Text('Error initializing app')),
            ),
          );
        } else {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_) => ThemeProvider(themeMode: snapshot.data ?? ThemeMode.system),
              ),
            ],
            child: Consumer<ThemeProvider>(
              builder: (context, themeProvider, _) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  themeMode: themeProvider.themeMode,
                  theme: ThemeData.light(),
                  darkTheme: ThemeData.dark(),
                  home: const SplashScreen(),
                );
              },
            ),
          );
        }
      },
    );
  }
}
