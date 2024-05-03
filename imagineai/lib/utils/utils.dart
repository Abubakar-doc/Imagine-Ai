import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class Utils {
  void toastmsg(dynamic error, BuildContext context) {
    String errorMessage = "An error occurred";

    // Check if the error message contains "[firebase_auth/"
    if (error.toString().contains("[firebase_auth/")) {
      errorMessage = error.toString();
      // Extract the error code from the message
      int start = errorMessage.indexOf("[firebase_auth/") + "[firebase_auth/".length;
      int end = errorMessage.indexOf("]");
      if (end != -1) {
        // Remove "firebase_auth/" and the surrounding brackets
        errorMessage = errorMessage.substring(start, end);
      }
    } else if (error is String) {
      errorMessage = error;
    }

    showToast(
      errorMessage,
      context: context,
      position: StyledToastPosition.top, // Show toast at the center of the screen
      duration: const Duration(seconds: 5), // Adjust the duration here
      borderRadius: BorderRadius.circular(8.0),
      backgroundColor: Colors.red,
      textStyle: const TextStyle(color: Colors.white, fontSize: 16.0),
      animation: StyledToastAnimation.fade,
      reverseAnimation: StyledToastAnimation.fade,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
    );
  }

  void successToastmsg(dynamic error, BuildContext context) {
    String errorMessage = "An error occurred";

    // Check if the error message contains "[firebase_auth/"
    if (error.toString().contains("[firebase_auth/")) {
      errorMessage = error.toString();
      // Extract the error code from the message
      int start = errorMessage.indexOf("[firebase_auth/") + "[firebase_auth/".length;
      int end = errorMessage.indexOf("]");
      if (end != -1) {
        // Remove "firebase_auth/" and the surrounding brackets
        errorMessage = errorMessage.substring(start, end);
      }
    } else if (error is String) {
      errorMessage = error;
    }

    showToast(
      errorMessage,
      context: context,
      position: StyledToastPosition.top, // Show toast at the center of the screen
      duration: const Duration(seconds: 5), // Adjust the duration here
      borderRadius: BorderRadius.circular(8.0),
      backgroundColor: Colors.green,
      textStyle: const TextStyle(color: Colors.white, fontSize: 16.0),
      animation: StyledToastAnimation.fade,
      reverseAnimation: StyledToastAnimation.fade,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
    );
  }
}
