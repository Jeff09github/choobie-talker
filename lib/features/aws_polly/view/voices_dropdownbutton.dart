import 'package:aws_polly_api/polly-2016-06-10.dart';
import 'package:flutter/material.dart';

class VoicesDropdownButton extends StatelessWidget {
  const VoicesDropdownButton(
      {Key? key, required this.items, this.onChanged, this.value})
      : super(key: key);

  final List<Voice> items;
  final Voice? value;
  final Function(dynamic)? onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      alignment: AlignmentDirectional.center,
      value: value,
      items: items
          .map(
            (e) => DropdownMenuItem(
              alignment: AlignmentDirectional.center,
              value: e,
              child: Text(
                '${e.name!}(${e.languageName})',
              ),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}
