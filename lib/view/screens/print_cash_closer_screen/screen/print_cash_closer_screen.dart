import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:icon_infoware/controller/add_test_screen_controller/add_test_screen_controller.dart';
import 'package:icon_infoware/controller/color_controller/color_controller.dart';
import 'package:icon_infoware/controller/home_screen_controller/home_screen_controller.dart';
import 'package:icon_infoware/controller/print_controller/print_controller.dart';
import 'package:icon_infoware/controller/print_controller/print_state.dart';
import 'package:icon_infoware/core/constants/app_constants.dart';
import 'package:icon_infoware/core/errors/api_errors/api_errors.dart';

import 'package:icon_infoware/core/themes/colors.dart';
import 'package:icon_infoware/models/patient_bill_syncing_model/patient_bill_syncing_model.dart';
import 'package:icon_infoware/view/screens/print_bill_details_screen/widget/above_bill_card.dart';

import 'package:icon_infoware/view/screens/print_bill_details_screen/widget/bill_info_card.dart';
import 'package:icon_infoware/view/screens/print_bill_details_screen/widget/lab_info_card.dart';
import 'package:icon_infoware/view/screens/print_bill_details_screen/widget/share_bill.dart';
import 'package:intl/intl.dart';

import 'package:screenshot/screenshot.dart';

final ScreenshotController screenshotController = ScreenshotController();

class PrintCashCloserScreen extends ConsumerWidget {
  final Color backgroundColor = const Color(0xFFF7F5F0); // Off-white/cream
  final Color darkBlue = const Color(0xFF163E61);
  const PrintCashCloserScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorState = ref.watch(colorProvider);
    final homeState = ref.watch(homeScreenProvider);
    final printState = ref.watch(printProvider);

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
                  child: Screenshot(
                    controller: screenshotController,
                    child: Container(
                      width: printState.paperType == PaperType.mm58
                          ? 384
                          : printState.paperType == PaperType.mm72
                          ? 512
                          : 576,
                      // margin: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(color: backgroundColor),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          AboveBillCard(),
                          _buildDivider(),
                          LabInfoCard(isCloser: true),
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
                                                  patient.isCompleted == 'Yes',
                                            )
                                            .toList();

                                    return BillingRowWidget(
                                      label:
                                          '${AppConstants.devCode}-${DateFormat('ddMMyy').format(DateTime.now())}-${newList[index].invNo}',

                                      amount: newList[index].netAmt.toString(),
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

                                  if ((item.primaryType ?? '').toLowerCase() ==
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

                                  if ((item.primaryType ?? '').toLowerCase() ==
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

                                  if ((item.primaryType ?? '').toLowerCase() ==
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
                                fontSize: 20,
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
                              description: AppConstants.whatappContent.isEmpty
                                  ? null
                                  : AppConstants.whatappContent,
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
                            // await ScreenshotUtils.shareBill(
                            //   controller: screenshotController,
                            // );
                            final printer = printState.selectedPrinter;

                            if (printer == null) {
                              AppMessage.show(
                                context,
                                "Please select any printer",
                              );
                              return;
                            } else {
                              await ref
                                  .read(printProvider.notifier)
                                  .printWidget(screenshotController);
                            }
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
                          child: printState.isLoading == true
                              ? SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: AppColors.appWhite,
                                    ),
                                  ),
                                )
                              : FaIcon(
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
    return Divider(color: Colors.black, thickness: 1.5, height: 20);
  }
}
