import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:icon_infoware/controller/color_controller/color_controller.dart';
import 'package:icon_infoware/core/constants/app_constants.dart';

import 'package:icon_infoware/core/themes/colors.dart';
import 'package:icon_infoware/view/widgets/common_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BillTitlePopup extends ConsumerWidget {
  BillTitlePopup({super.key});
  final TextEditingController billTitle = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    billTitle.text = AppConstants.billTitle;
    final colorState = ref.watch(colorProvider);
    return AlertDialog(
      backgroundColor: AppColors.appWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: const Center(
        child: Text(
          'Set bill title',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
      content: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CommonTextField(
              controller: billTitle,
              hint: AppConstants.billTitle.isEmpty
                  ? 'Bill Title'
                  : AppConstants.billTitle,
              icon: Icons.title_rounded,
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

                  await prefs.setString('bill_title', billTitle.text);
                  AppConstants.billTitle = billTitle.text;
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
