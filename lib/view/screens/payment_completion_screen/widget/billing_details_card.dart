import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:icon_infoware/controller/add_test_screen_controller/add_test_screen_controller.dart';

import 'package:icon_infoware/core/themes/colors.dart';
import 'package:icon_infoware/view/screens/payment_completion_screen/widget/discount_popup.dart';
import 'package:icon_infoware/view/screens/payment_completion_screen/widget/service_charge_popup.dart';
import 'package:icon_infoware/view/screens/payment_completion_screen/widget/upi_reffernce_id_popup.dart';

class BillDetailsCard extends ConsumerWidget {
  final int index;
  const BillDetailsCard({super.key, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addTeststate = ref.watch(addTestScreenProvider);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE8E8E8)),
      ),
      child: Column(
        children: [
          _BillRow(
            index: index,
            label: 'Number of tests',
            value: addTeststate.testMasterListSelectedNewPrice.length
                .toString(),
          ),
          _BillRow(
            index: index,
            label: 'Gross Amount',
            value: addTeststate.totalPrice.toString(),
          ),
          _BillRow(
            index: index,
            label: 'Discount Amount',
            value: addTeststate.discountAmountController.text.isEmpty
                ? '00'
                : addTeststate.discountAmountController.text,
            isEditable: true,
            isDiscount: true,
          ),
          _BillRow(
            index: index,
            label: 'Service Charge',
            value: addTeststate.servicesnargeController.text.isEmpty
                ? '00'
                : addTeststate.servicesnargeController.text,
            isEditable: true,
            isService: true,
          ),
          _BillRow(
            index: index,
            label: 'Net Total',
            value: addTeststate.netAmount.toString(),
          ),
          _BillRow(
            index: index,
            label: 'Amount Paid',
            value: addTeststate.amountPaid.toString(),
          ),
          _BillRow(
            index: index,
            label: 'Balance',
            value: addTeststate.balanceAmount.toString(),
            valueColor: const Color(0xFFA32D2D),
          ),
          Divider(color: AppColors.appPrimaryColor, height: 20),
          _BillRow(
            index: index,
            label: 'UPI Reference ID',
            value: addTeststate.upiRefferenceIdController.text.isEmpty
                ? ''
                : addTeststate.upiRefferenceIdController.text,
            isEditable: true,
            // showEditOnly: true,
          ),
        ],
      ),
    );
  }
}

class _BillRow extends StatelessWidget {
  final int index;
  final String label;
  final String value;
  final bool isEditable;

  final Color? valueColor;
  final bool isDiscount;
  final bool isService;

  const _BillRow({
    required this.label,
    required this.value,
    this.isEditable = false,

    this.isDiscount = false,
    this.valueColor,
    this.isService = false,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          const Text(
            ': ',
            style: TextStyle(fontSize: 13, color: Colors.black87),
          ),
          if (isEditable) Spacer(),
          if (isEditable)
            Padding(
              padding: const EdgeInsets.only(right: 4),
              child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => isDiscount
                        ? DiscountDialog(index: index)
                        : isService
                        ? ServiceChangeDialog(index: index)
                        : RefferenceIdDialog(index: index),
                  );
                },
                child: const Icon(
                  Icons.edit,
                  size: 20,
                  color: Color(0xFF639922),
                ),
              ),
            ),

          Expanded(
            flex: 5,
            child: Text(
              value,
              textAlign: TextAlign.end,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: valueColor ?? Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
