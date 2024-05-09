// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:imagineai/Ui/theme/themeStyle.dart';
// import 'dart:typed_data';
// import '../../firebaseServices/image_sevice.dart';
//
// class ImageGeneration extends StatefulWidget {
//   final String generatedText;
//
//   const ImageGeneration(this.generatedText, {super.key});
//
//   @override
//   State<ImageGeneration> createState() => _ImageGenerationState();
// }
//
// class _ImageGenerationState extends State<ImageGeneration> {
//   bool loading = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               'Edit Generation',
//               style: TextStyle(
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Text(
//               'Finalize',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: customPurple,
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Container(
//                 height: 350,
//                 decoration: BoxDecoration(
//                   color: Theme.of(context).brightness == Brightness.light
//                       ? customLightTextContainer
//                       : customDarkTextContainer,
//                   borderRadius: BorderRadius.circular(20.0),
//                 ),
//                 child: Center(
//                   child: FutureBuilder<Uint8List?>(
//                     future: ModelQueryService()
//                         .queryModel({'inputs': widget.generatedText}),
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return const Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             SpinKitThreeBounce(
//                               color: customPurple,
//                               size: 30.0,
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Text(
//                               'Generating...',
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 fontSize: 22,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         );
//                       } else if (snapshot.hasError) {
//                         return Padding(
//                           padding: const EdgeInsets.all(20.0),
//                           child: Text(
//                             'Oops ${snapshot.error} \u{1F625}',
//                             textAlign: TextAlign.center,
//                             style: const TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         );
//                       } else if (snapshot.hasData) {
//                         return ClipRRect(
//                           borderRadius: BorderRadius.circular(20.0),
//                           child: Image.memory(snapshot.data!),
//                         );
//                       } else {
//                         return const Padding(
//                           padding: EdgeInsets.all(20.0),
//                           child: Text(
//                             'Oops something went wrong \u{1F625}',
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         );
//                       }
//                     },
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   SizedBox(
//                     height: 50,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         // Add your undo logic here for the first button
//                       },
//                       style: ElevatedButton.styleFrom(
//                         foregroundColor: customPurple,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                           side: const BorderSide(
//                               color: customPurple,
//                               width: 2), // Increased border size
//                         ),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(Icons.undo,
//                               color: Theme.of(context).brightness == Brightness.light
//                                   ? customPurple
//                                   : customWhitebg,
//                               size: 24), // Increased icon size
//                           const SizedBox(width: 5), // Adjust spacing as needed
//                           Text('Undo',
//                               style: TextStyle(
//                                   color: Theme.of(context).brightness == Brightness.light
//                                       ? customPurple
//                                       : customWhitebg,
//                                   fontSize: 20)), // Increased text size
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                       width: 10), // Adjust spacing between buttons as needed
//                   SizedBox(
//                     height: 50,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         // Add your redo logic here for the second button
//                       },
//                       style: ElevatedButton.styleFrom(
//                         foregroundColor: customPurple,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                           side: const BorderSide(
//                               color: customPurple,
//                               width: 2), // Increased border size
//                         ),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text('Redo',
//                               style: TextStyle(
//                                   color: Theme.of(context).brightness ==
//                                           Brightness.light
//                                       ? customPurple
//                                       : customWhitebg,
//                                   fontSize: 20)), // Increased text size
//                           const SizedBox(width: 5), // Adjust spacing as needed
//                           Icon(Icons.redo,
//                               color: Theme.of(context).brightness ==
//                                       Brightness.light
//                                   ? customPurple
//                                   : customWhitebg,
//                               size: 24), // Increased icon size
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 80,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Expanded(
//                     flex: 1,
//                     child: Container(
//                       height: 120,
//                       decoration: BoxDecoration(
//                         color: Theme.of(context).brightness == Brightness.light
//                             ? customLightTextContainer
//                             : customDarkTextContainer,
//                         borderRadius: BorderRadius.circular(8.0),
//                       ),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(Icons.refresh,
//                               color: Theme.of(context).brightness == Brightness.light
//                                   ? customPurple
//                                   : customWhitebg,
//                               size: 30), // Adjust icon size
//                           const SizedBox(height: 10), // Adjust spacing as needed
//                           Text('Re-Generate',
//                               style: TextStyle(
//                                   color: Theme.of(context).brightness == Brightness.light
//                                       ? customPurple
//                                       : customWhitebg,
//                                   fontSize: 18)), // Adjust text size
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 20),
//                   Expanded(
//                     flex: 1,
//                     child: Container(
//                       height: 120,
//                       decoration: BoxDecoration(
//                         color: Theme.of(context).brightness == Brightness.light
//                             ? customLightTextContainer
//                             : customDarkTextContainer,
//                         borderRadius: BorderRadius.circular(8.0),
//                       ),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(Icons.edit,
//                               color: Theme.of(context).brightness == Brightness.light
//                                   ? customPurple
//                                   : customWhitebg,
//                               size: 30), // Adjust icon size
//                           const SizedBox(height: 10), // Adjust spacing as needed
//                           Text('Edit input',
//                               style: TextStyle(
//                                   color: Theme.of(context).brightness == Brightness.light
//                                       ? customPurple
//                                       : customWhitebg,
//                                   fontSize: 18)), // Adjust text size
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               )
//
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:imagineai/Ui/theme/themeStyle.dart';
import 'dart:typed_data';
import '../../firebaseServices/image_sevice.dart';

class ImageGeneration extends StatefulWidget {
  final String generatedText;

  const ImageGeneration(this.generatedText, {Key? key}) : super(key: key);

  @override
  State<ImageGeneration> createState() => _ImageGenerationState();
}

class _ImageGenerationState extends State<ImageGeneration> {
  bool loading = false;
  Uint8List? generatedImage;

  Future<Uint8List?> _queryModelForImage(String inputText) async {
    // Query the model with the input text
    return ModelQueryService().queryModel({'inputs': inputText});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Edit Generation',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Finalize',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: customPurple,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 350,
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.light
                      ? customLightTextContainer
                      : customDarkTextContainer,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Center(
                  child: FutureBuilder<Uint8List?>(
                    future: _queryModelForImage(widget.generatedText),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SpinKitThreeBounce(
                              color: customPurple,
                              size: 30.0,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Generating...',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            'Oops ${snapshot.error} \u{1F625}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      } else if (snapshot.hasData) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.memory(snapshot.data!),
                        );
                      } else {
                        return const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text(
                            'Oops something went wrong \u{1F625}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // Add your undo logic here for the first button
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: customPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: const BorderSide(
                              color: customPurple,
                              width: 2), // Increased border size
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.undo,
                              color: Theme.of(context).brightness == Brightness.light
                                  ? customPurple
                                  : customWhitebg,
                              size: 24), // Increased icon size
                          const SizedBox(width: 5), // Adjust spacing as needed
                          Text('Undo',
                              style: TextStyle(
                                  color: Theme.of(context).brightness == Brightness.light
                                      ? customPurple
                                      : customWhitebg,
                                  fontSize: 20)), // Increased text size
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                      width: 10), // Adjust spacing between buttons as needed
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // Add your redo logic here for the second button
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: customPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: const BorderSide(
                              color: customPurple,
                              width: 2), // Increased border size
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Redo',
                              style: TextStyle(
                                  color: Theme.of(context).brightness ==
                                      Brightness.light
                                      ? customPurple
                                      : customWhitebg,
                                  fontSize: 20)), // Increased text size
                          const SizedBox(width: 5), // Adjust spacing as needed
                          Icon(Icons.redo,
                              color: Theme.of(context).brightness ==
                                  Brightness.light
                                  ? customPurple
                                  : customWhitebg,
                              size: 24), // Increased icon size
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              // Container to display the regenerated image
              generatedImage != null
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.memory(generatedImage!),
              )
                  : Container(),
              const SizedBox(
                height: 80,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        // Clear the generatedImage variable
                        setState(() {
                          loading = true; // Set loading to true to show the loading spinner
                        });
                        // Query the model again with the current input text
                        ModelQueryService()
                            .queryModel({'inputs': widget.generatedText + 'regenerate'})
                            .then((imageData) {
                          setState(() {
                            loading = false;
                            generatedImage = imageData;
                          });
                        })
                            .catchError((error) {
                          setState(() {
                            loading = false; // Set loading to false if an error occurs
                          });
                          // Handle error
                          print('Error generating image: $error');
                        });
                      },
                      child: Container(
                        height: 120,
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.light
                              ? customLightTextContainer
                              : customDarkTextContainer,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.refresh,
                                color: Theme.of(context).brightness == Brightness.light
                                    ? customPurple
                                    : customWhitebg,
                                size: 30), // Adjust icon size
                            const SizedBox(height: 10), // Adjust spacing as needed
                            Text('Re-Generate',
                                style: TextStyle(
                                    color: Theme.of(context).brightness == Brightness.light
                                        ? customPurple
                                        : customWhitebg,
                                    fontSize: 18)), // Adjust text size
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.light
                            ? customLightTextContainer
                            : customDarkTextContainer,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.edit,
                              color: Theme.of(context).brightness == Brightness.light
                                  ? customPurple
                                  : customWhitebg,
                              size: 30), // Adjust icon size
                          const SizedBox(height: 10), // Adjust spacing as needed
                          Text('Edit input',
                              style: TextStyle(
                                  color: Theme.of(context).brightness == Brightness.light
                                      ? customPurple
                                      : customWhitebg,
                                  fontSize: 18)), // Adjust text size
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
