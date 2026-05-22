import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:icon_infoware/controller/add_test_screen_controller/add_test_screen_controller.dart';
import 'package:icon_infoware/core/themes/colors.dart';
import 'package:icon_infoware/view/screens/spot_billing_test_add_screen/widget/test_add_search_value_container.dart';

class AddNewTestPopUp extends ConsumerWidget {
  const AddNewTestPopUp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final patientBillingController = ref.read(patientBillingProvider.notifier);
    final testMasterState = ref.watch(addTestScreenProvider);
    final testMasterController = ref.read(addTestScreenProvider.notifier);

    return AlertDialog(
      backgroundColor: AppColors.appWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Center(
        child: Text(
          "Add new Test",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
      ),
      content: SizedBox(
        //height: MediaQuery.of(context).size.height / 2,
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TestAddSearchValueContainer(
              textController: testMasterState.searchController,
            ),
          ],
        ),
      ),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      actions: [
        Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () {
                  context.pop();
                  // // 👉 Example: update provider before leaving
                  // // ref.read(yourProvider.notifier).reset();

                  // context.pop(); // close dialog
                  // context.pop(); // go back screen
                  // patientBillingController.updateState(isAdditional: false);
                  // patientBillingController.updateState(isUrgent: false);
                },
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.appPrimaryColorLight,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                    color: AppColors.appPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  testMasterController.updateSelectedList();
                  context.pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.appPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text(
                  "Add",
                  style: TextStyle(
                    color: AppColors.appWhite,
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
