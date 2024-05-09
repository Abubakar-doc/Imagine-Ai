// import 'package:flutter/material.dart';

// class IntroPage extends StatelessWidget {
//   final int currentPage;
//   final String imagePath;
//   final String headingText;
//   final String subheadingText;

//   const IntroPage({
//     Key? key,
//     required this.currentPage,
//     required this.imagePath,
//     required this.headingText,
//     required this.subheadingText,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       // builder: (context, constraints) {
//         return SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const SizedBox(height: 50,),
//               SizedBox(
//                 width: constraints.maxWidth * 0.9,
//                 height: constraints.maxHeight * 0.5,
//                 child: Image.asset(
//                   imagePath,
//                   fit: BoxFit.contain,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 30),
//                 child: Column(
//                   children: [
//                     Text(
//                       headingText,
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: constraints.maxWidth < 600 ? 30 : 30,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     Text(
//                       subheadingText,
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: constraints.maxWidth < 600 ? 15 : 16,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
