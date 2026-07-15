import 'package:flutter/material.dart';
import 'package:icon_infoware/core/themes/colors.dart';

class TopText extends StatelessWidget {
  final String heading;
  final Color color;

  const TopText({super.key, required this.heading, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      heading,
      style: TextStyle(color: color, fontWeight: FontWeight.bold),
    );
  }
}
