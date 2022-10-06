import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomSlider extends StatelessWidget {
  const CustomSlider({
    Key? key,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    this.text,
  }) : super(key: key);

  final double value;
  final double min;
  final double max;
  final String? text;
  final Function(double) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Slider(
          value: value,
          min: min,
          max: max,
          onChanged: onChanged,
        ),
        Text(text ?? value.toStringAsFixed(1)),
      ],
    );
  }
}
