import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BillingRowWidget extends ConsumerWidget {
  final String label;
  final String amount;
  final bool isLightBlue;

  const BillingRowWidget({
    super.key,
    required this.label,
    required this.amount,
    required this.isLightBlue,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: isLightBlue ? Color(0xFFE5F0F9) : Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 1.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          Text(
            amount,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
