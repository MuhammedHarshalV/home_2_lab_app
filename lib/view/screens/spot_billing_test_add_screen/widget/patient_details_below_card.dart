import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icon_infoware/controller/add_test_screen_controller/add_test_screen_controller.dart';
import 'package:icon_infoware/core/themes/colors.dart';

class PatientDetailsBelowCard extends ConsumerWidget {
  const PatientDetailsBelowCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final testAddState = ref.watch(addTestScreenProvider);
    final testAddController = ref.read(addTestScreenProvider.notifier);
    return Column(
      children: [
        Divider(color: Colors.grey, thickness: 2),
        Row(
          children: [
            Icon(Icons.account_balance_wallet_sharp, color: Colors.blueAccent),
            Text(
              'Bill Info :',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF37474F),
                fontWeight: FontWeight.bold, // Dark grey-blue
              ),
            ),
            Spacer(),
            Container(
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    'Payment Due',
                    style: TextStyle(
                      fontSize: 10,
                      color: AppColors.appWhite,
                      fontWeight: FontWeight.bold, // Dark grey-blue
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        Row(
          spacing: 5,
          children: [
            Column(
              children: [
                Text(
                  'Total Amount',
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xFF37474F), // Dark grey-blue
                  ),
                ),
                Text(
                  '₹ ${testAddState.totalPrice}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF37474F),
                    fontWeight: FontWeight.bold, // Dark grey-blue
                  ),
                ),
              ],
            ),
            Divider(color: Colors.grey, thickness: 2),
            Column(
              children: [
                Text(
                  'Due Amount',
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xFF37474F), // Dark grey-blue
                  ),
                ),
                Text(
                  '₹ ${testAddState.totalPrice}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF37474F),
                    fontWeight: FontWeight.bold, // Dark grey-blue
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                // width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.appPrimaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      'Collect Payment',
                      style: TextStyle(
                        fontSize: 10,
                        color: AppColors.appWhite,
                        fontWeight: FontWeight.bold, // Dark grey-blue
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          spacing: 10,
          children: [
            Expanded(
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.appPrimaryColorLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    'Cancel visit',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.appPrimaryColor,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.appPrimaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    'Complete',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.appWhite,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
