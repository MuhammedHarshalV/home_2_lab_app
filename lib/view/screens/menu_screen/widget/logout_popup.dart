import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

import 'package:icon_infoware/controller/color_controller/color_controller.dart'
    show colorProvider;
import 'package:icon_infoware/core/routes/app_route_names.dart';

import 'package:icon_infoware/core/themes/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutPopup extends ConsumerWidget {
  const LogoutPopup({super.key});

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
          Text("Logout", style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
      content: const Text(
        "Your billing data will be lost. Please complete your orders or remove them from 'Assigned to Me' before proceeding?",
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
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.remove('userName');
                  final box = await Hive.openBox('patient_booking');
                  await box.clear();
                  await prefs.remove('syncId');
                  await prefs.remove("PIN");
                  await prefs.remove('Today_date');
                  context.goNamed(AppRouteNames.signInScreen.name);
                },
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.appLightGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text(
                  "Logout",
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
