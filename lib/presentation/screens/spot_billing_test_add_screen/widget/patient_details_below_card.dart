import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:icon_infoware/controller/add_test_screen_controller/add_test_screen_controller.dart';
import 'package:icon_infoware/controller/color_controller/color_controller.dart';
import 'package:icon_infoware/controller/home_screen_controller/home_screen_controller.dart';
import 'package:icon_infoware/controller/timer_controller/timer_controller.dart';
import 'package:icon_infoware/core/constants/app_constants.dart';
import 'package:icon_infoware/core/errors/api_errors/api_errors.dart';
import 'package:icon_infoware/core/routes/app_route_names.dart';
import 'package:icon_infoware/core/themes/colors.dart';
import 'package:icon_infoware/presentation/screens/payment_completion_screen/widget/discount_popup.dart';
import 'package:icon_infoware/presentation/screens/payment_completion_screen/widget/service_charge_popup.dart';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    final timerState = ref.watch(customTimerProvider);

    // Safely find the current booking.
    final bookings = homeState.allBookingDetails;

    final booking = index == null
        ? (bookings.isNotEmpty ? bookings.last : null)
        : bookings.where((e) => e.indexClick == index).isNotEmpty
        ? bookings.firstWhere((e) => e.indexClick == index)
        : null;

    // During navigation, booking data may not have loaded yet.
    if (booking == null) {
      return const SizedBox.shrink();
    }

    final int patientIndex = booking.indexClick ?? 0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Divider(color: Colors.grey, thickness: 2),

        Row(
          spacing: 3,
          children: [
            Icon(Icons.account_balance_wallet_sharp, color: Colors.blueAccent),
            Text(
              'Bill Info :',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF37474F),
                fontWeight: FontWeight.bold,
              ),
            ),

            Expanded(
              child: InkWell(
                onTap: () async {
                  await testAddController.storingAndFetchingDiscount();

                  if (!context.mounted) return;

                  showDialog(
                    context: context,
                    builder: (_) => DiscountDialog(index: patientIndex),
                  );
                },
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD97706),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      'Discount : ${booking.discAmt}',
                      style: TextStyle(
                        fontSize: 10,
                        color: AppColors.appWhite,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Expanded(
              child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => ServiceChangeDialog(index: patientIndex),
                  );
                },
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                    color: Color(0xFF2563EB),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      'Service Charge : ${booking.servChrge}',
                      style: TextStyle(
                        fontSize: 10,
                        color: AppColors.appWhite,
                        fontWeight: FontWeight.w500,
                      ),
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
                  style: TextStyle(fontSize: 10, color: Color(0xFF37474F)),
                ),
                Text(
                  '₹ ${testAddState.netAmount}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF37474F),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            Spacer(),

            Column(
              children: [
                Text(
                  'Due Amount',
                  style: TextStyle(fontSize: 10, color: Color(0xFF37474F)),
                ),
                Text(
                  '₹ ${testAddState.balanceAmount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF37474F),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
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
                  if (context.canPop()) {
                    context.pop();
                    ref.invalidate(addTestScreenProvider);
                  } else {
                    context.goNamed(AppRouteNames.bottomNavScreen.name);
                    ref.invalidate(addTestScreenProvider);
                  }
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
                onTap: () async {
                  if (timerState.isRunning == false &&
                      testAddState.isSync != 'Yes') {
                    AppMessage.show(
                      context,
                      "You must press the Start button first.",
                    );
                    return;
                  }

                  if (testAddState.isSync != 'Yes') {
                    if (testAddState.testMasterListSelectedNewPrice.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: AppColors.appWhite,
                            title: const Center(
                              child: Text(
                                'Alert',
                                style: TextStyle(fontWeight: FontWeight.bold),
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

                    final String time = DateFormat(
                      'hh:mm a',
                    ).format(DateTime.now());

                    final String date = DateFormat(
                      'dd-MMM-yyyy',
                    ).format(DateTime.now());

                    await homeController.updatePatient(
                      index: patientIndex,
                      isCompleted: 'Yes',
                      isSync: 'No',
                      timeToSave: time,
                      dateToSave: date,
                      invNo:
                          '${AppConstants.devCode}-${DateFormat('ddMMyy').format(DateTime.now())}-${ref.read(addTestScreenProvider).syncId + 1}',
                    );

                    final prefs = await SharedPreferences.getInstance();

                    final newSyncId =
                        ref.read(addTestScreenProvider).syncId + 1;

                    await prefs.setInt('syncId', newSyncId);

                    testAddController.updatestate(syncId: newSyncId);

                    if (!context.mounted) return;

                    if (index == null) {
                      context.pushReplacementNamed(
                        AppRouteNames.bottomNavScreen.name,
                      );
                      ref.invalidate(addTestScreenProvider);
                    } else {
                      context.pop();
                      ref.invalidate(addTestScreenProvider);
                    }
                  } else {
                    context.pushNamed(AppRouteNames.printBillScreen.name);
                  }
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: colorState.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      testAddState.isSync != 'Yes' ? 'Save' : 'Share bill',
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
