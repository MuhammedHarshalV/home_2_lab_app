import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:icon_infoware/core/constants/app_constance.dart';
import 'package:icon_infoware/core/themes/colors.dart';
import 'package:icon_infoware/view/screens/payment_completion_screen/widget/above_container_card.dart';

class PaymentCompletionScreen extends ConsumerWidget {
  const PaymentCompletionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
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
              backgroundColor: AppColors.appPrimaryColor.withOpacity(0.2),
              child: Icon(Icons.arrow_back, color: AppColors.appPrimaryColor),
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
                File(AppConstance.base64Image),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            // ✅ Header Info Card
            // _HeaderInfoCard(),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.appPrimaryColorLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  AboveContainerCard(
                    icon: Icons.account_balance_wallet_outlined,
                    label: 'Paying with',
                    value: 'MUHAMMED\nHARSHAL',
                  ),
                  Container(
                    height: 50,
                    width: 0.5,
                    color: AppColors.appPrimaryColor,
                  ),
                  AboveContainerCard(
                    icon: Icons.calendar_today_outlined,
                    label: 'Paying Date',
                    value: 'May 26, 2026',
                  ),
                  Container(
                    height: 50,
                    width: 0.5,
                    color: AppColors.appPrimaryColor,
                  ),
                  AboveContainerCard(
                    icon: Icons.qr_code_outlined,
                    label: 'Paying No',
                    value: 'DEV1',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // ✅ Dashed Divider
            _DashedDivider(),
            const SizedBox(height: 16),

            // ✅ Bill Details Card
            _BillDetailsCard(),
            const SizedBox(height: 16),

            // ✅ Total Amount Card
            _TotalAmountCard(),
            const SizedBox(height: 16),

            // ✅ Dashed Divider
            _DashedDivider(),
            const SizedBox(height: 16),

            // ✅ Payment Option (QR)
            _PaymentOptionCard(),
            const SizedBox(height: 24),

            // ✅ Confirm Button
            _ConfirmButton(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════
// HEADER INFO CARD
// ══════════════════════════════════════════
// class _HeaderInfoCard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
//       decoration: BoxDecoration(
//         color: AppColors.appPrimaryColorLight,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: Column(
//               children: [
//                 Icon(
//                   Icons.wallet_travel_rounded,
//                   color: const Color(0xFF3B6D11),
//                   size: 22,
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   'Paying with',
//                   style: const TextStyle(
//                     fontSize: 10,
//                     color: Color(0xFF639922),
//                   ),
//                 ),
//                 const SizedBox(height: 2),
//                 Text(
//                   "Muhammed Harshal V",
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(
//                     fontSize: 11,
//                     fontWeight: FontWeight.w600,
//                     color: Color(0xFF27500A),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(height: 50, width: 0.5, color: AppColors.appPrimaryColor),
//           _HeaderInfoItem(
//             icon: Icons.calendar_today_outlined,
//             label: 'Paying Date',
//             value: 'May 26, 2026',
//           ),
//           Container(height: 50, width: 0.5, color: AppColors.appPrimaryColor),
//           _HeaderInfoItem(
//             icon: Icons.qr_code_outlined,
//             label: 'Paying No',
//             value: 'DEV1',
//           ),
//         ],
//       ),
//     );
//   }
// }

class _VerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(height: 50, width: 0.5, color: AppColors.appPrimaryColor);
  }
}

// ══════════════════════════════════════════
// DASHED DIVIDER
// ══════════════════════════════════════════
class _DashedDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final dashCount = (constraints.maxWidth / 8).floor();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (_) {
            return Container(
              width: 4,
              height: 1.5,
              color: AppColors.appPrimaryColor,
            );
          }),
        );
      },
    );
  }
}

// ══════════════════════════════════════════
// BILL DETAILS CARD
// ══════════════════════════════════════════
class _BillDetailsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE8E8E8)),
      ),
      child: Column(
        children: [
          _BillRow(label: 'Number of tests', value: '1'),
          _BillRow(label: 'Gross Amount', value: '10000.0'),
          _BillRow(label: 'Discount Amount', value: '0.00', isEditable: true),
          _BillRow(label: 'Service Charge', value: '0.0', isEditable: true),
          _BillRow(label: 'Net Total', value: '10000.0'),
          _BillRow(label: 'Amount Paid', value: '110.00'),
          _BillRow(
            label: 'Balance',
            value: '9890.00',
            valueColor: const Color(0xFFA32D2D),
          ),
          Divider(color: AppColors.appPrimaryColor, height: 20),
          _BillRow(
            label: 'UPI Reference ID',
            value: '',
            isEditable: true,
            showEditOnly: true,
          ),
        ],
      ),
    );
  }
}

class _BillRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isEditable;
  final bool showEditOnly;
  final Color? valueColor;

  const _BillRow({
    required this.label,
    required this.value,
    this.isEditable = false,
    this.showEditOnly = false,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            children: [
              const Text(
                ': ',
                style: TextStyle(fontSize: 13, color: Colors.black87),
              ),
              if (isEditable)
                const Icon(Icons.edit, size: 14, color: Color(0xFF639922)),
              if (!showEditOnly) ...[
                const SizedBox(width: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: valueColor ?? Colors.black87,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════
// TOTAL AMOUNT CARD
// ══════════════════════════════════════════
class _TotalAmountCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF3DE),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Total amount row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Amount',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF27500A),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  'split payment',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF3B6D11),
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Text(
            '₹10,000.00',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w600,
              color: Color(0xFF3B6D11),
            ),
          ),
          const SizedBox(height: 12),

          // UPI and Cash row
          Row(
            children: [
              Expanded(
                child: _PaymentMethodCard(
                  label: 'UPI',
                  amount: 'Rs. 0.00',
                  isLeft: true,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _PaymentMethodCard(
                  label: 'Cash',
                  amount: 'Rs. 0.00',
                  isLeft: false,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PaymentMethodCard extends StatelessWidget {
  final String label;
  final String amount;
  final bool isLeft;

  const _PaymentMethodCard({
    required this.label,
    required this.amount,
    required this.isLeft,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFC0DD97)),
      ),
      child: Column(
        crossAxisAlignment: isLeft
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.end,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 11, color: Color(0xFF639922)),
          ),
          const SizedBox(height: 2),
          Text(
            amount,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF27500A),
            ),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════
// PAYMENT OPTION CARD (QR)
// ══════════════════════════════════════════
class _PaymentOptionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFEAF3DE),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.network(
              'https://api.qrserver.com/v1/create-qr-code/?size=80x80&data=DEV1&color=3B6D11',
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
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════
// CONFIRM BUTTON
// ══════════════════════════════════════════
class _ConfirmButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.appPrimaryColor,
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
    );
  }
}
