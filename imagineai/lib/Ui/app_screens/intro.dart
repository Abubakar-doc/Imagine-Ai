import 'package:flutter/material.dart';
import 'package:imagineai/Ui/app_screens/pages/intros/introPages.dart';
import 'package:imagineai/Ui/theme/themeStyle.dart';
import 'package:imagineai/Ui/widgets/index_for_pages.dart';
import '../../utils/utils.dart';
import '../auth_screens/signin/signin_Parent.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int currentPage = 0;
  static const millisecond = 200;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: lightTheme, // Use the light theme explicitly
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            PageView(
              controller: _pageController,
              physics: const BouncingScrollPhysics(),
              onPageChanged: (int index) {
                setState(() {
                  currentPage = index;
                });
              },
              children: [
                IntroPage(
                  currentPage: currentPage,
                  imagePath: 'assets/material/Introscreens/intro1.png',
                  headingText: 'Turn your words into artwork instantly',
                  subheadingText:
                  'Instantly convert your words into stunning visual creations with Imagine Ai',
                ),
                IntroPage(
                  currentPage: currentPage,
                  imagePath: 'assets/material/Introscreens/intro2.png',
                  headingText: 'Create and share your artwork with ease',
                  subheadingText:
                  'Easily Craft and Share Your Unique Artistic Vision with Imagine Ai',
                ),
                IntroPage(
                  currentPage: currentPage,
                  imagePath: 'assets/material/Introscreens/intro3.png',
                  headingText: 'Unleash your creativity with AI toolbox',
                  subheadingText:
                  'Let\'s Unlock Your Creative Potential with Imagine Ai',
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  indexForPages(
                    pageController: _pageController,
                    millisecond: millisecond,
                    currentPage: currentPage,
                  ),
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
                      if (currentPage < 2) // Change 2 to the index of the last page
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: () {
                              _pageController.animateToPage(
                                2,
                                duration:
                                const Duration(milliseconds: millisecond),
                                curve: Curves.easeInOut,
                              );
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
                      if (currentPage < 2) // Change 2 to the index of the last page
                        const SizedBox(width: 20),
                      if (currentPage < 2) // Change 2 to the index of the last page
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: () {
                              _pageController.nextPage(
                                duration:
                                const Duration(milliseconds: millisecond),
                                curve: Curves.easeInOut,
                              );
                            },
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
                      if (currentPage == 2) // Change 2 to the index of the last page
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.85,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: () {
                              Utils().pushSlideTransition(
                                  context, const signinParentScreen());
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: customPurple,
                            ),
                            child: const Text(
                              'Get Started',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
