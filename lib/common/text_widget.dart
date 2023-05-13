import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({
    Key? key,
    this.color = Colors.black,
    this.fontWeight = FontWeight.w400,
    this.size = 13,
    required this.text,
  }) : super(key: key);
  final String text;
  final Color color;
  final double size;
  final FontWeight fontWeight;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: fontWeight,
      ),
    );
  }
}
