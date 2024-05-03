import 'package:flutter/material.dart';
import '../../../auth_screens/signin/signin_Parent.dart';
import '../../../widgets/index_for_pages.dart';
import 'package:imagineai/Ui/themeStyle.dart';

class IntroPage extends StatelessWidget {
  final VoidCallback onNextPressed;
  final int currentPage;
  final PageController pageController;
  final int millesecond;
  final String imagePath;
  final String headingText;
  final String subheadingText;

  const IntroPage({
    Key? key,
    required this.onNextPressed,
    required this.currentPage,
    required this.pageController,
    required this.millesecond,
    required this.imagePath,
    required this.headingText,
    required this.subheadingText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 60,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                Text(
                  headingText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  subheadingText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          indexForPages(
            currentPage: currentPage,
            onPageSelected: (int index) {
              pageController.animateToPage(
                index,
                duration: Duration(
                    milliseconds: millesecond), // Use the passed value here
                curve: Curves.easeInOut,
              );
            },
          ),
          const SizedBox(height: 10),
          Divider(
            color: Colors.grey.shade300,
            thickness: 2,
            indent: 35,
            endIndent: 35,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    if (currentPage != 2) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const signinParentScreen(),
                        ),
                      );
                    }
                  },
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      color: currentPage == 2 ? Colors.grey : customPurple,
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
                  onPressed: onNextPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: customPurple,
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
