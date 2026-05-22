import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icon_infoware/controller/add_test_screen_controller/add_test_screen_controller.dart';
import 'package:icon_infoware/core/themes/colors.dart';
import 'package:icon_infoware/models/spot_billing/test_add_selection.dart';
import 'package:icon_infoware/models/spot_billing/test_master_response_model.dart';

class TestAddSearchValueContainer extends ConsumerWidget {
  final TextEditingController textController;
  const TestAddSearchValueContainer({super.key, required this.textController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final testAddState = ref.watch(addTestScreenProvider);
    final testAddController = ref.read(addTestScreenProvider.notifier);
    return Container(
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
                    // if(value.isEmpty){ final newSearchList = testAddState.testMasterList
                    //     .where(
                    //       (item) => (item.testName ?? '')
                    //           .toLowerCase()
                    //           .contains(''),
                    //     )
                    //     .toList();}
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
                          return TestMasterSelected(
                            testKey: item.testKey,
                            testRate: item.testRate,
                            testShortCode: item.testShortCode,
                            testName: item.testName,
                            testSelected: false, // initial value
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

              // if (spotBillingState.isTextClear == true)
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                focusColor: Colors.transparent,
                onTap: () {},
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
            height: MediaQuery.of(context).size.height / 5,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 238, 240, 238),
              border: Border.all(color: AppColors.appGrey, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListView.builder(
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
                            onTap: () {
                              //                         if (testAddState
                              //                                 .testMasterListSeeing[index]
                              //                                 .testKey ==
                              //                             1165) {
                              //                                final updatedList = [...testAddState.testMasterListSeeing];
                              //                                 final itemIndex = updatedList.indexWhere((item) => item.testKey == 1165);

                              // if (itemIndex >= 0) {
                              //   final item = updatedList[itemIndex];

                              //   updatedList[itemIndex] = TestMasterSelected(
                              //     testKey: item.testKey,
                              //     testRate:testAddState.specialSchemeRalesList[],
                              //     testShortCode: item.testShortCode,
                              //     testName: item.testName,
                              //     testSelected: false,
                              //   );
                              // }
                              // final selectedList = updatedList
                              //     .where((item) => item.testSelected == true)
                              //     .toList();
                              // num totalPrice = state.totalPrice - updatedList[itemIndex].testRate!;

                              // state = state.copyWith(
                              //   testMasterListSeeing: updatedList,
                              //   testMasterListSelected: selectedList,
                              //   totalPrice: totalPrice,
                              // );

                              // } else {

                              testAddController.updateSelectedTest(
                                index: index,
                                name: null,
                              );
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
