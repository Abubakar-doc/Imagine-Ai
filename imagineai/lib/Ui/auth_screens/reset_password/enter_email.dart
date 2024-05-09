import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:imagineai/firebaseServices/auth_service.dart';
import 'package:imagineai/utils/utils.dart';
import '../../theme/themeStyle.dart';
import '../../widgets/loadingContainer.dart';

class emailTo_reset_password extends StatefulWidget {
  const emailTo_reset_password({Key? key}) : super(key: key);

  @override
  State<emailTo_reset_password> createState() => _emailTo_reset_passwordState();
}

class _emailTo_reset_passwordState extends State<emailTo_reset_password> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool loading = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Text(
                'Reset your Password ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              Text(
                '🔑',
                style: TextStyle(fontSize: 25),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Container(
              height: MediaQuery.of(context).size.height,
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "Kindly provide your email address, and we'll send you a reset link to your email address to reset password.",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 17),
                    ),
                    const SizedBox(height: 30),
                    Expanded(
                      child: Column(
                        children: [
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: emailController,
                                  decoration: const InputDecoration(
                                    labelText: 'Email',
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                          Colors.grey), // Customize the color as needed
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: customPurple), // Customize the color as needed
                                    ),
                                    suffixIcon: Icon(Icons.alternate_email),
                                  ),
                                  validator: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return 'Enter Email';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async{
                        if (_formKey.currentState!.validate()) {
                          try {
                            setState(() {
                              loading = true;
                            });
                            await AuthService.passwordResetEmail(context, emailController.text.toString().trim()).then((value){
                              setState(() {
                                loading = false;
                              });
                            }).onError((error, stackTrace) {
                              setState(() {
                                loading = false;
                              });
                              Utils().toastmsg(error.toString(), context);
                            });
                          } catch (error) {
                            Utils().toastmsg(error.toString(), context);
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: customPurple,
                        padding:
                        const EdgeInsets.symmetric(vertical: 15),
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
                        'Continue',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
          ),
          if (loading) const loadingcontainer(),
        ],
      ),
    );
  }
}
