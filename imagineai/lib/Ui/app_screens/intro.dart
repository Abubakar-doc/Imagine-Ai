import 'package:flutter/material.dart';
import 'package:imagineai/Ui/app_screens/pages/intros/introPages.dart';

import '../auth_screens/signin/signin_Parent.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int currentPage = 0;
  static const millesecond = 200;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const BouncingScrollPhysics(),
              onPageChanged: (int index) {
                setState(() {
                  currentPage = index;
                });
              },
              children: [
                IntroPage(
                  onNextPressed: () {
                    _pageController.animateToPage(
                      1,
                      duration: const Duration(milliseconds: millesecond),
                      curve: Curves.easeInOut,
                    );
                  },
                  currentPage: currentPage,
                  pageController: _pageController,
                  millesecond: millesecond,
                  imagePath: 'assets/material/Introscreens/intro1.png',
                  headingText: 'Turn your words into artwork instantly',
                  subheadingText:
                  'Instantly convert your words into stunning visual creations with Imagine Ai',
                ),
                IntroPage(
                  onNextPressed: () {
                    _pageController.animateToPage(
                      2,
                      duration: const Duration(milliseconds: millesecond),
                      curve: Curves.easeInOut,
                    );
                  },
                  currentPage: currentPage,
                  pageController: _pageController,
                  millesecond: millesecond,
                  imagePath: 'assets/material/Introscreens/intro2.png',
                  headingText: 'Create and share your artwork with ease',
                  subheadingText: 'Easily Craft and Share Your Unique Artistic Vision with Imagine Ai',
                ),
                IntroPage(
                  onNextPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const signinParentScreen(),
                      ),
                    );
                  },
                  currentPage: currentPage,
                  pageController: _pageController,
                  millesecond: millesecond,
                  imagePath: 'assets/material/Introscreens/intro3.png',
                  headingText: 'Unleash your creativity with AI toolbox',
                  subheadingText: 'Let\'s Unlock Your Creative Potential with Imagine Ai',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
