import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:icon_infoware/controller/add_test_screen_controller/add_test_screen_controller.dart';
import 'package:icon_infoware/controller/bottom_nav_screen/bottom_nav_controller.dart';
import 'package:icon_infoware/controller/home_screen_controller/home_screen_controller.dart';
import 'package:icon_infoware/core/constants/app_constance.dart';
import 'package:icon_infoware/core/routes/app_route_names.dart';
import 'package:icon_infoware/core/themes/colors.dart';
import 'package:icon_infoware/models/spot_billing/search_patient_response_model.dart';
import 'package:icon_infoware/models/spot_billing/test_add_selection.dart';
import 'package:icon_infoware/view/screens/bottom_nav_screen.dart';
import 'package:icon_infoware/view/screens/spot_billing_screen/widget/search_bar.dart';
import 'package:icon_infoware/view/screens/spot_billing_test_add_screen/widget/add_new_test_popup.dart';
import 'package:icon_infoware/view/screens/spot_billing_test_add_screen/widget/patient_details_below_card.dart';
import 'package:icon_infoware/view/screens/spot_billing_test_add_screen/widget/patient_details_card.dart';
import 'package:icon_infoware/view/screens/spot_billing_test_add_screen/widget/test_add_search_value_container.dart';

class SpotBillingTestAddScreen extends ConsumerWidget {
  final int? index;
  const SpotBillingTestAddScreen({super.key, this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final testMasterState = ref.watch(addTestScreenProvider);
    final testMasterController = ref.read(addTestScreenProvider.notifier);
    final homeState = ref.watch(homeScreenProvider);
    final bottomNavController = ref.read(bottomNavProvider.notifier);
    log('final list :${testMasterState.finalListNewPrice.toString()}');
    log('final list :${testMasterState.finalListNewPrice.length}');
    // log('checked list :${testMasterState.checkedTestes.toString()}');
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
              context.pushReplacementNamed(AppRouteNames.bottomNavScreen.name);
              testMasterState.searchController.clear();
              // Navigator.pushAndRemoveUntil(
              //   context,
              //   MaterialPageRoute(builder: (context) => BottomNavScreen()),
              //   (route) => false,
              // );
              // context.pop();
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
            PatientDetailsCard(index: index),
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
                      testMasterState.testMasterListSelectedNewPrice.isNotEmpty
                          ? Container(
                              decoration: BoxDecoration(
                                color: AppColors.appWhite,
                              ),
                              child: Table(
                                border: TableBorder.all(
                                  color: const Color.fromARGB(
                                    255,
                                    105,
                                    103,
                                    103,
                                  ),
                                  width: 1,
                                ),
                                columnWidths: const {
                                  0: FlexColumnWidth(1),
                                  1: FlexColumnWidth(4),
                                  2: FlexColumnWidth(2),
                                  3: FlexColumnWidth(1),
                                },
                                children: [
                                  ...List.generate(
                                    testMasterState
                                        .testMasterListSelectedNewPrice
                                        .length,
                                    (index) {
                                      final item = testMasterState
                                          .testMasterListSelectedNewPrice[index];

                                      return TableRow(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 10,
                                              horizontal: 5,
                                            ),
                                            child: Text(
                                              "${index + 1}.",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),

                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 10,
                                              horizontal: 5,
                                            ),
                                            child: Text(
                                              item.testName ?? '',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),

                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 10,
                                              horizontal: 5,
                                            ),
                                            child: Text(
                                              "${item.testRate}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              onTap: () {
                                                // testMasterController
                                                //     .updateSelectedTest(
                                                //       index: null,
                                                //       name: item.testName!,
                                                //     );
                                                // testMasterController
                                                //     .removalSpecialRateNewPriceList(
                                                //       item.testName!,
                                                //     );
                                                // testMasterController
                                                //     .removalFinalList(
                                                //       item.testName!,
                                                //     );
                                                // testMasterController
                                                //     .checkedListRemoval(
                                                //       item.testName!,
                                                //     );
                                              },
                                              child: Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                                size: 25,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Center(child: Text("No tests found!")),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Total Tests: ${testMasterState.testMasterListSelectedNewPrice.length}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              onTap: () {
                int indexget = homeState.patientBookingList.length - 1;
                if (index == null) {
                  showDialog(
                    context: context,
                    builder: (context) => AddNewTestPopUp(index: indexget),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AddNewTestPopUp(index: index!),
                  );
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.appPrimaryColorLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
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
            ),

            PatientDetailsBelowCard(),
          ],
        ),
      ),
    );
  }
}
