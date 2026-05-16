import 'package:flutter/material.dart';
import 'package:icon_infoware/core/themes/colors.dart';

class CommonTitleText extends StatelessWidget {
  final String title;

  const CommonTitleText({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Text(
          title,
          style: TextStyle(
            color: AppColors.appPrimaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
