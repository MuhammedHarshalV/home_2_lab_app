import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:icon_infoware/controller/add_test_screen_controller/add_test_screen_controller.dart';
import 'package:icon_infoware/controller/home_screen_controller/home_screen_controller.dart';
import 'package:icon_infoware/controller/home_screen_controller/home_screen_state.dart';
import 'package:icon_infoware/core/errors/api_errors/api_errors.dart';

import 'package:icon_infoware/core/routes/app_route_names.dart';
import 'package:icon_infoware/core/services/network_services/connection_checking.dart';
import 'package:icon_infoware/core/themes/colors.dart';
import 'package:icon_infoware/view/screens/payment_completion_screen/screen/payment_completion_screen.dart';
import 'package:intl/intl.dart';

class PatientDetailsBelowCard extends ConsumerWidget {
  final int? index;
  const PatientDetailsBelowCard({super.key, this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final testAddState = ref.watch(addTestScreenProvider);
    final homeState = ref.watch(homeScreenProvider);
    final homeController = ref.read(homeScreenProvider.notifier);

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
                  '₹ ${testAddState.balanceAmount}',
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
                    color: AppColors.appPrimaryColor,
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
                onTap: testAddState.isSync != 'Yes'
                    ? () async {
                        if (index == null) {
                          int indexGet =
                              homeState.allBookingDetails.last.indexClick ?? 0;
                          await homeController.deletePatient(indexGet);
                          context.pop();
                        } else {
                          await homeController.deletePatient(index!);
                          context.pop();
                        }
                      }
                    : () {
                        AppMessage.show(context, 'Bill is already synced.');
                      },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.appPrimaryColorLight,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Cancel visit',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.appPrimaryColor,
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
                        if (index == null) {
                          int indexGet =
                              homeState.allBookingDetails.last.indexClick ?? 0;
                          if (testAddState
                              .testMasterListSelectedNewPrice
                              .isNotEmpty) {
                            bool syncing = false;
                            if (isConnected) {
                              final bool synced = await testAddController
                                  .patientBillSyncingApi(
                                    homeState.allBookingDetails[indexGet],
                                  );
                              syncing = synced;
                              log('sync is $syncing');
                            }
                            final String time = DateFormat(
                              'hh:mm a',
                            ).format(DateTime.now());
                            final String date = DateFormat(
                              'dd-MMM-yyyy',
                            ).format(DateTime.now());
                            await homeController.updatePatient(
                              index: indexGet,
                              isCompleted: 'Yes',
                              isSync: syncing == true ? 'Yes' : 'No',
                              timeToSave: time,
                              dateToSave: date,
                            );
                            context.pushReplacementNamed(
                              AppRouteNames.bottomNavScreen.name,
                            );
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  backgroundColor: AppColors.appWhite,
                                  title: Center(
                                    child: Text(
                                      'Alert',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  content: Text(
                                    'Please add at least one test.',
                                  ),
                                );
                              },
                            );
                          }
                        } else {
                          if (testAddState
                              .testMasterListSelectedNewPrice
                              .isNotEmpty) {
                            bool syncing = false;
                            if (isConnected) {
                              final bool synced = await testAddController
                                  .patientBillSyncingApi(
                                    homeState.allBookingDetails[index!],
                                  );
                              syncing = synced;
                              log('sync is $syncing');
                            }
                            final String time = DateFormat(
                              'hh:mm a',
                            ).format(DateTime.now());
                            final String date = DateFormat(
                              'dd-MMM-yyyy',
                            ).format(DateTime.now());

                            await homeController.updatePatient(
                              index: index!,
                              isCompleted: 'Yes',
                              isSync: syncing == true ? 'Yes' : 'No',
                              timeToSave: time,
                              dateToSave: date,
                            );
                            context.pop();
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  backgroundColor: AppColors.appWhite,
                                  title: Center(
                                    child: Text(
                                      'Alert',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  content: Text(
                                    'Please add at least one test.',
                                  ),
                                );
                              },
                            );
                          }
                        }
                      }
                    : () {
                        context.pushNamed(AppRouteNames.printBillScreen.name);
                      },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.appPrimaryColor,
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
