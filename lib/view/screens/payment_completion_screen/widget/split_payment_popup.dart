import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:icon_infoware/controller/add_test_screen_controller/add_test_screen_controller.dart';
import 'package:icon_infoware/controller/color_controller/color_controller.dart';
import 'package:icon_infoware/controller/home_screen_controller/home_screen_controller.dart';
import 'package:icon_infoware/core/errors/api_errors/api_errors.dart';
import 'package:icon_infoware/core/themes/colors.dart';

class SplitPaymentDialog extends ConsumerWidget {
  final int index;
  const SplitPaymentDialog({super.key, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addTestState = ref.watch(addTestScreenProvider);
    final addTestController = ref.read(addTestScreenProvider.notifier);
    final homeController = ref.read(homeScreenProvider.notifier);
    final colorState = ref.watch(colorProvider);
    return PopScope(
      // ignore: deprecated_member_use
      onPopInvoked: (didPop) async {
        if (didPop) {
          final homeState = ref.read(homeScreenProvider);
          addTestState.primaryAmountContoller.clear();
          addTestState.secondaryAmountController.clear();
          final patient = homeState.allBookingDetails.firstWhere(
            (e) => e.indexClick == index,
          );

          addTestState.primaryAmountContoller.text = patient.primaryPaid
              .toString();

          addTestState.secondaryAmountController.text = patient.secondaryPaid
              .toString();

          // addTestController.updatestate(
          //   primaryPaid: homeState.allBookingDetails[index].primaryPaid ?? 0,
          //   secondaryPaid:
          //       homeState.allBookingDetails[index].secondaryPaid ?? 0,
          //   amountPaid:
          //       (homeState.allBookingDetails[index].primaryPaid ?? 0) +
          //       (homeState.allBookingDetails[index].secondaryPaid ?? 0),
          //   primaryType: homeState.allBookingDetails[index].primaryType ?? '',
          //   secondaryType:
          //       homeState.allBookingDetails[index].secondaryType ?? '',
          // );

          await addTestController.updateNetBalanceAmounts();
        }
      },
      child: Dialog(
        backgroundColor: AppColors.appWhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// Title
                const Text(
                  "Split Payment",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 5),

                RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.black, fontSize: 14),
                    children: [
                      const TextSpan(
                        text: "Total amount : ",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      TextSpan(
                        text: "₹ ${addTestState.netAmount.toStringAsFixed(2)}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                Row(
                  children: [
                    Expanded(
                      child: _AmountField(
                        title: "Primary",
                        controller: addTestState.primaryAmountContoller,
                        ontap: (p0) async {
                          if (p0.isNotEmpty) {
                            addTestController.updatestate(
                              primaryPaid: (num.tryParse(p0) ?? 0),
                            );
                            final state = ref.watch(addTestScreenProvider);
                            num amountPaid =
                                state.primaryPaid + state.secondaryPaid;
                            addTestController.updatestate(
                              amountPaid: amountPaid,
                            );
                            await addTestController.updateNetBalanceAmounts();
                            // num lastAmount =
                            //     amountPaid + addTestState.secondaryPaid;
                          } else {
                            addTestController.updatestate(primaryPaid: 0);
                            final state = ref.watch(addTestScreenProvider);
                            num amountPaid =
                                state.primaryPaid + state.secondaryPaid;
                            addTestController.updatestate(
                              amountPaid: amountPaid,
                            );
                            await addTestController.updateNetBalanceAmounts();
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,

                        onTapDown: (details) async {
                          List<String> item = ['Cash', 'UPI', 'Card'];
                          final String? result = await showDropDown(
                            context,
                            details.globalPosition,
                            item,
                          );
                          if (result != null) {
                            addTestController.updatestate(primaryType: result);
                          }
                        },
                        child: DropdownPayment(
                          title: addTestState.primaryType.isEmpty
                              ? 'Cash'
                              : addTestState.primaryType,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                Row(
                  children: [
                    Expanded(
                      child: _AmountField(
                        title: "Secondary",
                        controller: addTestState.secondaryAmountController,
                        ontap: (p0) async {
                          if (p0.isNotEmpty) {
                            addTestController.updatestate(
                              secondaryPaid: (num.tryParse(p0) ?? 0),
                            );
                            final state = ref.watch(addTestScreenProvider);
                            num amountPaid =
                                state.primaryPaid + state.secondaryPaid;
                            addTestController.updatestate(
                              amountPaid: amountPaid,
                            );
                            await addTestController.updateNetBalanceAmounts();
                            // num lastAmount =
                            //     amountPaid + addTestState.secondaryPaid;
                          } else {
                            addTestController.updatestate(secondaryPaid: 0);
                            final state = ref.watch(addTestScreenProvider);
                            num amountPaid =
                                state.primaryPaid + state.secondaryPaid;
                            addTestController.updatestate(
                              amountPaid: amountPaid,
                            );
                            await addTestController.updateNetBalanceAmounts();
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        onTapDown: (details) async {
                          List<String> item = ['Cash', 'UPI', 'Card'];
                          final String? result = await showDropDown(
                            context,
                            details.globalPosition,
                            item,
                          );
                          if (result != null) {
                            addTestController.updatestate(
                              secondaryType: result,
                            );
                          }
                        },
                        child: DropdownPayment(
                          title: addTestState.secondaryType.isEmpty
                              ? 'UPI'
                              : addTestState.secondaryType,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                Row(
                  children: [
                    Expanded(
                      child: _AmountField(
                        title: "Balance",
                        controller: TextEditingController(),
                        readOnly: true,
                        balance: addTestState.balanceAmount.toStringAsFixed(2),
                        isBalance: true,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,

                        onTapDown: (details) async {
                          // List<String> item = ['Pending'];
                          // final String? result = await showDropDown(
                          //   context,
                          //   details.globalPosition,
                          //   item,
                          // );
                          // if (result != null) {
                          //   addTestController.updatestate(primaryType: result);
                          // }
                          // ;
                        },
                        child: DropdownPayment(title: 'Pending'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorState.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () async {
                      final testMasterState1 = ref.read(addTestScreenProvider);
                      if (testMasterState1.secondaryType.isNotEmpty &&
                          testMasterState1.primaryType.isNotEmpty &&
                          testMasterState1.secondaryType ==
                              testMasterState1.primaryType) {
                        AppMessage.show(
                          context,
                          'Payment method cannot be same.',
                        );
                      } else {
                        await homeController.updatePatient(
                          index: index,

                          balance: testMasterState1.balanceAmount,
                          netAmt: testMasterState1.netAmount,
                          paidAmt: testMasterState1.amountPaid,
                          primaryPaid: testMasterState1.primaryPaid,
                          secondaryPaid: testMasterState1.secondaryPaid,
                          secondaryType: testMasterState1.secondaryType.isEmpty
                              ? 'UPI'
                              : addTestState.secondaryType,
                          primaryType: testMasterState1.primaryType.isEmpty
                              ? 'Cash'
                              : addTestState.primaryType,
                        );
                        context.pop();
                      }
                    },
                    child: const Text(
                      "Confirm",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String?> showDropDown(
    BuildContext context,
    Offset tapPosition,
    List<String> items,
  ) async {
    final screenSize = MediaQuery.of(context).size;

    final selected = await showMenu<String>(
      context: context,
      color: AppColors.appWhite,
      position: RelativeRect.fromLTRB(
        tapPosition.dx,
        tapPosition.dy,
        screenSize.width,
        screenSize.height - tapPosition.dy,
      ),
      items: items.map((item) {
        return PopupMenuItem<String>(value: item, child: Text(item));
      }).toList(),
      constraints: BoxConstraints(maxHeight: screenSize.height / 2),
    );

    return selected;
  }
}

class _AmountField extends ConsumerWidget {
  final String title;
  final TextEditingController controller;
  final bool readOnly;
  final bool isBalance;
  final String balance;
  final Function(String)? ontap;

  const _AmountField({
    required this.title,
    required this.controller,
    this.readOnly = false,
    this.isBalance = false,
    this.balance = '0',
    this.ontap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorState = ref.watch(colorProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: colorState.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            color: colorState.secondaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isBalance == true
                  ? Expanded(child: Center(child: Text(balance)))
                  : TextField(
                      controller: controller,
                      readOnly: readOnly,
                      onChanged: (value) {
                        if (ontap != null) {
                          ontap!(value);
                        }
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hint: Text(title),
                      ),
                    ),
            ],
          ),
        ),
      ],
    );
  }
}

class DropdownPayment extends ConsumerWidget {
  final String title;

  const DropdownPayment({super.key, required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorState = ref.watch(colorProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '',
          style: TextStyle(
            color: colorState.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            color: colorState.secondaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(title),
              Spacer(),
              InkWell(child: Icon(Icons.arrow_drop_down)),
            ],
          ),
        ),
      ],
    );
  }
}
