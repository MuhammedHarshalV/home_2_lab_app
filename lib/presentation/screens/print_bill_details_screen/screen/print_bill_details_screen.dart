import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:icon_infoware/controller/add_test_screen_controller/add_test_screen_controller.dart';
import 'package:icon_infoware/controller/color_controller/color_controller.dart';
import 'package:icon_infoware/controller/patient_billing/patient_billing_controller.dart';
import 'package:icon_infoware/controller/print_controller/print_controller.dart';
import 'package:icon_infoware/core/constants/app_constants.dart';
import 'package:icon_infoware/core/errors/api_errors/api_errors.dart';

import 'package:icon_infoware/core/themes/colors.dart';
import 'package:icon_infoware/presentation/screens/print_bill_details_screen/widget/above_bill_card.dart';
import 'package:icon_infoware/presentation/screens/print_bill_details_screen/widget/below_info_card.dart';
import 'package:icon_infoware/presentation/screens/print_bill_details_screen/widget/bill_info_card.dart';
import 'package:icon_infoware/presentation/screens/print_bill_details_screen/widget/lab_info_card.dart';
import 'package:icon_infoware/presentation/screens/print_bill_details_screen/widget/share_bill.dart';
import 'package:icon_infoware/presentation/screens/print_bill_details_screen/widget/test_listing_card.dart';

import 'package:screenshot/screenshot.dart';

final ScreenshotController screenshotController = ScreenshotController();

class PrintBillDetailsScreen extends ConsumerWidget {
  final Color backgroundColor = const Color(0xFFF7F5F0); // Off-white/cream
  const PrintBillDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addTestState = ref.watch(addTestScreenProvider);
    final colorState = ref.watch(colorProvider);
    final printState = ref.watch(printProvider);
    final spotbillingState = ref.watch(patientBillingProvider);
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
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,

                        // margin: const EdgeInsets.symmetric(vertical: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            AboveBillCard(),
                            _buildDivider(),
                            LabInfoCard(isCloser: false),
                            _buildDivider(),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: _buildInfoRow(
                                'NAME',
                                ': ${spotbillingState.patientNameController.text}',
                                null,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: _buildInfoRow(
                                'AGE/SEX',
                                ': ${spotbillingState.ageController.text} Years/${spotbillingState.genderController.text}',
                                null,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: _buildInfoRow(
                                'PHONE',
                                ': ${spotbillingState.patientPhoneController.text}',
                                null,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: _buildInfoRow(
                                'EMAIL',
                                ': ${spotbillingState.patientEmailController.text}',
                                null,
                              ),
                            ),
                            TestTableWidget(),

                            _buildDivider(),
                            Column(
                              children: [
                                if (num.tryParse(
                                          addTestState
                                              .servicesnargeController
                                              .text,
                                        ) !=
                                        0 ||
                                    num.tryParse(
                                          addTestState
                                              .discountAmountController
                                              .text,
                                        ) !=
                                        0)
                                  BillingRowWidget(
                                    label: 'Gross Amount :',
                                    amount: addTestState.totalPrice.toString(),
                                    isLightBlue: false,
                                  ),
                                if (num.tryParse(
                                      addTestState.servicesnargeController.text,
                                    ) !=
                                    0)
                                  BillingRowWidget(
                                    label: 'Service Charge :',
                                    amount: addTestState
                                        .servicesnargeController
                                        .text,
                                    isLightBlue: false,
                                  ),
                                if (num.tryParse(
                                      addTestState
                                          .discountAmountController
                                          .text,
                                    ) !=
                                    0)
                                  BillingRowWidget(
                                    label: 'Discount Amount :',
                                    amount: addTestState
                                        .discountAmountController
                                        .text,
                                    isLightBlue: false,
                                  ),
                                BillingRowWidget(
                                  label: 'Net Amount :',
                                  amount: addTestState.netAmount.toString(),
                                  isLightBlue: false,
                                ),
                                BillingRowWidget(
                                  label: 'Received Amount :',
                                  amount: addTestState.amountPaid.toString(),
                                  isLightBlue: false,
                                ),
                                BillingRowWidget(
                                  label: 'Pending Amount :',
                                  amount: addTestState.balanceAmount.toString(),
                                  isLightBlue: true,
                                ),
                              ],
                            ),
                            // _buildBillingSummary(),
                            const SizedBox(height: 10),
                            _buildFooterNote(),
                            _buildDivider(),
                            BillFooterWidget(),
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
                            await ScreenshotUtils.shareBill(
                              controller: screenshotController,
                              description: AppConstants.emailContent.isEmpty
                                  ? null
                                  : AppConstants.emailContent,
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
                            Icons.email_outlined,
                            color: AppColors.appWhite,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
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

  Widget _buildInfoRow(String title, String value, Color? color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              title,
              style: TextStyle(
                color: color != null ? Colors.green : AppColors.appBlack,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: AppColors.appBlack,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterNote() {
    return const Center(
      child: Text(
        '*** Result also available through E-mail & Whatsapp ***',
        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(color: Colors.black, thickness: 1.5, height: 20);
  }
}
