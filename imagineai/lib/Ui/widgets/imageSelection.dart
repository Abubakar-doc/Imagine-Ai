import 'package:flutter/material.dart';

class ImageSelectionState extends ChangeNotifier {
  List<bool> isSelected;

  ImageSelectionState(int length)
      : isSelected = List<bool>.filled(length, false);

  void toggleSelection(int index) {
    isSelected[index] = !isSelected[index];
    notifyListeners();
  }
}
