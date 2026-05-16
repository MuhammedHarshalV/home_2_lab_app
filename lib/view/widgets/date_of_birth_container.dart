import 'package:flutter/material.dart';
import 'package:icon_infoware/core/themes/colors.dart';

class DateOfBirthContainer extends StatelessWidget {
  final String hintText;
  final TextEditingController textController;
  final VoidCallback ageSetting;

  const DateOfBirthContainer({
    super.key,
    required this.hintText,
    required this.textController,
    required this.ageSetting,
  });

  Future<void> _showDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        // Optional: theme it to match your app colors
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.appPrimaryColor, // header & selected day color
              onPrimary: Colors.white, // text on header
              onSurface: AppColors.appPrimaryColor, // calendar text color
            ),
          ),
          child: child!,
        );
      },
    );

    // Only update if user picked a date (didn't cancel)
    if (picked != null) {
      final day = picked.day.toString().padLeft(2, '0');
      final month = picked.month.toString().padLeft(2, '0');
      final year = picked.year.toString();
      textController.text = '$day-$month-$year';
      ageSetting();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showDatePicker(context),
      child: Container(
        width: double.infinity,
        height: 60,
        padding: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          color: AppColors.appPrimaryColorLight,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.centerLeft,
        child: TextField(
          controller: textController,
          readOnly: true,
          enabled: false,
          decoration: InputDecoration(
            labelText: hintText,
            labelStyle: TextStyle(color: AppColors.appBlack),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
