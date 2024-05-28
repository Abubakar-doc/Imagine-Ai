import 'package:flutter/material.dart';

class AIToolboxPage extends StatefulWidget {
  @override
  State<AIToolboxPage> createState() => _AIToolboxPageState();
}

class _AIToolboxPageState extends State<AIToolboxPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const SizedBox(height: 20,),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                  child: Image.asset(
                    'assets/material/cards place holders/expansion.jpg',
                    fit: BoxFit.cover,
                    height: 150,
                    width: double.infinity,
                  ),
                ),
                const ListTile(
                  title: Text(
                    'AI Image Expansion',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    'Coming Soon',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                  child: Image.asset(
                    'assets/material/cards place holders/moretools.jpg',
                    fit: BoxFit.cover,
                    height: 150,
                    width: double.infinity,
                  ),
                ),
                const ListTile(
                  title: Text(
                    'More Ai Tools',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    'Coming Soon',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
