import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:icon_infoware/controller/add_test_screen_controller/add_test_screen_controller.dart';
import 'package:icon_infoware/controller/home_screen_controller/home_screen_controller.dart';
import 'package:icon_infoware/core/themes/colors.dart';
import 'package:icon_infoware/view/widgets/common_text_field.dart';

class RefferenceIdDialog extends ConsumerWidget {
  final int index;
  const RefferenceIdDialog({super.key, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addTeststate = ref.watch(addTestScreenProvider);
    final addTestController = ref.read(addTestScreenProvider.notifier);

    final homeController = ref.read(homeScreenProvider.notifier);

    return PopScope(
      onPopInvoked: (didPop) async {
        if (didPop) {
          final homeState = ref.read(homeScreenProvider);
          addTeststate.upiRefferenceIdController.clear();
          addTestController.upiUpdates(
            homeState.allBookingDetails[index].upiReferenceId ?? '',
          );
        }
      },

      child: AlertDialog(
        backgroundColor: AppColors.appWhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: const Center(
          child: Text(
            'Enter UPI Reference ID',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        content: SizedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CommonTextField(
                controller: addTeststate.upiRefferenceIdController,
                hint: 'Reference ID',
                icon: Icons.qr_code_2_rounded,
                isNumberInput: true,
                onchanger: (p0) {
                  final homeState = ref.read(homeScreenProvider);
                  if (p0.trim().isNotEmpty) {
                    addTestController.upiUpdates(p0);
                  } else {
                    addTestController.upiUpdates(
                      homeState.allBookingDetails[index].upiReferenceId ?? '',
                    );
                  }
                },
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
                    backgroundColor: AppColors.appPrimaryColorLight,
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
                    backgroundColor: AppColors.appPrimaryColor,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(0, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    final addTeststate1 = ref.watch(addTestScreenProvider);
                    if (addTeststate1.upiRefferenceIdController.text
                        .trim()
                        .isNotEmpty) {
                      await homeController.updatePatient(
                        index: index,
                        upiReferenceId:
                            addTeststate1.upiRefferenceIdController.text,
                      );
                    }
                    Navigator.pop(context);
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
      ),
    );
  }
}
