import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:imagineai/utils/utils.dart';

class UserQueryService {
  final BuildContext context;

  UserQueryService({required this.context});

  Future<void> updateDataToFirestore({
    required String userId,
    required String fullName,
    required String dateOfBirth,
    required String gender,
    required String profilePictureUrl,
  }) async {
    try {
      // Reference to the collection
      CollectionReference userCollection =
      FirebaseFirestore.instance.collection('UserData');

      // Query the collection to find a document with the matching UserId field
      QuerySnapshot querySnapshot =
      await userCollection.where('UserId', isEqualTo: userId).get();

      // Get the first document that matches the query
      DocumentReference userDoc = querySnapshot.docs.first.reference;

      // Update the document with new data
      await userDoc.update({
        'Name': fullName.trim(),
        'DateOfBirth': dateOfBirth.trim(),
        'Gender': gender,
        'ProfilePicture': profilePictureUrl,
      });

      // Notify user of successful update
      Utils()
          .greytoastmsg("Your profile has been updated successfully", context);
    } catch (error) {
      Utils().toastmsg("Error updating data in Firestore: $error", context);
      rethrow;
    }
  }
}
