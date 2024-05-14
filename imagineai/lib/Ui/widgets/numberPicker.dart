import 'package:flutter/material.dart';
import 'package:imagineai/Ui/theme/themeStyle.dart';
import 'package:numberpicker/numberpicker.dart';

class CustomNumberPicker extends StatefulWidget {
  final int value;
  final int minValue;
  final int maxValue;
  final int step;
  final double itemHeight;
  final Axis axis;
  final void Function(dynamic value) onChanged;
  final BoxDecoration decoration;

  const CustomNumberPicker({
    Key? key,
    required this.value,
    required this.minValue,
    required this.maxValue,
    required this.step,
    required this.itemHeight,
    required this.axis,
    required this.onChanged,
    required this.decoration,
  }) : super(key: key);

  @override
  State<CustomNumberPicker> createState() => _CustomNumberPickerState();
}

class _CustomNumberPickerState extends State<CustomNumberPicker> {
  late int _currentIntValue;

  @override
  void initState() {
    super.initState();
    _currentIntValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Variations',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  iconSize: 34, // Set the size of the icon
                  onPressed: () => setState(() {
                    final newValue = _currentIntValue - widget.step;
                    _currentIntValue = newValue.clamp(widget.minValue,
                        widget.maxValue); // Adjust clamping range
                    widget.onChanged(_currentIntValue);
                  }),
                ),
                const SizedBox(
                  width: 10,
                ),
                // Text('$_currentIntValue',
                //     style: const TextStyle(
                //         fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  iconSize: 34, // Set the size of the icon
                  onPressed: () => setState(() {
                    final newValue = _currentIntValue + widget.step;
                    _currentIntValue = newValue.clamp(widget.minValue,
                        widget.maxValue); // Adjust clamping range
                    widget.onChanged(_currentIntValue);
                  }),
                ),
              ],
            ),
          ],
        ),
        NumberPicker(
          value: _currentIntValue,
          minValue: widget.minValue,
          maxValue: widget.maxValue,
          step: widget.step,
          itemHeight: widget.itemHeight,
          axis: widget.axis,
          onChanged: (value) {
            setState(() {
              _currentIntValue = value;
            });
            widget.onChanged(value);
          },
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(
              color: customPurple,
              width: 2,
            ),
          ),
        ),
      ],
    );
  }
}
