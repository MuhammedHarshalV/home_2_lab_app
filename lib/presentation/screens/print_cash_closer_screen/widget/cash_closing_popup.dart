import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:icon_infoware/controller/cash_closer_controller/cash_closer_controller.dart';

import 'package:icon_infoware/controller/color_controller/color_controller.dart'
    show colorProvider;
import 'package:icon_infoware/controller/home_screen_controller/home_screen_controller.dart';

import 'package:icon_infoware/core/themes/colors.dart';
import 'package:icon_infoware/models/patient_bill_syncing_model/patient_bill_syncing_model.dart';

class CashClosingPopup extends ConsumerWidget {
  const CashClosingPopup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorState = ref.watch(colorProvider);
    final cashClosingState = ref.watch(cashCloserProvider);
    final cashClosingController = ref.read(cashCloserProvider.notifier);
    final homeState = ref.watch(homeScreenProvider);
    final homeController = ref.read(homeScreenProvider.notifier);

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
        "Patients data will be reset after cash closing.Make sure to print before cash closing do you confirm?",
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
                  final List<PatientHiveModel> newList = homeState
                      .allBookingDetails
                      .where(
                        (patient) =>
                            patient.isSync == 'Yes' &&
                            patient.isClosed != 'Yes',
                      )
                      .toList();
                  final bool isClosed = await cashClosingController
                      .cashClosingApi(patients: newList, context: context);
                  if (isClosed == true) {
                    for (final patient in newList) {
                      await homeController.updatePatient(
                        index: patient.indexClick ?? 0,
                        isClosed: "Yes",
                      );
                    }
                  }
                },
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.appLightGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: cashClosingState.isLoading == true
                    ? SizedBox(
                        height: 20,
                        width: 20,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: colorState.primaryColor,
                            strokeWidth: 2,
                          ),
                        ),
                      )
                    : Text(
                        "Confirm",
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
