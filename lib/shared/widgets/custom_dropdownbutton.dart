import 'package:flutter/material.dart';

class CustomDropdownButton extends StatelessWidget {
  const CustomDropdownButton({
    Key? key,
    this.value,
    required this.items,
    required this.onChanged,
    required this.text,
    this.tooltip,
  }) : super(key: key);

  final Object? value;
  final List<DropdownMenuItem<Object>>? items;
  final Function(Object?)? onChanged;
  final String text;
  final Widget? tooltip;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('$text '),
        if (tooltip != null) tooltip!,
        Text(' : '),
        const SizedBox(
          width: 8.0,
        ),
        DropdownButton(
          value: value,
          items: items,
          onChanged: onChanged,
          underline: const SizedBox.shrink(),
          alignment: AlignmentDirectional.center,
          style: const TextStyle(fontSize: 14.0, color: Colors.white),
        ),
      ],
    );
  }
}
