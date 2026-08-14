import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:icon_infoware/controller/color_controller/color_controller.dart'
    show colorProvider;

import 'package:icon_infoware/core/themes/colors.dart';

class SystemBackPopup extends ConsumerWidget {
  const SystemBackPopup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorState = ref.watch(colorProvider);

    return AlertDialog(
      backgroundColor: AppColors.appWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.warning_outlined,
            color: colorState.primaryColor,
            size: 30,
          ),
          SizedBox(width: 8),
          Text("Warning", style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
      content: const Text(
        "Are you sure want to exit the app?",
        textAlign: TextAlign.center,
      ),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      actions: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => context.pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorState.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text(
                  "CANCEL",
                  style: TextStyle(
                    color: AppColors.appWhite,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.appLightGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text(
                  "YES",
                  style: TextStyle(
                    color: colorState.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
