import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:icon_infoware/controller/add_test_screen_controller/add_test_screen_controller.dart';
import 'package:icon_infoware/controller/color_controller/color_controller.dart';
import 'package:icon_infoware/core/constants/app_constants.dart';
import 'package:icon_infoware/core/errors/api_errors/api_errors.dart';
import 'package:icon_infoware/core/services/qr_code_image/qr_code_image_service.dart';
import 'package:icon_infoware/core/themes/colors.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PaymentOptionCard extends ConsumerWidget {
  const PaymentOptionCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Example:
    final addTestState = ref.watch(addTestScreenProvider);
    final colorState = ref.watch(colorProvider);
    // final controller = ref.read(addTestScreenProvider.notifier);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE8E8E8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Payment Option',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 12),
          InkWell(
            onTap: () {
              num amount = addTestState.primaryType == 'UPI'
                  ? addTestState.primaryPaid
                  : addTestState.secondaryType == 'UPI'
                  ? addTestState.secondaryPaid
                  : 0;
              log('amount is $amount');
              log(
                'primary type ${addTestState.primaryType} primary amount ${addTestState.primaryPaid}',
              );
              log(
                'secondary type ${addTestState.secondaryType} secondary amount ${addTestState.secondaryPaid}',
              );

              if (amount == 0) {
                AppMessage.show(context, "Please enter a UPI payment amount.");
              } else if (AppConstants.upiPaymentId.isEmpty) {
                AppMessage.show(
                  context,
                  "Please select any Bank in Menu Screen.",
                );
              } else {
                final qrData = UpiQrService.generateUri(
                  upiId: AppConstants.upiPaymentId,
                  payeeName: 'ABC Diagnostics',
                  amount: amount,
                  note: 'Lab Test Payment',
                );
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: AppColors.appWhite,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "asset/images/upi_image.jpeg",
                            height: 45,
                            width: 45,
                          ),
                          Text(
                            'Paying to UPI',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      content: Column(
                        spacing: 10,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Center(
                            child: QrImageView(
                              data: qrData,
                              version: QrVersions.auto,
                              size: 220,
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                context.pop();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: colorState.primaryColor,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    8,
                                  ), // Optional
                                ),
                              ),
                              child: const Text(
                                'Done',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: colorState.secondaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset(
                'asset/images/qr_code.png',
                width: 70,
                height: 70,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAF3DE),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Icon(
                      Icons.qr_code,
                      color: Color(0xFF3B6D11),
                      size: 40,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
