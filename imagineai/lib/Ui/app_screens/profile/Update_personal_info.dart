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
import 'dart:io';
import 'package:image/image.dart' as img;

class Update_PersonalInfo extends StatefulWidget {
  final String userName;
  final String profilePictureUrl;
  final String dateOfBirth;
  final String gender;

  Update_PersonalInfo({
    Key? key,
    required this.userName,
    required this.profilePictureUrl,
    required this.dateOfBirth,
    required this.gender,
  }) : super(key: key);

  @override
  State<Update_PersonalInfo> createState() => _Update_PersonalInfoState();
}

class _Update_PersonalInfoState extends State<Update_PersonalInfo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  bool loading = false;
  String? selectedGender;
  List<String> genders = ['Male', 'Female', 'Other'];
  File? _avatarImage;
  String? imageUrl;
  String? avatarimageUrl;
  bool isDataChanged = false;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();

    // Initialize the form fields with data from widget
    fullnameController.text = widget.userName;
    dateController.text = widget.dateOfBirth;

    // Set selectedGender only if it's in the genders list, otherwise set it to null
    selectedGender = genders.contains(widget.gender) ? widget.gender : null;
    imageUrl = widget.profilePictureUrl;
    avatarimageUrl = widget.profilePictureUrl;
  }

  @override
  void dispose() {
    fullnameController.dispose();
    dateController.dispose();
    super.dispose();
  }

  Future<void> _pickAvatarImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _avatarImage = File(pickedFile.path);
        isDataChanged = true;
      }
    });
  }

  Future<File> compressImage(File imageFile) async {
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

  Future<void> _updateDataToFirestore(String userId) async {
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
        'Name': fullnameController.text.trim(),
        'DateOfBirth': dateController.text.trim(),
        'Gender': selectedGender ?? widget.gender,
        'ProfilePicture': imageUrl, // Use the updated imageUrl
      });

      // Notify user of successful update
      Utils()
          .greytoastmsg("Your profile has been updated successfully", context);
    } catch (error) {
      Utils().toastmsg("Error updating data in Firestore: $error", context);
      rethrow;
    }
  }

  Future<String?> _uploadImageToFirebase() async {
    try {
      // Check if _avatarImage and avatarimageUrl both are null means user removed profile image
      if (avatarimageUrl == null && _avatarImage == null) {
        await firebase_storage.FirebaseStorage.instance
            .refFromURL(imageUrl!)
            .delete();
      }

      // Check if _avatarImage is null
      if (_avatarImage == null) {
        // If _avatarImage is null and avatarimageUrl is not null, delete the old image
        if (avatarimageUrl != null && avatarimageUrl!.isNotEmpty) {
          await firebase_storage.FirebaseStorage.instance
              .refFromURL(avatarimageUrl!)
              .delete();
        }
        return null; // Return null because the user removed the image
      } else {
        // Delete existing image only if avatarimageUrl is not null and not empty
        if (avatarimageUrl != null && avatarimageUrl!.isNotEmpty) {
          await firebase_storage.FirebaseStorage.instance
              .refFromURL(avatarimageUrl!)
              .delete();
        }

        final firebase_storage.Reference ref = firebase_storage
            .FirebaseStorage.instance
            .ref()
            .child('profilepics')
            .child('${DateTime.now().millisecondsSinceEpoch}.jpg');
        await ref.putFile(_avatarImage!);
        final url = await ref.getDownloadURL();
        return url;
      }
    } catch (error) {
      Utils().toastmsg(
          "Error uploading file to Firebase Storage: $error", context);
      return avatarimageUrl; // Return the existing URL in case of error
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });

      try {
        imageUrl = await _uploadImageToFirebase();

        User? user = FirebaseAuth.instance.currentUser;

        if (user != null) {
          // Determine user identifier based on email, phone number, or uid
          String userId;
          if (user.email != null) {
            userId = user.email!;
          } else if (user.phoneNumber != null) {
            userId = user.phoneNumber!;
          } else {
            userId = user.uid;
          }

          await _updateDataToFirestore(userId);
          setState(() {
            loading = false;
          });
        } else {
          Utils().toastmsg("Please Sign in first", context);
          setState(() {
            loading = false;
          });
        }

        // Navigator.pop(context);
        Navigator.pop(context, true);
      } catch (error) {
        Utils()
            .toastmsg("Error occurred while submitting form: $error", context);
        setState(() {
          loading = false;
        });
      }
    }
  }

  void _removeProfileImage() {
    setState(() {
      _avatarImage = null;
      avatarimageUrl = null;
      isDataChanged = true;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Update Personal info',
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
                    "Don't worry, only you can see your personal data. No one else will be able to see it.",
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
                          onTap: (){
                            _editProfileImagePopup(context);
                          },
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.grey[300],
                                child: ClipOval(
                                  child: _avatarImage != null
                                      ? Image.file(
                                    _avatarImage!,
                                    fit: BoxFit.cover,
                                    width: 120,
                                    height: 120,
                                  )
                                      : avatarimageUrl != null
                                      ? Image.network(
                                    avatarimageUrl!,
                                    fit: BoxFit.cover,
                                    width: 120,
                                    height: 120,
                                    errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                      return const Icon(
                                        Icons.person,
                                        size: 100,
                                        color: Colors.grey,
                                      );
                                    },
                                  )
                                      : const Icon(
                                    Icons.person,
                                    size: 100,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              const Positioned(
                                bottom: 0,
                                right: 0,
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: customPurple,
                                  child: Icon(
                                    Icons.edit,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextFormField(
                          onChanged: (value){
                            setState(() {
                              isDataChanged = true;
                            });
                          },
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
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: dateController,
                          onChanged: (value) {
                            setState(() {
                            });
                          },
                          readOnly: true,
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
                                      isDataChanged = true;
                                      dateController.text =
                                          DateFormat('dd-MM-yyyy')
                                              .format(selectedDate);
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
                        const SizedBox(height: 20),
                        DropdownButtonFormField<String>(
                          value: selectedGender,
                          onChanged: (newValue) {
                            setState(() {
                              isDataChanged = true;
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
                    // child: ElevatedButton(
                    //   onPressed: _submitForm,
                    //   style: ElevatedButton.styleFrom(
                    //     backgroundColor: customPurple,
                    //   ),
                    //   child: const Text(
                    //     'Update Profile',
                    //     style: TextStyle(
                    //       color: Colors.white,
                    //       fontSize: 18,
                    //     ),
                    //   ),
                    // ),
                    child: ElevatedButton(
                      onPressed: isDataChanged ? _submitForm : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: customPurple,
                      ),
                      child: const Text(
                        'Update Profile',
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
          ),
          if (loading) const LoadingContainer(
            message: "Don't quite this screen, your profile is being updated !!!",
          ),
        ],
      ),
    );
  }
  void _editProfileImagePopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min, // Added to minimize height
                children: [
                  const Text(
                    'Profile Picture',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Divider(
                    color: Colors.grey.shade400,
                    thickness: 1,
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 70,
                          child: ElevatedButton(
                            onPressed: () {
                              _removeProfileImage();
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 0),
                            ),
                            child: const Text(
                              'Remove Picture',
                              style: TextStyle(
                                color: customPurple, // Assuming customPurple is Colors.purple
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 70,
                          child: ElevatedButton(
                            onPressed: () {
                              _pickAvatarImage();
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: customPurple, // Assuming customPurple is Colors.purple
                              minimumSize: const Size(double.infinity, 0),
                            ),
                            child: const Center(
                              child: Text(
                                'Change Picture',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}


