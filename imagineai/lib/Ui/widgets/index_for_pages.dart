import 'package:flutter/material.dart';

class indexForPages extends StatelessWidget {
  final int currentPage;
  final Function(int) onPageSelected;

  const indexForPages({
    Key? key,
    required this.currentPage,
    required this.onPageSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < 3; i++)
          GestureDetector(
            onTap: () {
              onPageSelected(i);
            },
            child: SizedBox(
              width: 30, // Adjust width as needed
              child: Icon(
                Icons.circle,
                size: 20,
                color: i == currentPage ? const Color(0xFF5C3DF6) : Colors.grey,
              ),
            ),
          ),
      ],
    );
  }
}
