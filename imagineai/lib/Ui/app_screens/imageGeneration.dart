import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:imagineai/Ui/app_screens/finalize.dart';
import 'package:imagineai/Ui/theme/themeStyle.dart';
import 'package:imagineai/Ui/widgets/imageContainerGenerationScreen.dart';
import 'package:imagineai/utils/utils.dart';
import '../../firebaseServices/image_sevice.dart';

class ImageGeneration extends StatefulWidget {
  final String generatedText;
  final int variations;

  const ImageGeneration(
    this.generatedText, {
    Key? key,
    required this.variations,
  }) : super(key: key);

  @override
  State<ImageGeneration> createState() => _ImageGenerationState();
}

class _ImageGenerationState extends State<ImageGeneration> {
  late ScrollController _scrollController;
  late double imageWidth; // Width of each image
  List<Uint8List?> cachedImages = [];
  List<bool> selectedImages = [];
  bool _isGenerating = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    imageWidth = 350;
    selectedImages = List.generate(widget.variations, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Edit Generation',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: selectedImages.contains(true) &&
                      !selectedImages.any((imageSelected) =>
                          imageSelected &&
                          cachedImages[selectedImages.indexOf(imageSelected)] ==
                              null)
                  ? () => _finalize()
                  : null,
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    return selectedImages.contains(true) &&
                            !selectedImages.any((imageSelected) =>
                                imageSelected &&
                                cachedImages[selectedImages
                                        .indexOf(imageSelected)] ==
                                    null)
                        ? customPurple
                        : Colors.grey;
                  },
                ),
              ),
              child: const Text(
                'Finalize',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: _scrollController,
                child: Row(
                  children: List.generate(widget.variations, (index) {
                    return GestureDetector(
                      onTap: () {
                        if (cachedImages[index] != null) {
                          setState(() {
                            _toggleImageSelection(index);
                          });
                        }
                      },
                      child: Stack(
                        children: [
                          FutureBuilder<Uint8List?>(
                            future: _getCachedImage(index),
                            builder: (context, snapshot) {
                              bool isLoading = snapshot.connectionState ==
                                  ConnectionState.waiting;
                              if (isLoading) {
                                // Disable image selection while images are being generated
                                return ImageContainer(null, isLoading);
                              } else if (snapshot.hasError ||
                                  snapshot.data == null) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.43,
                                    width: MediaQuery.of(context).size.height *
                                        0.43,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? Colors.grey[200]
                                          : Colors.grey[800],
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Center(
                                        child: Text(
                                          snapshot.hasError
                                              ? 'Error generating image: ${snapshot.error}'
                                              : 'Oops something went wrong \u{1F625}',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return ImageContainer(snapshot.data, isLoading);
                              }
                            },
                          ),
                          selectedImages[index]
                              ? Positioned(
                                  top: 10,
                                  right: 15,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Selected',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Icon(
                                            Icons.check_circle_rounded,
                                            color: Colors.white,
                                            size: 34,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox(), // Empty SizedBox if not selected
                        ],
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.grey.shade300
                        : customDarkContainerOutline,
                    width: 2, // Adjust the width as needed
                  ),
                  borderRadius:
                      BorderRadius.circular(10), // Adjust the radius as needed
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Scroll Images',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              _scrollController.animateTo(
                                _scrollController.offset - imageWidth,
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.ease,
                              );
                            },
                            icon: const Icon(Icons.arrow_back_sharp,
                                color:
                                    customPurple, // Assuming customPurple is not defined
                                size: 34),
                          ),
                          const SizedBox(width: 20),
                          IconButton(
                            onPressed: () {
                              _scrollController.animateTo(
                                _scrollController.offset + imageWidth,
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.ease,
                              );
                            },
                            icon: const Icon(Icons.arrow_forward_sharp,
                                color:
                                    customPurple, // Assuming customPurple is not defined
                                size: 34),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.grey.shade300
                        : customDarkContainerOutline,
                    width: 2,
                  ),
                  borderRadius:
                      BorderRadius.circular(10), // Adjust the radius as needed
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Select all images',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 28.0),
                        child: Transform.scale(
                          scale: 1.2,
                          child: Switch(
                            value: selectedImages
                                .every((isSelected) => isSelected),
                            onChanged: _isGenerating
                                ? null
                                : (newValue) {
                                    setState(() {
                                      selectedImages = List.generate(
                                        widget.variations,
                                        (_) => newValue ?? false,
                                      );
                                    });
                                  },
                            activeColor: customPurple,
                            inactiveTrackColor: Colors.transparent,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.grey.shade300
                      : customDarkTextContainer,
                  borderRadius:
                      BorderRadius.circular(10), // Customize border radius
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.edit,
                        size: 25,
                        color: customPurple,
                      ),
                      Text(
                        'Change prompt',
                        style: TextStyle(fontSize: 22, color: customPurple),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Uint8List?> _getCachedImage(int index) async {
    if (cachedImages.length <= index) {
      _isGenerating = true;
      Uint8List? imageData = await ModelQueryService()
          .queryModel({'inputs': widget.generatedText});
      cachedImages.add(imageData);
      _isGenerating = false;
      if (cachedImages.length == widget.variations && !_isGenerating) {
        // All images are generated, update the UI
        setState(() {});
      }
      return imageData;
    } else {
      return cachedImages[index];
    }
  }

  void _finalize() async {
    List<Uint8List?> selectedImageData = [];
    for (int i = 0; i < selectedImages.length; i++) {
      if (selectedImages[i]) {
        selectedImageData.add(cachedImages[i]);
      }
    }

    if (selectedImageData.isEmpty) {
      Utils().greytoastmsg('Please select a image first!!!', context);
      return;
    }

    Utils().pushSlideTransition(context,
        Finalize(widget.generatedText, selectedImageData: selectedImageData));
  }

  void _toggleImageSelection(int index) {
    setState(() {
      selectedImages[index] = !selectedImages[index];
    });
  }

}
