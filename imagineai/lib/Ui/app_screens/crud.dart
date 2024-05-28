import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:imagineai/Ui/app_screens/intro/intro.dart';
import 'package:imagineai/Ui/app_screens/profile/personal_info.dart';
import '../../utils/utils.dart';

class crud extends StatefulWidget {
  crud({super.key});

  @override
  State<crud> createState() => _crudState();
}

class _crudState extends State<crud> {
  final auth = FirebaseAuth.instance;
  bool loading = false;
  final databaseref = FirebaseDatabase.instance.ref('Post');
  final postController = TextEditingController();

  Future<void> deleteAllUserData() async {
    CollectionReference userDataRef = FirebaseFirestore.instance.collection('UserData');

    try {
      QuerySnapshot snapshot = await userDataRef.get();
      for (QueryDocumentSnapshot doc in snapshot.docs) {
        await doc.reference.delete();
      }
      Utils().toastmsg('All documents deleted successfully', context);
    } catch (error) {
      Utils().toastmsg('Error deleting documents: $error', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CRUD'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
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
            },
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 300,
              margin: const EdgeInsets.all(10),
              child: TextField(
                maxLines: 2,
                controller: postController,
                decoration: const InputDecoration(
                  hintText: 'Enter text here',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Utils().pushSlideTransition(context, const PersonalInfo());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text(
                    'userdata',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Update operation
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      loading = true;
                    });
                    deleteAllUserData().then((_) {
                      setState(() {
                        loading = false;
                      });
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text(
                    'Delete',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Read operation
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  child: const Text(
                    'Read',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
