import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icon_infoware/controller/add_test_screen_controller/add_test_screen_controller.dart';
import 'package:icon_infoware/core/themes/colors.dart';

class TestTableWidget extends ConsumerWidget {
  const TestTableWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addTestState = ref.watch(addTestScreenProvider);
    return Column(
      children: [
        // Table Header
        Container(
          color: AppColors.darkBlue,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
          child: const Row(
            children: [
              SizedBox(
                width: 50,
                child: Text(
                  'SLNO',
                  style: TextStyle(
                    color: AppColors.appWhite,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'TEST',
                  style: TextStyle(
                    color: AppColors.appWhite,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                'RATE',
                style: TextStyle(
                  color: AppColors.appWhite,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Column(
          children: List.generate(
            addTestState.testMasterListSelectedNewPrice.length,
            (index) => _buildTestRow(
              "${index + 1}",
              '${addTestState.testMasterListSelectedNewPrice[index].testName}',
              '${addTestState.testMasterListSelectedNewPrice[index].testRate}',
            ),
          ),
        ),

        // Table Rows
      ],
    );
  }

  Widget _buildTestRow(String slNo, String testName, String rate) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 50,
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                slNo,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Expanded(
            child: Text(
              testName,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              rate,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
