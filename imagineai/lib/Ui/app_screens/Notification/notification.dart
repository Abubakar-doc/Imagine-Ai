import 'package:flutter/material.dart';

class notification extends StatefulWidget {
  notification({super.key});

  @override
  State<notification> createState() => _notificationState();
}

class _notificationState extends State<notification> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
        'Notifications',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      ),
      body: const Center(
       child: Text("No Notifications yet."
         ,style: TextStyle(
         fontSize: 18,
       ),),
      ),
    );
  }
}
