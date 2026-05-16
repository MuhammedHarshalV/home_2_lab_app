import 'package:flutter/material.dart';
import 'package:icon_infoware/core/themes/colors.dart';

class TopText extends StatelessWidget {
  final String heading;

  const TopText({super.key, required this.heading});

  @override
  Widget build(BuildContext context) {
    return Text(
      heading,
      style: TextStyle(color: AppColors.appPrimaryColor, fontWeight: FontWeight.bold),
    );
  }
}
