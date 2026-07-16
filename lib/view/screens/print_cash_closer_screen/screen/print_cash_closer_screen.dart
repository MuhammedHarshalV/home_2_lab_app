import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:icon_infoware/controller/add_test_screen_controller/add_test_screen_controller.dart';
import 'package:icon_infoware/controller/color_controller/color_controller.dart';
import 'package:icon_infoware/controller/home_screen_controller/home_screen_controller.dart';
import 'package:icon_infoware/core/constants/app_constants.dart';

import 'package:icon_infoware/core/themes/colors.dart';
import 'package:icon_infoware/models/patient_bill_syncing_model/patient_bill_syncing_model.dart';
import 'package:icon_infoware/view/screens/print_bill_details_screen/widget/above_bill_card.dart';
import 'package:icon_infoware/view/screens/print_bill_details_screen/widget/below_info_card.dart';
import 'package:icon_infoware/view/screens/print_bill_details_screen/widget/bill_info_card.dart';
import 'package:icon_infoware/view/screens/print_bill_details_screen/widget/lab_info_card.dart';
import 'package:icon_infoware/view/screens/print_bill_details_screen/widget/share_bill.dart';

import 'package:screenshot/screenshot.dart';

final ScreenshotController screenshotController = ScreenshotController();

class PrintCashCloserScreen extends ConsumerWidget {
  final Color backgroundColor = const Color(0xFFF7F5F0); // Off-white/cream
  final Color darkBlue = const Color(0xFF163E61);
  const PrintCashCloserScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addTestState = ref.watch(addTestScreenProvider);
    final colorState = ref.watch(colorProvider);
    final homeState = ref.watch(homeScreenProvider);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: AppColors.appWhite,
        statusBarIconBrightness: Brightness.light, // icons = white
        statusBarBrightness: Brightness.dark, // for iOS
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.appWhite,
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    bottom: 10,
                  ),
                  child: Center(
                    child: Screenshot(
                      controller: screenshotController,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        // margin: const EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(color: backgroundColor),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            AboveBillCard(),
                            _buildDivider(),
                            LabInfoCard(),
                            _buildDivider(),
                            Center(
                              child: Text(
                                'Cash closing',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            _buildDivider(),
                            Column(
                              children: [
                                BillingRowWidget(
                                  label: 'Invoice Number',
                                  amount: 'Amount',
                                  isLightBlue: false,
                                ),
                                Column(
                                  children: List.generate(
                                    (homeState.allBookingDetails
                                            .where(
                                              (patient) =>
                                                  patient.isCompleted == 'Yes',
                                            )
                                            .toList())
                                        .length,
                                    (index) {
                                      final List<PatientHiveModel> newList =
                                          homeState.allBookingDetails
                                              .where(
                                                (patient) =>
                                                    patient.isCompleted ==
                                                    'Yes',
                                              )
                                              .toList();

                                      return BillingRowWidget(
                                        label:
                                            ((newList[index].indexClick ?? 0) +
                                                    1)
                                                .toString(),
                                        amount: newList[index].netAmt
                                            .toString(),
                                        isLightBlue: false,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            // _buildBillingSummary(),
                            const SizedBox(height: 5),

                            _buildDivider(),
                            BillingRowWidget(
                              label: 'Total Amount',
                              amount: homeState.allBookingDetails
                                  .where(
                                    (patient) => patient.isCompleted == 'Yes',
                                  )
                                  .fold<num>(
                                    0,
                                    (sum, item) => sum + (item.netAmt ?? 0),
                                  )
                                  .toStringAsFixed(2),
                              isLightBlue: false,
                            ),
                            BillingRowWidget(
                              label: 'Cash Amount',
                              amount: homeState.allBookingDetails
                                  .where(
                                    (patient) => patient.isCompleted == 'Yes',
                                  )
                                  .fold<num>(0, (sum, item) {
                                    num total = sum;

                                    if ((item.primaryType ?? '')
                                            .toLowerCase() ==
                                        'cash') {
                                      total += item.primaryPaid ?? 0;
                                    }

                                    if ((item.secondaryType ?? '')
                                            .toLowerCase() ==
                                        'cash') {
                                      total += item.secondaryPaid ?? 0;
                                    }

                                    return total;
                                  })
                                  .toStringAsFixed(2),
                              isLightBlue: false,
                            ),
                            BillingRowWidget(
                              label: 'Card Amount',
                              amount: homeState.allBookingDetails
                                  .where(
                                    (patient) => patient.isCompleted == 'Yes',
                                  )
                                  .fold<num>(0, (sum, item) {
                                    num total = sum;

                                    if ((item.primaryType ?? '')
                                            .toLowerCase() ==
                                        'card') {
                                      total += item.primaryPaid ?? 0;
                                    }

                                    if ((item.secondaryType ?? '')
                                            .toLowerCase() ==
                                        'card') {
                                      total += item.secondaryPaid ?? 0;
                                    }

                                    return total;
                                  })
                                  .toStringAsFixed(2),
                              isLightBlue: false,
                            ),
                            BillingRowWidget(
                              label: 'UPI Amount',
                              amount: homeState.allBookingDetails
                                  .where(
                                    (patient) => patient.isCompleted == 'Yes',
                                  )
                                  .fold<num>(0, (sum, item) {
                                    num total = sum;

                                    if ((item.primaryType ?? '')
                                            .toLowerCase() ==
                                        'upi') {
                                      total += item.primaryPaid ?? 0;
                                    }

                                    if ((item.secondaryType ?? '')
                                            .toLowerCase() ==
                                        'upi') {
                                      total += item.secondaryPaid ?? 0;
                                    }

                                    return total;
                                  })
                                  .toStringAsFixed(2),
                              isLightBlue: false,
                            ),
                            BillingRowWidget(
                              label: 'Pending Amount',
                              amount: homeState.allBookingDetails
                                  .where(
                                    (patient) => patient.isCompleted == 'Yes',
                                  )
                                  .fold<num>(
                                    0,
                                    (sum, item) => sum + (item.balance ?? 0),
                                  )
                                  .toStringAsFixed(2),
                              isLightBlue: true,
                            ),
                            Center(
                              child: Text(
                                AppConstants.tagLine,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Container(height: 15, color: darkBlue),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Bottom Action Bar
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            await ScreenshotUtils.shareBill(
                              controller: screenshotController,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorState.primaryColor,
                            foregroundColor: Colors.white,
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: Icon(
                            Icons.share_outlined,
                            color: AppColors.appWhite,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            await ScreenshotUtils.shareBill(
                              controller: screenshotController,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorState.primaryColor,
                            foregroundColor: Colors.white,
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: const FaIcon(
                            FontAwesomeIcons.whatsapp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            await ScreenshotUtils.shareBill(
                              controller: screenshotController,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorState.primaryColor,
                            foregroundColor: Colors.white,
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: const FaIcon(
                            FontAwesomeIcons.print,
                            color: AppColors.appWhite,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(color: Colors.grey.shade400, thickness: 1.5, height: 20);
  }
}
