import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:icon_infoware/controller/color_controller/color_controller.dart';
import 'package:icon_infoware/controller/home_screen_controller/home_screen_controller.dart';

import 'package:icon_infoware/controller/payment_controller/payment_controller.dart';
import 'package:icon_infoware/core/constants/app_constants.dart';

import 'package:icon_infoware/core/themes/colors.dart';
import 'package:icon_infoware/presentation/screens/payment_completion_screen/widget/above_container_card.dart';
import 'package:icon_infoware/presentation/screens/payment_completion_screen/widget/billing_details_card.dart';
import 'package:icon_infoware/presentation/screens/payment_completion_screen/widget/qr_code_payment.dart';
import 'package:icon_infoware/presentation/screens/payment_completion_screen/widget/split_payment_card.dart';
import 'package:icon_infoware/presentation/widgets/common_appbar.dart';
import 'package:intl/intl.dart';

class PaymentCompletionScreen extends ConsumerWidget {
  const PaymentCompletionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paymentController = ref.read(paymentScreenProvider.notifier);
    final homeController = ref.read(homeScreenProvider.notifier);
    final paymentState = ref.watch(paymentScreenProvider);
    final colorState = ref.watch(colorProvider);
    if (paymentState.patientList.isEmpty) {
      return const Scaffold(body: Center(child: Text('No patients selected')));
    }
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: colorState.appbarColor,
        statusBarIconBrightness: Brightness.light, // icons = white
        statusBarBrightness: Brightness.dark, // for iOS
      ),
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: AppColors.appWhite,
          appBar: CommonAppbar(),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                //  Header Info Card
                // _HeaderInfoCard(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    color: colorState.secondaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      AboveContainerCard(
                        icon: Icons.account_balance_wallet_outlined,
                        label: 'Paying with',
                        value: paymentState.patientList.length == 1
                            ? (paymentState.patientList.first.patName ?? '')
                            : "${paymentState.patientList.length} Patients",
                        color: colorState.primaryColor,
                      ),
                      Container(
                        height: 50,
                        width: 0.5,
                        color: colorState.primaryColor,
                      ),
                      AboveContainerCard(
                        icon: Icons.calendar_today_outlined,
                        label: 'Paying Date',
                        value: DateFormat('MMM d, yyyy').format(DateTime.now()),
                        color: colorState.primaryColor,
                      ),
                      Container(
                        height: 50,
                        width: 0.5,
                        color: colorState.primaryColor,
                      ),
                      AboveContainerCard(
                        color: colorState.primaryColor,
                        icon: Icons.qr_code_outlined,
                        label: 'Paying No',
                        value: AppConstants.devCode,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),

                // Dashed Divider
                _DashedDivider(),
                SizedBox(height: 16),

                // Bill Details Card
                BillDetailsCard(),
                SizedBox(height: 16),

                //  Total Amount Card
                TotalAmountCard(
                  index: 1,
                  secondColor: colorState.secondaryColor,
                  primaryColor: colorState.primaryColor,
                ),
                SizedBox(height: 16),

                //  Dashed Divider
                _DashedDivider(),
                SizedBox(height: 16),

                //  Payment Option (QR)
                PaymentOptionCard(),
                SizedBox(height: 24),

                //  Confirm Button
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () async {
                      bool isSync = await paymentController.splitPayments();

                      if (isSync) {
                        final updatedPatients = ref
                            .read(paymentScreenProvider)
                            .patientList;

                        final String time = DateFormat(
                          'hh:mm a',
                        ).format(DateTime.now());
                        final String date = DateFormat(
                          'dd-MMM-yyyy',
                        ).format(DateTime.now());

                        for (final patient in updatedPatients) {
                          await homeController.updatePatient(
                            index: patient.indexClick!,
                            isCompleted: 'Yes',
                            isSync: 'Yes',
                            timeToSave: time,
                            dateToSave: date,

                            // Payment details
                            primaryPaid: patient.primaryPaid,
                            secondaryPaid: patient.secondaryPaid,
                            primaryType: patient.primaryType,
                            secondaryType: patient.secondaryType,
                            upiReferenceId: patient.upiReferenceId,
                            paidAmt: patient.paidAmt,
                            balance: patient.balance,
                          );
                        }
                      }

                      paymentController.clearPaymentState();
                      context.pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorState.primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 0,
                    ),
                    child: paymentState.isPaymentCompletion
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: AppColors.appWhite,
                            ),
                          )
                        : Text(
                            'Confirm Payment',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.3,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DashedDivider extends ConsumerWidget {
  const _DashedDivider();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorState = ref.watch(colorProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        final dashCount = (constraints.maxWidth / 8).floor();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (_) {
            return Container(
              width: 4,
              height: 1.5,
              color: colorState.primaryColor,
            );
          }),
        );
      },
    );
  }
}
