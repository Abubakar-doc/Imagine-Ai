import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AiToolboxPage extends StatelessWidget {
  const AiToolboxPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI Toolbox'),
      ),
      body: Center(
        child: Text('AI Toolbox Page'),
      ),
    );
  }
}

