import 'package:flutter/material.dart';

class CustomDropdownButton extends StatelessWidget {
  const CustomDropdownButton({
    Key? key,
    this.value,
    required this.items,
    required this.onChanged,
    required this.text,
  }) : super(key: key);

  final Object? value;
  final List<DropdownMenuItem<Object>>? items;
  final Function(Object?)? onChanged;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: Colors.white,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('$text :'),
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
      ),
    );
  }
}
