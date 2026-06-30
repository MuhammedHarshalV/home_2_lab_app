import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:icon_infoware/controller/add_test_screen_controller/add_test_screen_controller.dart';
import 'package:icon_infoware/controller/patient_billing/patient_billing_controller.dart';
import 'package:icon_infoware/core/themes/colors.dart';
import 'package:icon_infoware/view/widgets/common_tap_possition_dropDown.dart';
import 'package:icon_infoware/view/widgets/common_text_field.dart';
import 'package:icon_infoware/view/widgets/type_text_form_field.dart';

class BillDetailsCard extends ConsumerWidget {
  const BillDetailsCard({super.key});

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
            label: 'Number of tests',
            value: addTeststate.testMasterListSelectedNewPrice.length
                .toString(),
          ),
          _BillRow(
            label: 'Gross Amount',
            value: addTeststate.totalPrice.toString(),
          ),
          _BillRow(
            label: 'Discount Amount',
            value: addTeststate.discountAmountController.text.isEmpty
                ? '00'
                : addTeststate.discountAmountController.text,
            isEditable: true,
            isDiscount: true,
          ),
          _BillRow(
            label: 'Service Charge',
            value: addTeststate.servicesnargeController.text.isEmpty
                ? '00'
                : addTeststate.servicesnargeController.text,
            isEditable: true,
            isService: true,
          ),
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
  final bool isDiscount;
  final bool isService;

  const _BillRow({
    required this.label,
    required this.value,
    this.isEditable = false,
    this.showEditOnly = false,
    this.isDiscount = false,
    this.valueColor,
    this.isService = false,
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
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => isDiscount == true
                          ? DiscountDialog()
                          : isService == true
                          ? ServiceChangeDialog()
                          : RefferenceIdDialog(),
                    );
                  },
                  child: Icon(Icons.edit, size: 14, color: Color(0xFF639922)),
                ),
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

class DiscountDialog extends ConsumerWidget {
  const DiscountDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addTeststate = ref.watch(addTestScreenProvider);
    final addTestcontroller = ref.read(addTestScreenProvider.notifier);

    return AlertDialog(
      backgroundColor: AppColors.appWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: const Center(
        child: Text(
          'Set discount',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
      content: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CommonTextField(
              controller: addTeststate.discountAmountController,
              hint: 'Discount Amount',
              icon: Icons.discount_outlined,
              isNumberInput: true,
              focusNode: true,
              onchanger: (value) {
                final amount = num.tryParse(value);

                if (amount != null) {
                  addTestcontroller.discountCalculation(discountAmount: amount);
                }
              },
            ),

            CommonTextField(
              controller: addTeststate.discountPercentageController,
              hint: 'Discount Percentage',
              icon: Icons.percent,
              focusNode: true,
              isNumberInput: true,
              onchanger: (value) {
                final amount = num.tryParse(value);

                if (amount != null) {
                  addTestcontroller.discountCalculation(
                    discountPercentage: amount,
                  );
                }
              },
            ),

            const SizedBox(height: 10),

            TypeTextFormField(
              hintText: 'Reason *',
              textController: addTeststate.discountReason,
              isSuffix: true,
              isReadOnly: true,
              dropDown: addTeststate.discountList,
              onChanged: (p0) {
                //  addTeststate.genderController.text = p0;
              },
            ),
          ],
        ),
      ),
      // actionsPadding: const EdgeInsets.all(20),
      actions: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.appPrimaryColorLight,
                  foregroundColor: AppColors.appBlack,
                  minimumSize: const Size(0, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  context.pop();
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.appPrimaryColor,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(0, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  // Example:
                  // ref.read(discountProvider.notifier).saveDiscount(
                  //   amount: discountAmountController.text,
                  //   percentage: discountPercentageController.text,
                  // );

                  Navigator.pop(context);
                },
                child: const Text(
                  "Set",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ServiceChangeDialog extends ConsumerWidget {
  const ServiceChangeDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addTeststate = ref.watch(addTestScreenProvider);

    return AlertDialog(
      backgroundColor: AppColors.appWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: const Center(
        child: Text(
          'Set Service charge',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
      content: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CommonTextField(
              controller: addTeststate.servicesnargeController,
              hint: 'Service Charge',
              icon: Icons.discount_outlined,
              isNumberInput: true,
            ),
          ],
        ),
      ),
      // actionsPadding: const EdgeInsets.all(20),
      actions: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.appPrimaryColorLight,
                  foregroundColor: AppColors.appBlack,
                  minimumSize: const Size(0, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  context.pop();
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.appPrimaryColor,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(0, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  // Example:
                  // ref.read(discountProvider.notifier).saveDiscount(
                  //   amount: discountAmountController.text,
                  //   percentage: discountPercentageController.text,
                  // );

                  Navigator.pop(context);
                },
                child: const Text(
                  "Set",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class RefferenceIdDialog extends ConsumerWidget {
  const RefferenceIdDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addTeststate = ref.watch(addTestScreenProvider);

    return AlertDialog(
      backgroundColor: AppColors.appWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: const Center(
        child: Text(
          'Enter UPI Reference ID',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
      content: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CommonTextField(
              controller: addTeststate.upiRefferenceIdController,
              hint: 'Reference ID',
              icon: Icons.qr_code_2_rounded,
              isNumberInput: true,
            ),
          ],
        ),
      ),
      // actionsPadding: const EdgeInsets.all(20),
      actions: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.appPrimaryColorLight,
                  foregroundColor: AppColors.appBlack,
                  minimumSize: const Size(0, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  context.pop();
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.appPrimaryColor,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(0, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  // Example:
                  // ref.read(discountProvider.notifier).saveDiscount(
                  //   amount: discountAmountController.text,
                  //   percentage: discountPercentageController.text,
                  // );

                  Navigator.pop(context);
                },
                child: const Text(
                  "Set",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
