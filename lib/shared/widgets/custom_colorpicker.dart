import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class CustomColorPicker extends StatelessWidget {
  const CustomColorPicker(
      {Key? key,
      required this.text,
      required this.color,
      required this.onColorChanged})
      : super(key: key);

  final String text;
  final Color color;
  final void Function(Color) onColorChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(text),
        GestureDetector(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 8.0),
            width: 50.0,
            height: 25.0,
            color: color,
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  content: SingleChildScrollView(
                    child: ColorPicker(
                      pickerColor: color,
                      onColorChanged: onColorChanged,
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                      child: const Text('Got it'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }
}
