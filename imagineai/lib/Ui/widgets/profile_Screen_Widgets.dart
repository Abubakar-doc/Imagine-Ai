import 'package:flutter/material.dart';

Widget _buildStatColumn(String label, int count) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        count.toString(),
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 4),
      Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.grey,
        ),
      ),
    ],
  );
}

Widget _buildVerticalDivider() {
  return Container(
    height: 50,
    child: const VerticalDivider(
      color: Colors.grey,
      thickness: 1,
    ),
  );
}