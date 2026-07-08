import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:icon_infoware/controller/add_test_screen_controller/add_test_screen_controller.dart';
import 'package:icon_infoware/controller/home_screen_controller/home_screen_controller.dart';
import 'package:icon_infoware/core/errors/api_errors/api_errors.dart';
import 'package:icon_infoware/core/themes/colors.dart';
import 'package:icon_infoware/view/widgets/common_text_field.dart';
import 'package:icon_infoware/view/widgets/type_text_form_field.dart';

class DiscountDialog extends ConsumerWidget {
  final int index;
  const DiscountDialog({super.key, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addTeststate = ref.watch(addTestScreenProvider);
    final homeController = ref.read(homeScreenProvider.notifier);

    final addTestcontroller = ref.read(addTestScreenProvider.notifier);

    return PopScope(
      // ignore: deprecated_member_use
      onPopInvoked: (didPop) async {
        if (didPop) {
          final homeState = ref.watch(homeScreenProvider);
          addTeststate.discountAmountController.text = homeState
              .allBookingDetails[index]
              .discAmt
              .toString();
          await addTestcontroller.updateNetBalanceAmounts();
          final testMasterState1 = ref.watch(addTestScreenProvider);
          await homeController.updatePatient(
            index: index,

            discAmt:
                num.tryParse(testMasterState1.discountAmountController.text) ??
                0,
            balance: testMasterState1.balanceAmount,
            netAmt: testMasterState1.netAmount,
            paidAmt: testMasterState1.amountPaid,
            grossAmt: testMasterState1.totalPrice,
            servChrge:
                num.tryParse(testMasterState1.servicesnargeController.text) ??
                0,
          );
        }
      },
      child: AlertDialog(
        backgroundColor: AppColors.appWhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: const Center(
          child: Text(
            'Set discount',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        content: SizedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CommonTextField(
                controller: addTeststate.discountAmountController,
                hint: 'Discount Amount',
                icon: Icons.discount_outlined,
                isNumberInput: true,
                focusNode: true,
                onchanger: (value) async {
                  final amount = num.tryParse(value);

                  if (amount != null) {
                    addTestcontroller.discountCalculation(
                      discountAmount: amount,
                    );
                    await addTestcontroller.updateNetBalanceAmounts();
                  } else {
                    addTeststate.discountPercentageController.clear();
                    addTeststate.discountAmountController.clear();
                    await addTestcontroller.updateNetBalanceAmounts();
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
                  }
                },
              ),

              CommonTextField(
                controller: addTeststate.discountPercentageController,
                hint: 'Discount Percentage',
                icon: Icons.percent,
                focusNode: true,
                isNumberInput: true,
                onchanger: (value) async {
                  final amount = num.tryParse(value);

                  if (amount != null) {
                    addTestcontroller.discountCalculation(
                      discountPercentage: amount,
                    );
                    await addTestcontroller.updateNetBalanceAmounts();
                  } else {
                    addTeststate.discountPercentageController.clear();
                    addTeststate.discountAmountController.clear();
                    await addTestcontroller.updateNetBalanceAmounts();
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
                  }
                },
              ),

              const SizedBox(height: 10),

              TypeTextFormField(
                hintText: 'Reason *',
                textController: addTeststate.discountReason,
                isSuffix: true,
                isReadOnly: true,
                dropDown: addTeststate.discountList,
                onChanged: (p0) {
                  //  addTeststate.genderController.text = p0;
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
                    final homeState = ref.watch(homeScreenProvider);
                    addTeststate.discountAmountController.text = homeState
                        .allBookingDetails[index]
                        .discAmt
                        .toString();
                    await addTestcontroller.updateNetBalanceAmounts();
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
                    if (addTeststate.discountReason.text.isEmpty) {
                      AppMessage.show(context, 'Please fill the Reason.');
                    } else {
                      await addTestcontroller.updateNetBalanceAmounts();
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
                    }
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
