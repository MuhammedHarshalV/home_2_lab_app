import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:icon_infoware/controller/color_controller/color_controller.dart';
import 'package:icon_infoware/controller/patient_billing/patient_billing_controller.dart';
import 'package:icon_infoware/core/constants/app_constants.dart';
import 'package:icon_infoware/core/routes/app_route_names.dart';
import 'package:icon_infoware/core/themes/colors.dart';
import 'package:icon_infoware/presentation/screens/payment_completion_screen/widget/above_container_card.dart';
import 'package:icon_infoware/presentation/screens/payment_completion_screen/widget/billing_details_card.dart';
import 'package:icon_infoware/presentation/screens/payment_completion_screen/widget/qr_code_payment.dart';
import 'package:icon_infoware/presentation/screens/payment_completion_screen/widget/split_payment_card.dart';
import 'package:intl/intl.dart';

class PaymentCompletionScreen extends ConsumerWidget {
  final int index;
  const PaymentCompletionScreen({super.key, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patientBillingstate = ref.watch(patientBillingProvider);
    final colorState = ref.watch(colorProvider);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: AppColors.appWhite,
        statusBarIconBrightness: Brightness.light, // icons = white
        statusBarBrightness: Brightness.dark, // for iOS
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.appWhite,
          appBar: AppBar(
            backgroundColor: AppColors.appWhite,

            toolbarHeight: 100,
            leading: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                focusColor: Colors.transparent,
                onTap: () {
                  context.pop();
                },
                child: CircleAvatar(
                  backgroundColor: colorState.primaryColor.withValues(
                    alpha: 0.2,
                  ),
                  child: Icon(Icons.arrow_back, color: colorState.primaryColor),
                ),
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Image.file(
                    width: MediaQuery.of(context).size.width / 1.5,
                    fit: BoxFit.fill,
                    File(AppConstants.base64Image),
                  ),
                ),
              ],
            ),
          ),
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
                        value: patientBillingstate.patientNameController.text,
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
                BillDetailsCard(index: index),
                SizedBox(height: 16),

                //  Total Amount Card
                TotalAmountCard(
                  index: index,
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
                    onPressed: () {
                      context.pushNamed(AppRouteNames.printBillScreen.name);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorState.primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
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
