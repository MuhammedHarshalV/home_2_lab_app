import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:icon_infoware/controller/color_controller/color_controller.dart';
import 'package:icon_infoware/core/constants/app_constants.dart';

import 'package:icon_infoware/core/themes/colors.dart';
import 'package:icon_infoware/view/widgets/common_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmailContentPopup extends ConsumerWidget {
  EmailContentPopup({super.key});
  final TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    email.text = AppConstants.emailContent;
    final colorState = ref.watch(colorProvider);
    return AlertDialog(
      backgroundColor: AppColors.appWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: const Center(
        child: Text(
          'Email Content',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
      content: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CommonTextField(
              controller: email,
              hint: AppConstants.emailContent.isEmpty
                  ? 'Email content'
                  : AppConstants.emailContent,
              icon: Icons.mark_email_read_outlined,
            ),
          ],
        ),
      ),
      // actionsPadding: const EdgeInsets.all(20),
      actions: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorState.secondaryColor,
                  foregroundColor: AppColors.appBlack,
                  minimumSize: const Size(0, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  context.pop();
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorState.primaryColor,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(0, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  Navigator.pop(context);
                  final prefs = await SharedPreferences.getInstance();

                  await prefs.setString('email_content', email.text);
                  AppConstants.emailContent = email.text;
                },
                child: const Text(
                  "Set",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
