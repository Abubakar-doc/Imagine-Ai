import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:imagineai/Ui/theme/themeStyle.dart';
import 'package:imagineai/Ui/widgets/loadingContainer.dart';
import 'package:imagineai/utils/utils.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path_provider/path_provider.dart';
import '../home/home.dart';
import 'dart:io';
import 'package:image/image.dart' as img;

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({Key? key}) : super(key: key);

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  bool loading = false;
  String? selectedGender;
  List<String> genders = ['Male', 'Female', 'Other'];
  File? _avatarImage;
  String? imageUrl;

  Future<void> _pickAvatarImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _avatarImage = File(pickedFile.path);
      }
    });
  }

  Future<File> compressImage(File imageFile) async {
    try {
      // Read the image file
      List<int> imageData = await imageFile.readAsBytes();
      img.Image? image = img.decodeImage(Uint8List.fromList(imageData));

      // Resize the image
      img.Image resizedImage = img.copyResize(image!, width: 200);

      // Convert the resized image to bytes with JPEG format
      List<int> compressedImageData = img.encodeJpg(resizedImage, quality: 30);

      // Create a new File from the compressed image data
      File compressedImageFile = File('${(await getTemporaryDirectory()).path}/compressed_image.jpg');
      await compressedImageFile.writeAsBytes(compressedImageData);

      return compressedImageFile;
    } catch (e) {
      // print('Error while compressing image: $e');
      Utils().toastmsg('Error while compressing image: $e', context);
      return imageFile; // Return the original image file in case of error
    }
  }

  Future<String?> _uploadImageToFirebase() async {
    if (_avatarImage == null) {
      return null; // Return null if _avatarImage is null
    }

    try {
      final firebase_storage.Reference ref = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('profilepics')
          .child(DateTime.now().millisecondsSinceEpoch.toString() + '.jpg');
      await ref.putFile(_avatarImage!);
      final url = await ref.getDownloadURL();
      return url;
    } catch (error) {
      Utils().toastmsg(
          "Error uploading file to Firebase Storage: $error", context);
      return null;
    }
  }

  Future<void> _saveDataToFirestore(String imageUrl, String userId) async {
    try {
      await FirebaseFirestore.instance.collection('UserData').add({
        'UserId': userId,
        'Name': fullnameController.text.trim(),
        'DateOfBirth': dateController.text.trim(),
        'Gender': selectedGender ?? '',
        'IsOldUser': true,
        'ProfilePicture': imageUrl,
      });
      Utils().greytoastmsg("Welcome, your profile is created successfully", context);
    } catch (error) {
      Utils().toastmsg("Error saving data to Firestore: $error", context);
      throw error;
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });

      try {
        imageUrl = await _uploadImageToFirebase();

        // Fetching the user ID from Firebase Authentication
        User? user = FirebaseAuth.instance.currentUser;

        if (user != null) {
          String userId;

          // Check if the user has an email
          if (user.email != null) {
            // Use the user's email as part of the user ID
            userId = user.email!;
          } else if (user.phoneNumber != null) {
            // Use the user's phone number as part of the user ID
            userId = user.phoneNumber!;
          } else {
            userId = user.uid; // Fall back to using the UID
          }

          await _saveDataToFirestore(imageUrl ?? '', userId); // Pass empty string if imageUrl is null
          setState(() {
            loading = false;
          });
        } else {
          Utils().toastmsg("Please Sign in first", context);
        }

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
      } catch (error) {
        Utils().toastmsg("Error occurred while submitting form: $error", context);
        _showErrorDialog("Error occurred while submitting form. Please try again.");
        setState(() {
          loading = false;
        });
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  @override
  void dispose() {
    fullnameController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: lightTheme, // Use the light theme explicitly
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Enter Personal info',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "Please enter your profile. Don't worry, only you can see your personal data. No one else will be able to see it. Or you can skip it for now.",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 17),
                    ),
                    const SizedBox(height: 10),
                    const SizedBox(height: 30),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: _pickAvatarImage,
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  radius: 60,
                                  backgroundColor: Colors.grey[300],
                                  backgroundImage: _avatarImage != null
                                      ? FileImage(_avatarImage!)
                                      : null, // Use selected image if available
                                  child: _avatarImage == null
                                      ? const Icon(
                                    Icons.person,
                                    size: 100,
                                    color: Colors.grey,
                                  )
                                      : null,
                                ),
                                const Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: CircleAvatar(
                                    radius: 20, // Size of the pencil icon
                                    backgroundColor: customPurple, // Color of the circle background
                                    child: Icon(
                                      Icons.edit, // Pencil icon
                                      size: 16, // Size of the pencil icon
                                      color: Colors
                                          .white, // Color of the pencil icon
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          TextFormField(
                            controller: fullnameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name at least!';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              labelText: 'Full Name',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: customPurple),
                              ),
                            ),
                          ),
                          const SizedBox(
                              height: 20), // Add some space between form fields
                          TextFormField(
                            controller: dateController,
                            onChanged: (value) {
                              setState(() {});
                            },
                            readOnly:
                            true, // Make it read-only to prevent manual input
                            decoration: InputDecoration(
                              labelText: 'Date of Birth',
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.calendar_today),
                                onPressed: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime.now(),
                                  ).then((selectedDate) {
                                    if (selectedDate != null) {
                                      setState(() {
                                        dateController.text =
                                            DateFormat('dd-MM-yyyy')
                                                .format(selectedDate!);
                                      });
                                    }
                                  });
                                },
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: customPurple),
                              ),
                            ),
                          ),
                          const SizedBox(
                              height: 20), // Add some space between form fields
                          DropdownButtonFormField<String>(
                            value: selectedGender,
                            onChanged: (newValue) {
                              setState(() {
                                selectedGender = newValue;
                              });
                            },
                            items: genders
                                .map<DropdownMenuItem<String>>((String gender) {
                              return DropdownMenuItem<String>(
                                value: gender,
                                child: Text(gender),
                              );
                            }).toList(),
                            decoration: const InputDecoration(
                              labelText: 'Gender',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: customPurple),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 80),
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: customPurple,
                        ),
                        child: const Text(
                          'Next',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ), if (loading)
              const LoadingContainer(
                message: 'Please bear with us !!!',
              )
            ,
          ],
        ),
      ),
    );
  }
}
