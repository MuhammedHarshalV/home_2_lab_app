import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icon_infoware/controller/add_test_screen_controller/add_test_screen_controller.dart';
import 'package:icon_infoware/controller/store_tests_hive_controller/store_tests_hive_controller.dart';
import 'package:icon_infoware/core/themes/colors.dart';
import 'package:icon_infoware/models/spot_billing/special_scheme_rates_response_model.dart';
import 'package:icon_infoware/models/spot_billing/test_add_selection.dart';

class TestAddSearchValueContainer extends ConsumerWidget {
  final TextEditingController textController;
  const TestAddSearchValueContainer({super.key, required this.textController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final testAddState = ref.watch(addTestScreenProvider);
    final testAddController = ref.read(addTestScreenProvider.notifier);
    final hiveContoller = ref.read(storeTestsHiveProvider.notifier);
    //  log(testAddState.checkedTestes.toString());
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      width: double.infinity,
      padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
      decoration: BoxDecoration(
        color: AppColors.appPrimaryColorLight,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              /// TEXTFIELD
              Expanded(
                child: TextField(
                  controller: textController,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    if (value.isEmpty) {
                      final newSearchList = testAddState.testMasterList;

                      final List<TestMasterSelected> selectedList =
                          newSearchList.map((item) {
                            final isSelected = testAddState
                                .testMasterListSelected
                                .any(
                                  (selected) =>
                                      selected.testName == item.testName,
                                );

                            return TestMasterSelected(
                              testKey: item.testKey,
                              testRate: item.testRate,
                              testShortCode: item.testShortCode,
                              testName: item.testName,
                              testSelected: isSelected,
                            );
                          }).toList();

                      testAddController.searchTestMaster(selectedList);
                    }

                    final search = value.toLowerCase();

                    final newSearchList = testAddState.testMasterList
                        .where(
                          (item) => (item.testName ?? '')
                              .toLowerCase()
                              .contains(search),
                        )
                        .toList();
                    final List<TestMasterSelected> selectedList = newSearchList
                        .map((item) {
                          final isSelected = testAddState.testMasterListSelected
                              .any(
                                (selected) =>
                                    selected.testName == item.testName,
                              );

                          return TestMasterSelected(
                            testKey: item.testKey,
                            testRate: item.testRate,
                            testShortCode: item.testShortCode,
                            testName: item.testName,
                            testSelected: isSelected,
                          );
                        })
                        .toList();

                    testAddController.searchTestMaster(selectedList);

                    log("Found : ${newSearchList.length}");
                  },

                  decoration: const InputDecoration(
                    hintText: "Select value",
                    border: InputBorder.none,
                  ),
                ),
              ),

              //   if (testAddState.isTextClear == true)
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                focusColor: Colors.transparent,
                onTap: () {
                  textController.clear();
                  final newSearchList = testAddState.testMasterList;
                  final List<TestMasterSelected> selectedList = newSearchList
                      .map((item) {
                        final isSelected = testAddState.testMasterListSelected
                            .any(
                              (selected) => selected.testName == item.testName,
                            );
                        return TestMasterSelected(
                          testKey: item.testKey,
                          testRate: item.testRate,
                          testShortCode: item.testShortCode,
                          testName: item.testName,
                          testSelected: isSelected,
                        );
                      })
                      .toList();

                  testAddController.searchTestMaster(selectedList);
                },
                child: Icon(Icons.close),
              ),
              SizedBox(width: 5),
            ],
          ),
          // if (spotBillingState.searchPatientList.isNotEmpty)
          SizedBox(height: 10),

          /// SEARCH LIST
          // if (spotBillingState.searchPatientList.isNotEmpty)
          Container(
            height: MediaQuery.of(context).size.height / 2.5,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 238, 240, 238),
              border: Border.all(color: AppColors.appGrey, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: testAddState.testMasterListSeeing.isEmpty
                ? Center(child: Text('No Test\'s found.'))
                : ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: testAddState.testMasterListSeeing.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    testAddState
                                            .testMasterListSeeing[index]
                                            .testName ??
                                        'No Name',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                //Spacer(),
                                InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  onTap: () async {
                                    if (testAddState
                                            .testMasterListSeeing[index]
                                            .testSelected ==
                                        false) {
                                      testAddController.addTestsToTemperary(
                                        test: testAddState
                                            .testMasterListSeeing[index],
                                      );
                                      // log(
                                      //   "schemeIDSelected: ${testAddState.schemeIDSelected}",
                                      // );
                                      // log(
                                      //   "testKey: ${testAddState.testMasterListSeeing[index].testKey}",
                                      // );

                                      // //store test to hive
                                      // // hiveContoller.addTestToHive(
                                      // //   test: testAddState
                                      // //       .testMasterListSeeing[index],
                                      // // );
                                      // if (testAddState.schemeIDSelected
                                      //         .toString() ==
                                      //     testAddState
                                      //         .testMasterListSeeing[index]
                                      //         .testKey!
                                      //         .toString()) {
                                      //   log('harshal 1');
                                      //   final filteredList = testAddState
                                      //       .specialSchemeRatesList
                                      //       .where(
                                      //         (item) =>
                                      //             item.schRTstid!.toString() ==
                                      //             testAddState.schemeIDSelected
                                      //                 .toString(),
                                      //       )
                                      //       .toList();
                                      //   log(
                                      //     'harshal 2: ${filteredList.toList()}',
                                      //   );
                                      //   log(
                                      //     filteredList
                                      //         .map(
                                      //           (e) =>
                                      //               "${e.schRTstid} - ${e.schRate}",
                                      //         )
                                      //         .toList()
                                      //         .toString(),
                                      //   );
                                      //   final matchedItem =
                                      //       filteredList.isNotEmpty
                                      //       ? filteredList.first
                                      //       : null;
                                      //   final TestMasterSelected
                                      //   list = TestMasterSelected(
                                      //     testKey: testAddState
                                      //         .testMasterListSeeing[index]
                                      //         .testKey,
                                      //     testRate:
                                      //         matchedItem?.schRate ??
                                      //         testAddState
                                      //             .testMasterListSeeing[index]
                                      //             .testRate,
                                      //     testShortCode: testAddState
                                      //         .testMasterListSeeing[index]
                                      //         .testShortCode,
                                      //     testName: testAddState
                                      //         .testMasterListSeeing[index]
                                      //         .testName,
                                      //     testSelected: testAddState
                                      //         .testMasterListSeeing[index]
                                      //         .testSelected,
                                      //   );

                                      //   testAddController
                                      //       .updateSpecialRateNewPriceList(
                                      //         list,
                                      //       );
                                      //   log('mmmm:${list.toString()}');

                                      //   log(
                                      //     'mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm: ${testAddState.testMasterListSelectedNewPrice.length}',
                                      //   );
                                      // } else {
                                      //   testAddController
                                      //       .updateSpecialRateNewPriceList(
                                      //         testAddState
                                      //             .testMasterListSeeing[index],
                                      //       );
                                      //   log(
                                      //     'mmmm:${testAddState.testMasterListSeeing[index].toString()}',
                                      //   );

                                      //   log(
                                      //     'mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm: ${testAddState.testMasterListSelectedNewPrice.length}',
                                      //   );
                                      // }
                                      // //hive removal
                                      // // hiveContoller.removeTestFromHive(
                                      // //   test: testAddState
                                      // //       .testMasterListSeeing[index],
                                      // // );
                                      // // final newSearchList =
                                      // //     testAddState.specialSchemeRatesList;
                                      // // final List<TestMasterSelected>
                                      // // selectedList = newSearchList.map((
                                      // //   item,
                                      // // ) {
                                      // //   final num price = testAddState
                                      // //       .testMasterListSeeing[index]
                                      // //       .testKey

                                      // //.contains(item.testName);

                                      // //   return TestMasterSelected(
                                      // //     testKey: item.testKey,
                                      // //     testRate: item.testRate,
                                      // //     testShortCode: item.testShortCode,
                                      // //     testName: item.testName,
                                      // //     testSelected: isSelected,
                                      // //   );
                                      // // }).toList();

                                      // await testAddController.checkedList(
                                      //   testAddState
                                      //       .testMasterListSeeing[index]
                                      //       .testName!,
                                      // );
                                      // log(
                                      //   testAddState.checkedTestes.toString(),
                                      // );
                                    } else {
                                      // testAddController.checkedListRemoval(
                                      //   testAddState
                                      //       .testMasterListSeeing[index]
                                      //       .testName!,
                                      // );
                                      testAddController.removeTestsToTemperary(
                                        test: testAddState
                                            .testMasterListSeeing[index],
                                      );
                                      // testAddController
                                      //     .removalSpecialRateNewPriceList(
                                      //       testAddState
                                      //           .testMasterListSeeing[index]
                                      //           .testName!,
                                      //     );
                                      // log(
                                      //   'mmmmmmm: ${testAddState.testMasterListSelectedNewPrice.toString()}',
                                      // );
                                      // log(
                                      //   testAddState.checkedTestes.toString(),
                                      // );
                                    }
                                    // testAddController.updateSelectedTest(
                                    //   index: index,
                                    //   name: null,
                                    // );
                                    //}
                                  },
                                  child: Icon(
                                    testAddState
                                                .testMasterListSeeing[index]
                                                .testSelected ==
                                            true
                                        ? Icons.check_box_outlined
                                        : Icons.check_box_outline_blank,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),

          // if (spotBillingState.searchPatientList.isNotEmpty)
        ],
      ),
    );
  }
}
