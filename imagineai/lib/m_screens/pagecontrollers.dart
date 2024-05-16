// import 'package:flutter/material.dart';
//
// import '../theme/themeStyle.dart';
//
// class indexForPages extends StatelessWidget {
//   const indexForPages({
//     super.key,
//     required PageController pageController,
//     required this.millisecond,
//     required this.currentPage,
//   }) : _pageController = pageController;
//
//   final PageController _pageController;
//   final int millisecond;
//   final int currentPage;
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 50,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: List.generate(
//           3,
//               (index) => GestureDetector(
//             onTap: () {
//               _pageController.animateToPage(
//                 index,
//                 duration: Duration(milliseconds: millisecond),
//                 curve: Curves.easeInOut,
//               );
//             },
//             child: Container(
//               width: 10,
//               height: 10,
//               margin: EdgeInsets.symmetric(horizontal: 5),
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: currentPage == index
//                     ? customPurple
//                     : Colors.grey,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
