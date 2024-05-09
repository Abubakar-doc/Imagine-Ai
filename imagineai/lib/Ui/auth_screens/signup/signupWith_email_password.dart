import 'package:flutter/material.dart';
import 'package:imagineai/Ui/auth_screens/signup/signupWith_phoneNumber.dart';
import '../../../firebaseServices/auth_service.dart';
import '../../../utils/utils.dart';
import '../../theme/themeStyle.dart';
import '../../widgets/loadingContainer.dart';
import '../signin/signinWith_email_password.dart';

class SignupScreenWith_email_password extends StatefulWidget {
  const SignupScreenWith_email_password({Key? key}) : super(key: key);

  @override
  _SignupScreenWith_email_passwordState createState() =>
      _SignupScreenWith_email_passwordState();
}

class _SignupScreenWith_email_passwordState
    extends State<SignupScreenWith_email_password> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthService authService = AuthService();
  bool loading = false;
  bool _isObscure = true;
  bool isChecked = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void signup() async{
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      await AuthService.signup(
        context,
        emailController.text,
        passwordController.text,
      ).then((value) {
        setState(() {
          loading = false;
        });
      }).onError((error, stackTrace) {
        setState(() {
          loading = false;
        });
        Utils().toastmsg(error.toString(), context);
      });
    }
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
                'Hello there',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              Text(
                '👋 ',
                style: TextStyle(fontSize: 25),
              ),
            ],
          ),
        ),
        body: Stack(
          children: [Container(
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Sign Up',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Please enter your email & password to create an account',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 17),
                    ),
                    const SizedBox(height: 10),
                    const SizedBox(
                        height: 30), // Add space between title and input fields
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
                                    color: Colors
                                        .grey), // Customize the color as needed
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        customPurple), // Customize the color as needed
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
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: passwordController,
                            obscureText: _isObscure,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors
                                        .grey), // Customize the color as needed
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        customPurple), // Customize the color as needed
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isObscure
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'Enter password';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis
                                .horizontal, // Allow horizontal scrolling if needed
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Checkbox(
                                  value: isChecked,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isChecked = value ?? false;
                                    });
                                  },
                                  activeColor: customPurple,
                                ),
                                const Text(
                                  "I agree to Imagine Ai ",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // Handle onTap
                                  },
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: const TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "Terms & Privacy Policy",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: customPurple,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Divider(
                      color: Colors.grey.shade200,
                      thickness: 2,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account? ",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black, // Adjust color as needed
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Utils().pushReplaceSlideTransition(context, const SigninScreenWith_email_password());
                          },
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: "Sign in",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: customPurple, // Adjust color as needed
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
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
                          onPressed: () async {
                            Navigator.pop(context);
                          setState(() {
                            loading = true;
                          });
                          await AuthService.signinWithGoogle(context);
                          setState(() {
                            loading = false;
                          });
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
                          onPressed: () async{
                            await AuthService.signinwithFacebook(context);
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
                            Utils().pushReplaceSlideTransition(context, const SigninScreenWith_PhoneNumber());
                          },
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Icon(
                            Icons.phone,
                            size: 25,
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    ElevatedButton(
                      onPressed: isChecked
                          ? signup
                          : null, // Disable button if checkbox is not checked
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: customPurple,
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
                              'Sign Up',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
            if (loading)
              const loadingcontainer(),]
        ),
      ),
    );
  }
}
