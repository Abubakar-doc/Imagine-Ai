import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imagineai/Ui/app_screens/home.dart';
import 'package:imagineai/utils/utils.dart';
import '../../theme/themeStyle.dart';
import '../../widgets/loadingContainer.dart';
import 'package:intl/intl.dart';


class personalInfo extends StatefulWidget {
  const personalInfo({super.key});

  @override
  State<personalInfo> createState() => _personalInfoState();
}

class _personalInfoState extends State<personalInfo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  bool loading = false;
  String? selectedGender;
  List<String> genders = ['Male', 'Female', 'Other'];
  bool isAnyFieldFilled = false; // Track whether any field is filled

  @override
  void dispose() {
    fullnameController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: lightTheme,
      child: Scaffold(
        appBar: AppBar(
          title: const Row(
            children: [
              Text(
                'Enter Personal info',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              Text(
                '📋',
                style: TextStyle(fontSize: 25),
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
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
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 60, // Adjust the size of the avatar as needed
                                  backgroundColor: Colors.grey[300], // Background color of the avatar
                                  child: const Center(
                                    child: Icon(
                                      Icons.person, // Default avatar icon
                                      size: 100, // Size of the icon
                                      color: Colors.grey, // Color of the icon
                                    ),
                                  ),
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
                                      color: Colors.white, // Color of the pencil icon
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TextFormField(
                              controller: fullnameController,
                              onChanged: (value) {
                                setState(() {
                                  isAnyFieldFilled = value.isNotEmpty ||
                                      dateController.text.isNotEmpty ||
                                      selectedGender != null;
                                });
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
                            const SizedBox(height: 20), // Add some space between form fields
                            TextFormField(
                              controller: dateController,
                              onChanged: (value) {
                                setState(() {
                                  isAnyFieldFilled = value.isNotEmpty ||
                                      fullnameController.text.isNotEmpty ||
                                      selectedGender != null;
                                });
                              },
                              readOnly: true, // Make it read-only to prevent manual input
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
                                              DateFormat('yyyy-MM-dd').format(selectedDate);
                                          isAnyFieldFilled = true;
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
                            const SizedBox(height: 20), // Add some space between form fields
                            DropdownButtonFormField<String>(
                              value: selectedGender,
                              onChanged: (newValue) {
                                setState(() {
                                  selectedGender = newValue;
                                  isAnyFieldFilled = newValue != null ||
                                      fullnameController.text.isNotEmpty ||
                                      dateController.text.isNotEmpty;
                                });
                              },
                              items: genders.map<DropdownMenuItem<String>>((String gender) {
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 55,
                            child: ElevatedButton(
                              onPressed: () {
                                Utils().pushReplaceSlideTransition(context, const Home());
                              },
                              child: const Text(
                                'Skip',
                                style: TextStyle(
                                  color: customPurple,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 55,
                            child: ElevatedButton(
                              onPressed: isAnyFieldFilled
                                  ? () {
                                Utils().pushReplaceSlideTransition(context,  Home());
                              }
                                  : null,
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
                    ],
                  ),
                ),
              ),
            ),
            if (loading) const loadingcontainer(),
          ],
        ),
      ),
    );
  }
}
