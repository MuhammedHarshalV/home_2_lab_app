import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:icon_infoware/controller/add_test_screen_controller/add_test_screen_controller.dart';

import 'package:icon_infoware/presentation/screens/payment_completion_screen/widget/split_payment_popup.dart';

class TotalAmountCard extends ConsumerWidget {
  final int index;
  final Color secondColor;
  final Color primaryColor;
  const TotalAmountCard({
    super.key,
    required this.index,
    required this.secondColor,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addTestState = ref.watch(addTestScreenProvider);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: secondColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Total amount row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Amount',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: primaryColor,
                ),
              ),
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => SplitPaymentDialog(index: index),
                  );
                },
                child: Text(
                  'split payment',
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            addTestState.netAmount.toString(),
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          const SizedBox(height: 12),

          // UPI and Cash row
          Row(
            children: [
              Expanded(
                child: _PaymentMethodCard(
                  label: addTestState.primaryType.isEmpty
                      ? 'Cash'
                      : addTestState.primaryType,
                  amount: 'Rs. ${ref.read(addTestScreenProvider).primaryPaid}',
                  isLeft: true,
                  color: primaryColor,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _PaymentMethodCard(
                  label: addTestState.secondaryType.isEmpty
                      ? 'UPI'
                      : addTestState.secondaryType,
                  amount: 'Rs. ${addTestState.secondaryPaid}',
                  isLeft: false,
                  color: primaryColor,
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
  final Color color;
  const _PaymentMethodCard({
    required this.label,
    required this.amount,
    required this.isLeft,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: .7)),
      ),
      child: Column(
        crossAxisAlignment: isLeft
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.end,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 11, color: color.withValues(alpha: .7)),
          ),
          const SizedBox(height: 2),
          Text(
            amount,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
