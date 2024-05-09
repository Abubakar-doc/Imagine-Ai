// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:imagineai/Ui/themeStyle.dart';
// import 'package:imagineai/utils/utils.dart';
//
// class ImagePlaceholder extends StatefulWidget {
//   final String assetPath;
//   final String backText;
//   final Function(String) onBackTextChanged; // Callback function
//
//   const ImagePlaceholder({
//     Key? key,
//     required this.assetPath,
//     required this.backText,
//     required this.onBackTextChanged, // Pass the callback function
//   }) : super(key: key);
//
//   @override
//   _ImagePlaceholderState createState() => _ImagePlaceholderState();
// }
//
// class _ImagePlaceholderState extends State<ImagePlaceholder> {
//   bool isSelected = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           isSelected = !isSelected;
//         });
//         // Call the callback function with the selected back text
//         widget.onBackTextChanged(widget.backText);
//       },
//       child: Column(
//         children: [
//           FutureBuilder<void>(
//             future: _loadImage(context),
//             builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return _buildPlaceholder();
//               } else if (snapshot.hasError) {
//                 return const Icon(Icons.error);
//               } else {
//                 return Stack(
//                   children: [
//                     // Image and other elements
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(25),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           image: DecorationImage(
//                             image: AssetImage(widget.assetPath),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         width: 170,
//                         height: 170,
//                       ),
//                     ),
//                     // Border
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(25),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: isSelected ? customPurple : Colors.transparent,
//                             width: 2,
//                           ),
//                         ),
//                         width: 170,
//                         height: 170,
//                       ),
//                     ),
//                     if (isSelected)
//                       const Positioned(
//                         top: 8,
//                         right: 8,
//                         child: Icon(
//                           Icons.check_circle_rounded,
//                           color: Colors.white,
//                           size: 40,
//                         ),
//                       ),
//                   ],
//                 );
//               }
//             },
//           ),
//           const SizedBox(height: 8), // Adjust spacing as needed
//           Text(
//             widget.backText,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               color: isSelected ? customPurple : Theme.of(context).textTheme.bodyText1!.color,
//               fontWeight: FontWeight.w500,
//               fontSize: 20,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Future<void> _loadImage(BuildContext context) async {
//     try {
//       await precacheImage(AssetImage(widget.assetPath), context);
//     } catch (error) {
//       Utils().toastmsg(error, context);
//     }
//   }
//
//   Widget _buildPlaceholder() {
//     return Container(
//       width: 170,
//       height: 170,
//       decoration: BoxDecoration(
//         color: Colors.transparent,
//         borderRadius: BorderRadius.circular(30),
//       ),
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               width: 50,
//               height: 50,
//               decoration: const BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Colors.transparent,
//               ),
//               // Replace this with your loading spinner widget
//               child: const SpinKitThreeBounce(
//                 color: customPurple,
//                 size: 20.0,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:imagineai/Ui/theme/themeStyle.dart';
import 'package:imagineai/utils/utils.dart';

typedef BackTextCallback = void Function(String, bool);

class ImagePlaceholder extends StatefulWidget {
  final String assetPath;
  final String backText;
  final BackTextCallback onBackTextChanged;

  const ImagePlaceholder({
    Key? key,
    required this.assetPath,
    required this.backText,
    required this.onBackTextChanged,
  }) : super(key: key);

  @override
  _ImagePlaceholderState createState() => _ImagePlaceholderState();
}

class _ImagePlaceholderState extends State<ImagePlaceholder> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
        widget.onBackTextChanged(widget.backText, isSelected);
      },
      child: Column(
        children: [
          FutureBuilder<void>(
            future: _loadImage(context),
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return _buildPlaceholder();
              } else if (snapshot.hasError) {
                return const Icon(Icons.error);
              } else {
                return Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(widget.assetPath),
                            fit: BoxFit.cover,
                          ),
                        ),
                        width: 170,
                        height: 170,
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isSelected ? customPurple : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        width: 170,
                        height: 170,
                      ),
                    ),
                    if (isSelected)
                      const Positioned(
                        top: 8,
                        right: 8,
                        child: Icon(
                          Icons.check_circle_rounded,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                  ],
                );
              }
            },
          ),
          const SizedBox(height: 8),
          Text(
            widget.backText,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? customPurple : Theme.of(context).textTheme.bodyText1!.color,
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _loadImage(BuildContext context) async {
    try {
      await precacheImage(AssetImage(widget.assetPath), context);
    } catch (error) {
      Utils().toastmsg(error, context);
    }
  }

  Widget _buildPlaceholder() {
    return Container(
      width: 170,
      height: 170,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
              ),
              child: const SpinKitThreeBounce(
                color: customPurple,
                size: 20.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
