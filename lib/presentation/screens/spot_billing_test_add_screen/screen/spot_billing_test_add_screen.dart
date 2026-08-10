import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:icon_infoware/controller/add_test_screen_controller/add_test_screen_controller.dart';
import 'package:icon_infoware/controller/bottom_nav_screen/bottom_nav_controller.dart';
import 'package:icon_infoware/controller/color_controller/color_controller.dart';
import 'package:icon_infoware/controller/home_screen_controller/home_screen_controller.dart';
import 'package:icon_infoware/controller/timer_controller/timer_controller.dart';

import 'package:icon_infoware/core/errors/api_errors/api_errors.dart';
import 'package:icon_infoware/core/routes/app_route_names.dart';
import 'package:icon_infoware/core/themes/colors.dart';

import 'package:icon_infoware/presentation/screens/spot_billing_test_add_screen/widget/add_new_test_popup.dart';
import 'package:icon_infoware/presentation/screens/spot_billing_test_add_screen/widget/patient_details_below_card.dart';
import 'package:icon_infoware/presentation/screens/spot_billing_test_add_screen/widget/patient_details_card.dart';
import 'package:icon_infoware/presentation/widgets/common_appbar.dart';

class SpotBillingTestAddScreen extends ConsumerWidget {
  final int? hiveIndex;
  const SpotBillingTestAddScreen({super.key, this.hiveIndex});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final testMasterState = ref.watch(addTestScreenProvider);
    final testMasterController = ref.read(addTestScreenProvider.notifier);
    final homeState = ref.watch(homeScreenProvider);
    final homeController = ref.read(homeScreenProvider.notifier);
    final colorState = ref.watch(colorProvider);
    final timerState = ref.watch(customTimerProvider);

    final bottomNavController = ref.read(bottomNavProvider.notifier);

    // log('checked list :${testMasterState.checkedTestes.toString()}');
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light, // icons = white
        statusBarBrightness: Brightness.dark, // for iOS
      ),
      child: SafeArea(
        top: false,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.appWhite,
          appBar: CommonAppbar(
            onBack: () {
              bottomNavController.setIndex(0);
              context.pushReplacementNamed(AppRouteNames.bottomNavScreen.name);
              ref.invalidate(addTestScreenProvider);
            },
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                PatientDetailsCard(index: hiveIndex),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(color: colorState.secondaryColor),
                  child: Table(
                    columnWidths: const {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(4),
                      2: FlexColumnWidth(3),
                    },
                    children: [
                      TableRow(
                        decoration: BoxDecoration(
                          color: colorState.primaryColor,
                        ),
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "SlNo",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: AppColors.appWhite,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "Test Name",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: AppColors.appWhite,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "Amount",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: AppColors.appWhite,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: SizedBox(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          testMasterState
                                  .testMasterListSelectedNewPrice
                                  .isNotEmpty
                              ? Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.appWhite,
                                  ),
                                  child: Table(
                                    border: TableBorder.all(
                                      color: const Color.fromARGB(
                                        255,
                                        105,
                                        103,
                                        103,
                                      ),
                                      width: 1,
                                    ),
                                    columnWidths: const {
                                      0: FlexColumnWidth(1),
                                      1: FlexColumnWidth(4),
                                      2: FlexColumnWidth(2),
                                      3: FlexColumnWidth(1),
                                    },
                                    children: [
                                      ...List.generate(
                                        testMasterState
                                            .testMasterListSelectedNewPrice
                                            .length,
                                        (index) {
                                          final item = testMasterState
                                              .testMasterListSelectedNewPrice[index];

                                          return TableRow(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 10,
                                                  horizontal: 5,
                                                ),
                                                child: Text(
                                                  "${index + 1}.",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),

                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 10,
                                                  horizontal: 5,
                                                ),
                                                child: Text(
                                                  item.testName ?? '',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),

                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 10,
                                                  horizontal: 5,
                                                ),
                                                child: Text(
                                                  "${item.testRate}",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),

                                              Padding(
                                                padding: const EdgeInsets.all(
                                                  10,
                                                ),
                                                child: InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    if (timerState.isRunning ==
                                                            false &&
                                                        testMasterState
                                                                .isSync !=
                                                            'Yes') {
                                                      AppMessage.show(
                                                        context,
                                                        "You must press the Start button first.",
                                                      );
                                                      return;
                                                    }
                                                    if (testMasterState
                                                            .isSync !=
                                                        'Yes') {
                                                      final testMasterController2 =
                                                          ref.read(
                                                            addTestScreenProvider
                                                                .notifier,
                                                          );
                                                      await testMasterController2
                                                          .removeTestsToTemperary(
                                                            test: testMasterState
                                                                .testMasterListSelectedNewPrice[index],
                                                          );
                                                      final uniqueIds =
                                                          <dynamic>{};
                                                      final testMasterState2 =
                                                          ref.read(
                                                            addTestScreenProvider,
                                                          );

                                                      final testList =
                                                          testMasterState2
                                                              .testMasterListSelected
                                                              .where(
                                                                (e) => uniqueIds
                                                                    .add(
                                                                      e.testKey,
                                                                    ),
                                                              )
                                                              .map(
                                                                (e) => {
                                                                  'TestId':
                                                                      e.testKey,
                                                                },
                                                              )
                                                              .toList();
                                                      log(
                                                        'selected lists : ${testList.toString()} \n length : ${testList.length}',
                                                      );
                                                      final totalAmount =
                                                          testMasterState2
                                                              .testMasterListSelected
                                                              .fold<num>(
                                                                0,
                                                                (sum, test) =>
                                                                    sum +
                                                                    (test.testRate ??
                                                                        0),
                                                              );
                                                      testMasterController.updatestate(
                                                        testMasterListSelectedNewPrice:
                                                            testMasterState2
                                                                .testMasterListSelected,
                                                        grosAmount: totalAmount,
                                                      );
                                                      await testMasterController
                                                          .updateNetBalanceAmounts();

                                                      int indexget =
                                                          homeState
                                                              .allBookingDetails
                                                              .last
                                                              .indexClick ??
                                                          0;
                                                      await homeController.updatePatient(
                                                        index: hiveIndex == null
                                                            ? indexget
                                                            : hiveIndex!,
                                                        testlists: testList,
                                                        discAmt:
                                                            num.tryParse(
                                                              testMasterState2
                                                                  .discountAmountController
                                                                  .text,
                                                            ) ??
                                                            0,
                                                        balance:
                                                            testMasterState2
                                                                .balanceAmount,
                                                        netAmt: testMasterState2
                                                            .netAmount,
                                                        paidAmt:
                                                            testMasterState2
                                                                .amountPaid,
                                                        grossAmt:
                                                            testMasterState2
                                                                .totalPrice,
                                                        servChrge:
                                                            num.tryParse(
                                                              testMasterState2
                                                                  .servicesnargeController
                                                                  .text,
                                                            ) ??
                                                            0,
                                                      );
                                                    } else {
                                                      AppMessage.show(
                                                        context,
                                                        'Bill is already synced.',
                                                      );
                                                    }
                                                  },

                                                  child: Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                    size: 25,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              : Center(child: Text("No tests found!")),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Total Tests: ${testMasterState.testMasterListSelectedNewPrice.length}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  onTap: () {
                    if (timerState.isRunning == false &&
                        testMasterState.isSync != 'Yes') {
                      AppMessage.show(
                        context,
                        "You must press the Start button first.",
                      );
                      return;
                    }
                    if (testMasterState.isSync != 'Yes') {
                      int indexget =
                          homeState.allBookingDetails.last.indexClick ?? 0;
                      if (hiveIndex == null) {
                        showDialog(
                          context: context,
                          builder: (context) =>
                              AddNewTestPopUp(index: indexget),
                        );
                        log('index not work');
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) =>
                              AddNewTestPopUp(index: hiveIndex!),
                        );
                        log('index work');
                      }
                    } else {
                      AppMessage.show(context, 'Bill is already synced.');
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: colorState.secondaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          '+ Add More Tests',
                          style: TextStyle(
                            color: colorState.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                PatientDetailsBelowCard(index: hiveIndex),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
