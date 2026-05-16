import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icon_infoware/controller/patient_billing/patient_billing_controller.dart';
import 'package:icon_infoware/core/themes/colors.dart';

class SpotBillingPopUp extends ConsumerWidget {
  const SpotBillingPopUp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patientBillingController = ref.read(patientBillingProvider.notifier);

    return AlertDialog(
      backgroundColor: AppColors.appWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.warning_outlined,
            color: AppColors.appPrimaryColor,
            size: 30,
          ),
          SizedBox(width: 8),
          Text("Warning", style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
      content: const Text(
        "Entered details will be discarded! Are you sure you want to cancel?",
        textAlign: TextAlign.center,
      ),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      actions: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.appPrimaryColor,
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
                  // 👉 Example: update provider before leaving
                  // ref.read(yourProvider.notifier).reset();

                  Navigator.pop(context); // close dialog
                  Navigator.pop(context); // go back screen
                  patientBillingController.updateState(isAdditional: false);
                  patientBillingController.updateState(isUrgent: false);
                },
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.appLightGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text(
                  "YES",
                  style: TextStyle(
                    color: AppColors.appPrimaryColor,
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
