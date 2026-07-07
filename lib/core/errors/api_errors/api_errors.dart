import 'package:flutter/material.dart';
import 'package:icon_infoware/core/themes/colors.dart';

class AppMessage {
  static void show(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.appWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Center(
            child: Text("Alert", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [Center(child: Text(message))],
          ),
        );
      },
    );
  }
}
