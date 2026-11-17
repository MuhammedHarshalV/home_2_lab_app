import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:icon_infoware/controller/payment_controller/payment_controller.dart';
import 'package:icon_infoware/core/themes/colors.dart';

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
    final paymentController = ref.read(paymentScreenProvider.notifier);
    final paymentState = ref.watch(paymentScreenProvider);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: secondColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // UPI and Cash row
          Row(
            children: [
              Expanded(
                child: _PaymentMethodCard(
                  isPrimary: true,
                  controller: paymentController.primaryController,
                  label: paymentState.primaryPaymentType,
                  amount: paymentState.primaryAmount.toString(),
                  isLeft: true,
                  color: primaryColor,
                  onAmountChanged: (value) {
                    paymentController.updatePrimaryAmount(value);
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _PaymentMethodCard(
                  isPrimary: false,
                  controller: paymentController.secondaryController,
                  label: paymentState.secondaryPaymentType,
                  amount: paymentState.secondaryAmount.toString(),
                  isLeft: false,
                  color: primaryColor,
                  onAmountChanged: (value) {
                    paymentController.updateSecondaryAmount(value);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PaymentMethodCard extends ConsumerWidget {
  final bool isPrimary;
  final String label;
  final String amount;
  final bool isLeft;
  final Color color;
  final TextEditingController controller;
  final ValueChanged<String> onAmountChanged;

  const _PaymentMethodCard({
    required this.isPrimary,
    required this.label,
    required this.amount,
    required this.isLeft,
    required this.color,
    required this.controller,
    required this.onAmountChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paymentController = ref.read(paymentScreenProvider.notifier);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: .7)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 11,
                        color: color.withValues(alpha: .7),
                      ),
                    ),
                    const SizedBox(height: 2),
                    TextField(
                      controller: controller,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      onChanged: onAmountChanged,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: color,
                      ),
                      onTapOutside: (event) {
                        FocusScope.of(context).unfocus();
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d{0,2}'),
                        ),
                      ],
                      decoration: InputDecoration(
                        hintText: isPrimary
                            ? 'Primary Amount'
                            : 'Secondary Amount',
                        hintStyle: TextStyle(
                          color: color,
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                        prefixText: '₹ ',
                        prefixStyle: TextStyle(
                          color: color,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                        isDense: true,
                        border: InputBorder.none,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTapDown: (details) async {
                  final List<String> items = ['Cash', 'UPI', 'Card'];

                  final String? result = await showDropDown(
                    context,
                    details.globalPosition,
                    items,
                  );

                  if (result != null) {
                    // Update selected payment type here
                    if (isPrimary) {
                      paymentController.updateState(primaryType: result);
                    } else {
                      paymentController.updateState(secondaryType: result);
                    }
                  }
                },
                child: Icon(Icons.arrow_drop_down, color: color),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<String?> showDropDown(
    BuildContext context,
    Offset tapPosition,
    List<String> items,
  ) async {
    final screenSize = MediaQuery.of(context).size;

    return showMenu<String>(
      context: context,
      color: AppColors.appWhite,
      position: RelativeRect.fromLTRB(
        tapPosition.dx,
        tapPosition.dy,
        screenSize.width,
        screenSize.height - tapPosition.dy,
      ),
      items: items.map((item) {
        return PopupMenuItem<String>(value: item, child: Text(item));
      }).toList(),
      constraints: BoxConstraints(maxHeight: screenSize.height / 2),
    );
  }
}
