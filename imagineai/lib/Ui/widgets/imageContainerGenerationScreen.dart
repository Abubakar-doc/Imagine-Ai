
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:imagineai/Ui/theme/themeStyle.dart';

class ImageContainer extends StatelessWidget {
  final Uint8List? imageData;
  final bool isLoading;
  const ImageContainer(this.imageData, this.isLoading, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultColor = Theme.of(context).brightness == Brightness.light
        ? Colors.grey[200] ?? Colors.grey // Provide a default color if null
        : Colors.grey[800] ?? Colors.grey; // Provide a default color if null

    return Padding(
      padding: const EdgeInsets.only(right: 5.0),
      child: Container(
        width: MediaQuery.of(context).size.height * 0.43,
        height: MediaQuery.of(context).size.height * 0.43,
        decoration: BoxDecoration(
          color: defaultColor,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: isLoading
            ? const Column(
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
        )
            : imageData != null
            ? ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Image.memory(
            imageData!,
            fit: BoxFit.cover,
          ),
        )
            : Placeholder(
          color: defaultColor,
        ),
      ),
    );
  }
}