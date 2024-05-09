import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../theme/themeStyle.dart';

class loadingcontainer extends StatelessWidget {
  const loadingcontainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Stack(
          children: [
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                    sigmaX: 3, sigmaY: 3), // Adjust the blur intensity
                child: Container(
                  color: Colors.black
                      .withOpacity(0.5), // Set the transparency to black
                ),
              ),
            ),
            // Content container (outside of BackdropFilter)
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.width * 0.9,
                padding: const EdgeInsets.symmetric(
                    horizontal: 30.0), // Adjust the padding as needed
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                      10.0), // Adjust the radius to your preference
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Processing',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: customPurple,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Please wait...',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Your request is under progress!',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: SpinKitThreeBounce(
                          color: customPurple,
                          size: 20.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
