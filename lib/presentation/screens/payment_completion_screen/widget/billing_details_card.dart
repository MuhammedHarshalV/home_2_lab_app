import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icon_infoware/controller/color_controller/color_controller.dart';
import 'package:icon_infoware/controller/payment_controller/payment_controller.dart';
import 'package:icon_infoware/presentation/screens/payment_completion_screen/widget/upi_reffernce_id_popup.dart';

class BillDetailsCard extends ConsumerWidget {
  const BillDetailsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paymentState = ref.watch(paymentScreenProvider);
    final colorState = ref.watch(colorProvider);

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
            index: paymentState.patientList.first.indexClick ?? 0,
            label: 'Number of tests',
            value: paymentState.patientList
                .fold<int>(
                  0,
                  (total, patient) => total + (patient.testlists?.length ?? 0),
                )
                .toString(),
            color: colorState.primaryColor,
          ),
          _BillRow(
            index: paymentState.patientList.first.indexClick ?? 0,
            label: 'Gross Amount',
            value: paymentState.grossAmount.toString(),
            color: colorState.primaryColor,
          ),
          _BillRow(
            index: paymentState.patientList.first.indexClick ?? 0,
            label: 'Discount Amount',
            value: paymentState.discountAmount.toString(),
            color: colorState.primaryColor,
          ),
          _BillRow(
            index: paymentState.patientList.first.indexClick ?? 0,
            label: 'Service Charge',
            value: paymentState.serviceAmount.toString(),

            color: colorState.primaryColor,
          ),
          _BillRow(
            index: paymentState.patientList.first.indexClick ?? 0,
            label: 'Net Total',
            value: paymentState.totalamount.toString(),
            color: colorState.primaryColor,
          ),
          _BillRow(
            index: paymentState.patientList.first.indexClick ?? 0,
            label: 'Amount Paid',
            value: paymentState.paidAmount.toString(),
            color: colorState.primaryColor,
          ),
          _BillRow(
            index: paymentState.patientList.first.indexClick ?? 0,
            label: 'Balance',
            value: paymentState.balanceAmount.toString(),
            valueColor: const Color(0xFFA32D2D),
            color: colorState.primaryColor,
          ),
          Divider(color: colorState.primaryColor, height: 20),
          _BillRow(
            index: paymentState.patientList.first.indexClick ?? 0,
            label: 'UPI Reference ID',
            value: paymentState.upiReferenceId,
            isEditable: true,
            color: colorState.primaryColor,
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
  final Color color;
  final Color? valueColor;

  const _BillRow({
    required this.label,
    required this.value,
    this.isEditable = false,

    this.valueColor,

    required this.index,
    required this.color,
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
                    builder: (_) => RefferenceIdDialog(index: index),
                  );
                },
                child: Icon(Icons.edit, size: 20, color: color),
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
