import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imagineai/utils/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;

class ModelQueryService {
  final String apiUrl =
      'https://api-inference.huggingface.co/models/stabilityai/stable-diffusion-xl-base-1.0';
  final String apiToken = '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';

  Future<Uint8List?> queryModel(Map<String, dynamic> payload) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $apiToken',
          'Content-Type': 'application/json',
        },
        body: json.encode(payload),
      );

      if (response.statusCode == 200) {
        // Check if the content type indicates binary data (image)
        if (response.headers['content-type']?.contains('image/jpeg') == true ||
            response.headers['content-type']?.contains('image/png') == true) {
          return response.bodyBytes;
        } else {
          print(
              'Unexpected response format: ${response.headers["content-type"]}');
          print('Response Body: ${response.body}');
        }
      } else {
        print('HTTP Error: ${response.statusCode}');
        print('Response Body: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
    throw Exception('Failed to query model');
  }
}

class ImageQueryService {
  Future<void> downloadImage(
      {required BuildContext context,
      required List<Uint8List?> selectedImageData}) async {
    for (var imageData in selectedImageData) {
      if (imageData != null) {
        await _saveLocalImage(imageData);
      }
    }
  }

  Future<void> _saveLocalImage(Uint8List imageData) async {
    final result = await ImageGallerySaver.saveImage(
      imageData,
      quality: 100,
      name: "Imagine_Ai_generation_${DateTime.now().millisecondsSinceEpoch}",
    );
  }

  Future<void> precacheImages(BuildContext context) async {
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
      await precacheImage(AssetImage(imagePath), context);
    }
  }

  Future<void> fetchUserData(
      BuildContext context,
      void Function(String, String, String, String, bool)
          updateStateCallback) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String userId;

      if (user.email != null) {
        userId = user.email!;
      } else if (user.phoneNumber != null) {
        userId = user.phoneNumber!;
      } else {
        userId = user.uid;
      }

      QuerySnapshot userDataSnapshot = await FirebaseFirestore.instance
          .collection('UserData')
          .where('UserId', isEqualTo: userId)
          .get();

      if (userDataSnapshot.docs.isNotEmpty) {
        DocumentSnapshot userData = userDataSnapshot.docs.first;
        String userName = userData['Name'] ?? 'Your Name';
        String profilePictureUrl = userData['ProfilePicture'] ?? '';
        String dateOfBirth =
            userData['DateOfBirth'] ?? ''; // Fetch DateOfBirth from Firestore
        String gender = userData['Gender'] ?? ''; // Fetch Gender from Firestore
        updateStateCallback(
            userName, profilePictureUrl, dateOfBirth, gender, false);
      } else {
        updateStateCallback('Username', '', '', '', false);
      }
    } else {
      Utils().toastmsg("Please Sign in first", context);
      updateStateCallback('', '', '', '', false);
    }
  }


  Future<File?> pickImage(BuildContext context) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        return File(pickedFile.path);
      } else {
        return null;
      }
    } catch (e) {
      Utils().toastmsg("Error picking image: $e", context);
      return null;
    }
  }

  Future<File> compressImage(File imageFile, BuildContext context) async {
    try {
      List<int> imageData = await imageFile.readAsBytes();
      img.Image? image = img.decodeImage(Uint8List.fromList(imageData));
      img.Image resizedImage = img.copyResize(image!, width: 200);
      List<int> compressedImageData = img.encodeJpg(resizedImage, quality: 30);
      File compressedImageFile =
      File('${(await getTemporaryDirectory()).path}/compressed_image.jpg');
      await compressedImageFile.writeAsBytes(compressedImageData);

      return compressedImageFile;
    } catch (e) {
      Utils().toastmsg('Error while compressing image: $e', context);
      return imageFile;
    }
  }

}
