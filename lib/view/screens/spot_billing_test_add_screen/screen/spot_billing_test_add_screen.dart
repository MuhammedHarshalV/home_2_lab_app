import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icon_infoware/controller/bottom_nav_screen/bottom_nav_controller.dart';
import 'package:icon_infoware/core/constants/app_constance.dart';
import 'package:icon_infoware/core/themes/colors.dart';
import 'package:icon_infoware/view/screens/bottom_nav_screen.dart';
import 'package:icon_infoware/view/screens/spot_billing_test_add_screen/widget/patient_details_below_card.dart';
import 'package:icon_infoware/view/screens/spot_billing_test_add_screen/widget/patient_details_card.dart';

class SpotBillingTestAddScreen extends ConsumerWidget {
  const SpotBillingTestAddScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<TestModel> testList = [
      TestModel(name: "ALDOLASE", amount: 10000),
      TestModel(name: "4 BASE CARE L", amount: 3000),
      TestModel(name: "group test sample", amount: 500),
      TestModel(name: "test name", amount: 500),
      TestModel(name: "ALDOLASE", amount: 10000),
      TestModel(name: "4 BASE CARE L", amount: 3000),
      TestModel(name: "group test sample", amount: 500),
      TestModel(name: "test name", amount: 500),
    ];
    final bottomNavController = ref.read(bottomNavProvider.notifier);

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              bottomNavController.setIndex(0);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => BottomNavScreen()),
                (route) => false,
              );
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            PatientDetailsCard(),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(color: AppColors.appPrimaryColorLight),
              child: Table(
                columnWidths: const {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(4),
                  2: FlexColumnWidth(3),
                },
                children: [
                  TableRow(
                    decoration: BoxDecoration(color: AppColors.appPrimaryColor),
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "SlNo",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: AppColors.appWhite,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Test Name",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: AppColors.appWhite,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Amount",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: AppColors.appWhite,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Expanded(
              child: SizedBox(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(color: AppColors.appWhite),
                        child: Table(
                          border: TableBorder.all(
                            color: const Color.fromARGB(255, 105, 103, 103),
                            width: 1,
                          ),
                          columnWidths: const {
                            0: FlexColumnWidth(1),
                            1: FlexColumnWidth(4),
                            2: FlexColumnWidth(2),
                            3: FlexColumnWidth(1),
                          },
                          children: [
                            ...List.generate(testList.length, (index) {
                              final item = testList[index];

                              return TableRow(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                      "${index + 1}.",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                      item.name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                      "${item.amount}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Total Tests: 1234',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: AppColors.appPrimaryColorLight,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '+ Add More Tests',
                    style: TextStyle(
                      color: AppColors.appPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            PatientDetailsBelowCard(),
          ],
        ),
      ),
    );
  }
}

class TestModel {
  final String name;
  final double amount;

  TestModel({required this.name, required this.amount});
}
