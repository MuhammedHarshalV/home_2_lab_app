import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:icon_infoware/controller/add_test_screen_controller/add_test_screen_controller.dart';
import 'package:icon_infoware/controller/home_screen_controller/home_screen_controller.dart';

import 'package:icon_infoware/core/themes/colors.dart';
import 'package:icon_infoware/view/screens/spot_billing_test_add_screen/widget/test_add_search_value_container.dart';
import 'package:icon_infoware/view/widgets/common_tap_possition_dropDown.dart';

class AddNewTestPopUp extends ConsumerWidget {
  final int index;
  const AddNewTestPopUp({super.key, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final testMasterState = ref.watch(addTestScreenProvider);
    final testMasterController = ref.read(addTestScreenProvider.notifier);
    final homestate = ref.watch(homeScreenProvider);

    final homeController = ref.read(homeScreenProvider.notifier);

    return Dialog(
      backgroundColor:
          Colors.transparent, // Transparent to allow custom shadow/shape
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.appWhite,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 32,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Hugs the content tightly
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Header Section ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Add New Test",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1A1F36), // Dark premium text
                    letterSpacing: 0.3,
                  ),
                ),
                InkWell(
                  onTap: () async {
                    final updatedPatient = ref
                        .read(homeScreenProvider)
                        .patientBookingList[index];

                    await testMasterController.getTestsFromHive(updatedPatient);

                    context.pop();
                  },
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close_rounded,
                      size: 20,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            // InkWell(
            //   onTapDown: (details) {
            //     showCommonDropdown(
            //       context: context,
            //       tapPosition: details.globalPosition,
            //       items: ['Manager', 'HR', 'Team Lead', 'Senior Developer'],
            //       onSelected: (value) {
            //         print(value);
            //       },
            //     );
            //   },
            //   child: Text(
            //     'show selected tests',
            //     style: TextStyle(color: Colors.blue),
            //   ),
            // ),
            SizedBox(height: 5),

            // --- Content / Search Section ---
            Flexible(
              child: SingleChildScrollView(
                child: TestAddSearchValueContainer(
                  textController: testMasterState.searchController,
                ),
              ),
            ),

            const SizedBox(height: 10),

            // --- Action Buttons ---
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () async {
                      testMasterState.searchController.clear();
                      final updatedPatient = ref
                          .read(homeScreenProvider)
                          .patientBookingList[index];

                      await testMasterController.getTestsFromHive(
                        updatedPatient,
                      );
                      context.pop();
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.appPrimaryColorLight
                          .withOpacity(0.5),
                      foregroundColor: AppColors.appPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      elevation: 0,
                    ),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      final uniqueIds = <dynamic>{};

                      final testList = testMasterState.testMasterListSelected
                          .where((e) => uniqueIds.add(e.testKey))
                          .map((e) => {'TestId': e.testKey})
                          .toList();
                      log(
                        'selected lists : ${testList.toString()} \n length : ${testList.length}',
                      );
                      final totalAmount = testMasterState.testMasterListSelected
                          .fold<num>(
                            0,
                            (sum, test) => sum + (test.testRate ?? 0),
                          );

                      testMasterController.updatestate(
                        testMasterListSelectedNewPrice:
                            testMasterState.testMasterListSelected,
                        grosAmount: totalAmount,
                      );

                      await testMasterController.updateNetBalanceAmounts();
                      final testMasterState1 = ref.watch(addTestScreenProvider);
                      await homeController.updatePatient(
                        index: index,
                        testlists: testList,
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

                      if (context.mounted) {
                        context.pop();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.appPrimaryColor,
                      foregroundColor: AppColors.appWhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      elevation: 0,
                    ),
                    child: const Text(
                      "Add Test",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showCommonDropdown({
    required BuildContext context,
    required Offset tapPosition,
    required List<String> items,
    required Function(String) onSelected,
  }) async {
    final screenSize = MediaQuery.of(context).size;

    final selected = await showMenu<String>(
      context: context,
      color: AppColors.appWhite,
      constraints: BoxConstraints(
        minWidth: screenSize.width,
        maxHeight: screenSize.height / 2,
      ),
      position: RelativeRect.fromLTRB(
        0,
        tapPosition.dy,
        0,
        screenSize.height - tapPosition.dy,
      ),
      items: items.map((item) {
        return PopupMenuItem<String>(value: item, child: Text(item));
      }).toList(),
    );

    if (selected != null) {
      onSelected(selected);
    }
  }
}
