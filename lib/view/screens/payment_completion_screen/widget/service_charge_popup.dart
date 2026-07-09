import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:icon_infoware/controller/add_test_screen_controller/add_test_screen_controller.dart';
import 'package:icon_infoware/controller/home_screen_controller/home_screen_controller.dart';
import 'package:icon_infoware/core/themes/colors.dart';
import 'package:icon_infoware/view/widgets/common_text_field.dart';

class ServiceChangeDialog extends ConsumerWidget {
  final int index;
  const ServiceChangeDialog({super.key, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addTeststate = ref.watch(addTestScreenProvider);
    final addTestController = ref.read(addTestScreenProvider.notifier);
    final homeController = ref.read(homeScreenProvider.notifier);

    return PopScope(
      onPopInvoked: (didPop) async {
        if (didPop) {
          // Same code as your Cancel button
          final homeState = ref.read(homeScreenProvider);

          addTeststate.servicesnargeController.text = homeState
              .allBookingDetails[index]
              .servChrge
              .toString();

          await addTestController.updateNetBalanceAmounts();
          // final testMasterState1 = ref.watch(addTestScreenProvider);
          // await homeController.updatePatient(
          //   index: index,

          //   discAmt:
          //       num.tryParse(testMasterState1.discountAmountController.text) ??
          //       0,
          //   balance: testMasterState1.balanceAmount,
          //   netAmt: testMasterState1.netAmount,
          //   paidAmt: testMasterState1.amountPaid,
          //   grossAmt: testMasterState1.totalPrice,
          //   servChrge:
          //       num.tryParse(testMasterState1.servicesnargeController.text) ??
          //       0,
          // );
        }
      },
      child: AlertDialog(
        backgroundColor: AppColors.appWhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: const Center(
          child: Text(
            'Set Service charge',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        content: SizedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CommonTextField(
                controller: addTeststate.servicesnargeController,
                hint: 'Service Charge',
                icon: Icons.discount_outlined,
                isNumberInput: true,
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
                    final homeState1 = ref.read(homeScreenProvider);
                    addTeststate.servicesnargeController.text = homeState1
                        .allBookingDetails[index]
                        .servChrge
                        .toString();
                    await addTestController.updateNetBalanceAmounts();
                    // final testMasterState1 = ref.watch(addTestScreenProvider);
                    // await homeController.updatePatient(
                    //   index: index,

                    //   discAmt:
                    //       num.tryParse(
                    //         testMasterState1.discountAmountController.text,
                    //       ) ??
                    //       0,
                    //   balance: testMasterState1.balanceAmount,
                    //   netAmt: testMasterState1.netAmount,
                    //   paidAmt: testMasterState1.amountPaid,
                    //   grossAmt: testMasterState1.totalPrice,
                    //   servChrge:
                    //       num.tryParse(
                    //         testMasterState1.servicesnargeController.text,
                    //       ) ??
                    //       0,
                    // );
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
                    await addTestController.updateNetBalanceAmounts();
                    final testMasterState1 = ref.watch(addTestScreenProvider);
                    await homeController.updatePatient(
                      index: index,

                      discAmt:
                          num.tryParse(
                            testMasterState1.discountAmountController.text,
                          ) ??
                          0,
                      balance: testMasterState1.balanceAmount,
                      netAmt: testMasterState1.netAmount,
                      paidAmt: testMasterState1.amountPaid,
                      grossAmt: testMasterState1.totalPrice,
                      servChrge:
                          num.tryParse(
                            testMasterState1.servicesnargeController.text,
                          ) ??
                          0,
                    );
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
