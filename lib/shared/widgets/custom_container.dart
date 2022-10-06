import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    Key? key,
    required this.child,
    this.radius = 8.0,
    this.boxShape = BoxShape.rectangle,
  }) : super(key: key);

  final Widget child;
  final double radius;
  final BoxShape boxShape;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: boxShape == BoxShape.rectangle ? BorderRadius.circular(radius) : null,
        border: Border.all(
          color: Colors.white,
        ),
        shape: boxShape
      ),
      child: child,
    );
  }
}
