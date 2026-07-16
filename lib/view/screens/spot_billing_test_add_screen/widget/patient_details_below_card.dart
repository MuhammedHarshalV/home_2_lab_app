import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:icon_infoware/controller/add_test_screen_controller/add_test_screen_controller.dart';
import 'package:icon_infoware/controller/color_controller/color_controller.dart';
import 'package:icon_infoware/controller/home_screen_controller/home_screen_controller.dart';

import 'package:icon_infoware/core/errors/api_errors/api_errors.dart';

import 'package:icon_infoware/core/routes/app_route_names.dart';
import 'package:icon_infoware/core/services/network_services/connection_checking.dart';
import 'package:icon_infoware/core/themes/colors.dart';

import 'package:intl/intl.dart';

class PatientDetailsBelowCard extends ConsumerWidget {
  final int? index;
  const PatientDetailsBelowCard({super.key, this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final testAddState = ref.watch(addTestScreenProvider);
    final homeState = ref.watch(homeScreenProvider);
    final homeController = ref.read(homeScreenProvider.notifier);
    final colorState = ref.watch(colorProvider);
    final testAddController = ref.read(addTestScreenProvider.notifier);
    return Column(
      children: [
        Divider(color: Colors.grey, thickness: 2),
        Row(
          children: [
            Icon(Icons.account_balance_wallet_sharp, color: Colors.blueAccent),
            Text(
              'Bill Info :',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF37474F),
                fontWeight: FontWeight.bold, // Dark grey-blue
              ),
            ),
            Spacer(),
            Container(
              decoration: BoxDecoration(
                color: testAddState.balanceAmount == 0
                    ? Colors.green
                    : Colors.orange,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    testAddState.balanceAmount == 0
                        ? 'Complete'
                        : 'Payment Due',
                    style: TextStyle(
                      fontSize: 10,
                      color: AppColors.appWhite,
                      fontWeight: FontWeight.bold, // Dark grey-blue
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        Row(
          spacing: 5,
          children: [
            Column(
              children: [
                Text(
                  'Total Amount',
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xFF37474F), // Dark grey-blue
                  ),
                ),
                Text(
                  '₹ ${testAddState.netAmount}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF37474F),
                    fontWeight: FontWeight.bold, // Dark grey-blue
                  ),
                ),
              ],
            ),
            Divider(color: Colors.grey, thickness: 2),
            Column(
              children: [
                Text(
                  'Due Amount',
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xFF37474F), // Dark grey-blue
                  ),
                ),
                Text(
                  '₹ ${testAddState.balanceAmount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF37474F),
                    fontWeight: FontWeight.bold, // Dark grey-blue
                  ),
                ),
              ],
            ),

            Expanded(
              child: InkWell(
                onTap: testAddState.isSync != 'Yes'
                    ? () {
                        testAddController.storingAndFetchingDiscount();
                        if (index == null) {
                          int indexGet =
                              homeState.allBookingDetails.last.indexClick ?? 0;
                          context.pushNamed(
                            AppRouteNames.paymentCompletionScreen.name,
                            extra: indexGet,
                          );
                        } else {
                          context.pushNamed(
                            AppRouteNames.paymentCompletionScreen.name,
                            extra: index!,
                          );
                        }
                      }
                    : () {
                        AppMessage.show(context, 'Bill is already synced.');
                      },
                child: Container(
                  // width: double.infinity,
                  decoration: BoxDecoration(
                    color: colorState.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        'Collect Payment',
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.appWhite,
                          fontWeight: FontWeight.bold, // Dark grey-blue
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          spacing: 10,
          children: [
            Expanded(
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                focusColor: Colors.transparent,
                onTap: () {
                  context.pop();
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: colorState.secondaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Cancel visit',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: colorState.primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                focusColor: Colors.transparent,
                onTap: testAddState.isSync != 'Yes'
                    ? () async {
                        final bool isConnected =
                            await InternetChecker.hasConnection();

                        final int patientIndex =
                            index ??
                            (homeState.allBookingDetails.last.indexClick ?? 0);

                        if (testAddState
                            .testMasterListSelectedNewPrice
                            .isEmpty) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: AppColors.appWhite,
                                title: const Center(
                                  child: Text(
                                    'Alert',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                content: const Text(
                                  'Please add at least one test.',
                                ),
                              );
                            },
                          );
                          return;
                        }

                        bool syncing = false;

                        if (isConnected && testAddState.balanceAmount >= 0) {
                          syncing = await testAddController
                              .patientBillSyncingApi(
                                context: null,
                                patient: [
                                  homeState.allBookingDetails[patientIndex],
                                ],
                              );

                          log('Sync status : $syncing');
                        } else if (testAddState.balanceAmount < 0) {
                          AppMessage.show(
                            context,
                            'Balance amount should be zero or greater.',
                          );
                          await Future.delayed(Duration(seconds: 2));
                        }

                        final String time = DateFormat(
                          'hh:mm a',
                        ).format(DateTime.now());

                        final String date = DateFormat(
                          'dd-MMM-yyyy',
                        ).format(DateTime.now());

                        await homeController.updatePatient(
                          index: patientIndex,
                          isCompleted: 'Yes',
                          isSync: syncing ? 'Yes' : 'No',
                          timeToSave: time,
                          dateToSave: date,
                        );

                        if (!context.mounted) return;

                        if (index == null) {
                          context.pushReplacementNamed(
                            AppRouteNames.bottomNavScreen.name,
                          );
                        } else {
                          context.pop();
                        }
                      }
                    : () {
                        context.pushNamed(AppRouteNames.printBillScreen.name);
                      },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: colorState.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: testAddState.isSyncLoading == true
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 1.5,
                                color: AppColors.appWhite,
                              ),
                            ),
                          )
                        : Text(
                            testAddState.isSync != 'Yes'
                                ? 'Complete'
                                : 'Share bill',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.appWhite,
                            ),
                          ),
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
