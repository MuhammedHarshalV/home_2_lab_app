import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:icon_infoware/core/themes/colors.dart';

class CommonTextField extends StatelessWidget {
  final String? label;
  final String hint;
  final IconData icon;
  final bool isNumberInput;
  final TextEditingController? controller;
  final Function(String)? onchanger;
  final bool focusNode;

  const CommonTextField({
    super.key,
    this.focusNode = false,
    this.label = '',
    required this.hint,
    required this.icon,
    this.controller,
    this.isNumberInput = false,
    this.onchanger,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label!.isNotEmpty && label != null)
          Text(
            label!,
            style: TextStyle(
              color: AppColors.appPrimaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          onTapOutside: focusNode == false
              ? (_) {
                  FocusManager.instance.primaryFocus?.unfocus();
                }
              : null,
          onChanged: onchanger,
          keyboardType: isNumberInput
              ? TextInputType.number
              : TextInputType.text,
          inputFormatters: isNumberInput
              ? [FilteringTextInputFormatter.digitsOnly]
              : null,
          decoration: InputDecoration(
            labelText: null,
            // focusedBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(12),
            //   borderSide: const BorderSide(
            //     color: AppColors.appBlack, // black border
            //     width: 1,
            //   ),
            // ),
            hintText: hint,
            hintStyle: TextStyle(
              color: AppColors.appBlack, // change to your color
              // fontSize: 14,
            ),
            prefixIcon: Icon(icon, color: AppColors.appPrimaryColor, size: 20),
            filled: true,
            fillColor: AppColors.appPrimaryColorLight,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
        // SizedBox(height: 20),
      ],
    );
  }
}
