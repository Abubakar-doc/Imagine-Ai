import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:imagineai/Ui/theme/themeStyle.dart';
import 'package:imagineai/utils/utils.dart';

typedef BackTextCallback = void Function(String, bool);

class ImagePlaceholderItem extends StatefulWidget {
  final String assetPath;
  final String backText;
  final bool initialSelectedState;
  final BackTextCallback onBackTextChanged;

  const ImagePlaceholderItem({
    Key? key,
    required this.assetPath,
    required this.backText,
    required this.initialSelectedState,
    required this.onBackTextChanged,
  }) : super(key: key);

  @override
  _ImagePlaceholderItemState createState() => _ImagePlaceholderItemState();
}

class _ImagePlaceholderItemState extends State<ImagePlaceholderItem> {
  bool isSelected = false;

  @override
  void initState() {
    isSelected = widget.initialSelectedState;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
        widget.onBackTextChanged(widget.backText, isSelected);
      },
      child: ImagePlaceholder(
        assetPath: widget.assetPath,
        backText: widget.backText,
        isSelected: isSelected,
      ),
    );
  }
}

class ImagePlaceholder extends StatelessWidget {
  final String assetPath;
  final String backText;
  final bool isSelected;

  const ImagePlaceholder({
    Key? key,
    required this.assetPath,
    required this.backText,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(assetPath),
                    fit: BoxFit.cover,
                  ),
                ),
                width: 130,
                height: 130,
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
                width: 130,
                height: 130,
              ),
            ),
            if (isSelected)
              Positioned(
                top: 130 * 0.05,
                right: 130 * 0.05,
                child: Icon(
                  Icons.check_circle_rounded,
                  color: Colors.white,
                  size: 40,
                ),
              ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          backText,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? customPurple : Theme.of(context).textTheme.bodyText1!.color,
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}

