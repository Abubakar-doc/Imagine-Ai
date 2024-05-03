import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:imagineai/Ui/app_screens/crud.dart';
import '../../../firebaseServices/auth_service.dart';
import '../../../utils/utils.dart';
import '../../themeStyle.dart';

class PhoneNumberSigninCodeVerify extends StatefulWidget {
  final String verificationID;

  const PhoneNumberSigninCodeVerify({super.key, required this.verificationID});

  @override
  State<PhoneNumberSigninCodeVerify> createState() => _PhoneNumberSigninCodeVerifyState();
}

class _PhoneNumberSigninCodeVerifyState extends State<PhoneNumberSigninCodeVerify> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController otpController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool loading = false;
  final AuthService _authService = AuthService();

  Future<void> otpVerification(BuildContext context) async {
    setState(() {
      loading = true;
    });
    await AuthService.otpVerification(
        context, widget.verificationID, otpController.text);
    setState(() {
      loading = false;
    });
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Verify',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Enter OTP',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Please enter 6 digit OTP sent to you!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17),
              ),
              const SizedBox(height: 30),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: otpController,
                      maxLength: 6,
                      decoration: const InputDecoration(
                        labelText: 'OTP Code',
                        hintText: 'Enter 6-digit OTP',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: customPurple),
                        ),
                        prefixIcon: Icon(Icons.lock),
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter the OTP code';
                        }
                        if (value!.length != 6) {
                          return 'OTP code must be 6 digits long';
                        }
                        // Additional validation can be added here if needed
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "To update your phone number, ",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black, // Adjust color as needed
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        loading = false;
                      });
                      Navigator.pop(context);
                    },
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: "click here",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF5C3DF6), // Adjust color as needed
                            ),
                          ),
                          TextSpan(
                            text: ".", // Period to end the sentence
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black, // Adjust color as needed
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.grey.shade200,
                      thickness: 2,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "or continue with",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black, // Adjust color as needed
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.grey.shade200,
                      thickness: 2,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      // Handle button press
                    },
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Image.asset(
                      'assets/material/thirdPartyIcons/googleIcon.png', // Replace with your image path
                      width: 35,
                      height: 35,
                    ),
                  ),
                  const SizedBox(width: 16),
                  OutlinedButton(
                    onPressed: () {
                      // Handle button press
                    },
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Image.asset(
                      'assets/material/thirdPartyIcons/facebookIcon.png', // Replace with your image path
                      width: 25,
                      height: 25,
                    ),
                  ),
                  const SizedBox(width: 16),
                  OutlinedButton(
                    onPressed: () {
                      // Handle button press
                    },
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Icon(
                      Icons.mail_outline,
                      size: 25,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 70,
              ),
              ElevatedButton(
                onPressed: ()async {
                  await otpVerification(context);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: customPurple, // Button background color
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: loading
                    ? const SizedBox(
                  width: 26,
                  height: 26,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: Colors.white,
                  ),
                )
                    : const Text(
                  'Verify',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
