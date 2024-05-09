// import 'package:flutter/material.dart';
// import 'package:imagineai/Ui/app_screens/pages/home/AitoolBoxPage.dart';
// import 'package:imagineai/Ui/themeStyle.dart';
// import 'pages/home/homePage.dart';
// import 'pages/home/profilePage.dart';
//
// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);
//
//   @override
//   _HomeState createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   int _selectedIndex = 0;
//   bool _isDarkMode = false;
//
//   final List<Widget> _pages = [
//     HomePage(),
//     AIToolboxPage(),
//     ProfilePage(),
//   ];
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: _isDarkMode ? darkTheme : lightTheme,
//       child: Scaffold(
//         body: IndexedStack(
//           index: _selectedIndex,
//           children: _pages,
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//           items: const [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home_rounded, size: 28),
//               label: '',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.grid_view_rounded, size: 28),
//               label: '',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.person, size: 28),
//               label: '',
//             ),
//           ],
//           currentIndex: _selectedIndex,
//           selectedItemColor: customPurple,
//           onTap: _onItemTapped,
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: (){
//         setState(() {
//         _isDarkMode = !_isDarkMode;
//         });},
//           child: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:imagineai/Ui/app_screens/pages/home/AitoolBoxPage.dart';
import 'package:imagineai/Ui/theme/themeProvider.dart'; // Import the theme provider
import 'package:imagineai/Ui/theme/themeStyle.dart';
import 'pages/home/homePage.dart';
import 'pages/home/profilePage.dart';
import 'package:provider/provider.dart'; // Import provider package

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    AIToolboxPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return Scaffold(
          body: IndexedStack(
            index: _selectedIndex,
            children: _pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded, size: 28),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.grid_view_rounded, size: 28),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person, size: 28),
                label: '',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: customPurple,
            onTap: _onItemTapped,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              themeProvider.toggleTheme(); // Toggle the theme mode
            },
            child: Icon(themeProvider.themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode),
          ),
        );
      },
    );
  }
}
