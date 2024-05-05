import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:imagineai/Ui/themeStyle.dart';

class ImagePlaceholder extends StatefulWidget {
  final String assetPath;
  final String backText;

  const ImagePlaceholder({
    Key? key,
    required this.assetPath,
    required this.backText,
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
        print(widget.backText);
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
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isSelected ? customPurple : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Image.asset(
                          widget.assetPath,
                          width: 170,
                          height: 170,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    if (isSelected)
                      const Positioned(
                        top: 8,
                        right: 8,
                        child: Icon(
                          Icons.check_circle_rounded,
                          color: Colors.green,
                          size: 40,
                        ),
                      ),
                  ],
                );
              }
            },
          ),
          const SizedBox(height: 8), // Adjust spacing as needed
          Text(
            widget.backText,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? customPurple : Colors.black,
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
      // Handle error
      print(error);
    }
  }

  Widget _buildPlaceholder() {
    return Container(
      width: 170,
      height: 170,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
                color: Colors.white,
              ),
              // Replace this with your loading spinner widget
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
