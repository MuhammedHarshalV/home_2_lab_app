import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:icon_infoware/apis/discount_fetching/discount_fetching_api.dart';
import 'package:icon_infoware/apis/spot_billing/patient_syncing_api.dart';
import 'package:icon_infoware/apis/spot_billing/special_scheme_rates_api.dart';
import 'package:icon_infoware/apis/spot_billing/test_master_api.dart';
import 'package:icon_infoware/controller/add_test_screen_controller/add_test_screen_state.dart';
import 'package:icon_infoware/core/services/network_services/connection_checking.dart';
import 'package:icon_infoware/models/discount_reasons/discount_reasons_response_model.dart';
import 'package:icon_infoware/models/patient_bill_syncing_model/patient_bill_syncing_model.dart';

import 'package:icon_infoware/models/spot_billing/done_by_search_response_model.dart';
import 'package:icon_infoware/models/spot_billing/special_scheme_rates_response_model.dart';
import 'package:icon_infoware/models/spot_billing/test_add_selection.dart';
import 'package:icon_infoware/models/spot_billing/test_master_response_model.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddTestScreenController extends StateNotifier<AddTestScreenState> {
  AddTestScreenController()
    : super(
        AddTestScreenState(
          discountReason: TextEditingController(),
          searchController: TextEditingController(),
          specialSchemeController: TextEditingController(),
          specialSchemeFocusNode: FocusNode(),
          discountAmountController: TextEditingController(),
          discountPercentageController: TextEditingController(),
          servicesnargeController: TextEditingController(),
          upiRefferenceIdController: TextEditingController(),
          primaryAmountContoller: TextEditingController(),
          secondaryAmountController: TextEditingController(),
        ),
      ) {
    Future.microtask(() async {
      //  await getTestMasterLists();
      // testMasterCalling();
      specialRatesFetch();
    });
  }
  //store test lists to hive
  Future<void> getTestMasterLists(PatientHiveModel? indexOfClicking) async {
    bool isConnected = await InternetChecker.hasConnection();
    try {
      await Future.delayed(Duration(seconds: 1));
      final box = await Hive.openBox('test_lists');
      if (isConnected == true && box.isEmpty) {
        final TestMasterResponseModel response =
            await TestMasterApi.testMasterApi();
        if (response.success == true && response.tests != null) {
          await saveTests(response.tests ?? []); //strore to hive
          await getTestsFromHive(
            indexOfClicking,
          ); //read from hive and update state
        } else {
          await getTestsFromHive(
            indexOfClicking,
          ); //read from hive and update state
        }
      } else {
        await getTestsFromHive(
          indexOfClicking,
        ); //read from hive and update state
      }
    } catch (e) {
      log(e.toString());
    }
  }

  //store tests to hive
  Future<void> saveTests(List<TestMaster> tests) async {
    final box = await Hive.openBox('test_lists');
    int count = 0;
    for (final test in tests) {
      if ((test.testName ?? '').trim().isNotEmpty) {
        count++;

        log(
          '[$count] TestKey: ${test.testKey}, '
          'TestName: ${test.testName}',
        );
        await box.add({
          'testKey': test.testKey ?? 0,
          'testName': test.testName ?? '',
          'testRate': test.testRate ?? 0,
          'testShortCode': test.testShortCode ?? '',
        });
        log('Total saved tests: $count');
      }
    }
  }

  //read patients details from hive
  Future<void> getTestsFromHive(PatientHiveModel? indexOfClicking) async {
    final box = await Hive.openBox('test_lists');
    state = state.copyWith(
      testMasterListSelected: [],
      testMasterListSelectedNewPrice: [],
    );
    final tests = box.values.map<TestMaster>((item) {
      return TestMaster(
        testKey: item['testKey'],
        testName: item['testName'],
        testRate: item['testRate'],
        testShortCode: item['testShortCode'],
      );
    }).toList();
    log('readed data from hive : ${tests.length}');
    state = state.copyWith(testMasterList: tests);
    if (indexOfClicking == null) {
      final List<TestMasterSelected> selectedList = state.testMasterList.map((
        item,
      ) {
        return TestMasterSelected(
          testKey: item.testKey,
          testRate: item.testRate,
          testShortCode: item.testShortCode,
          testName: item.testName,
          testSelected: false,
        );
      }).toList();
      state = state.copyWith(testMasterListSeeing: selectedList);
    } //any one tests in already saved
    else {
      final List<TestMasterSelected> selectedList = state.testMasterList.map((
        item,
      ) {
        final isSelected = (indexOfClicking.testlists ?? []).any(
          (test) => test['TestId'] == item.testKey,
        );

        return TestMasterSelected(
          testKey: item.testKey,
          testRate: item.testRate,
          testShortCode: item.testShortCode,
          testName: item.testName,
          testSelected: isSelected,
        );
      }).toList();
      final List<TestMasterSelected> finalList = [];

      for (final item in state.testMasterList) {
        final isInPatient = (indexOfClicking.testlists ?? []).any(
          (test) => test['TestId'] == item.testKey,
        );

        final alreadyExists = finalList.any((e) => e.testKey == item.testKey);

        if (isInPatient && !alreadyExists) {
          finalList.add(
            TestMasterSelected(
              testKey: item.testKey,
              testRate: item.testRate,
              testShortCode: item.testShortCode,
              testName: item.testName,
              testSelected: true,
            ),
          );
        }
      }
      num totalPrice = 0;

      for (final test in finalList) {
        totalPrice += (test.testRate ?? 0);
      }

      state = state.copyWith(
        testMasterListSeeing: selectedList,
        testMasterListSelected: finalList,
        testMasterListSelectedNewPrice: finalList,
        totalPrice: totalPrice,
      );
    }
  }

  //stroring discount and fetching
  Future<void> storingAndFetchingDiscount() async {
    bool isConnected = await InternetChecker.hasConnection();
    try {
      await Future.delayed(Duration(seconds: 1));
      final box = await Hive.openBox('Discount_reasons');
      if (isConnected == true && box.isEmpty) {
        final DiscountReasonResponseModel response =
            await DiscountFetchingApi.discountFetchingApi();
        if (response.success == true && response.discReasonList != null) {
          await saveDiscountReasons(response.discReasonList ?? []);

          // strore to hive
          await getDiscountFromHive(); //read from hive and update state
        } else {
          await getDiscountFromHive(); //read from hive and update state
        }
      } else {
        await getDiscountFromHive(); //read from hive and update state
      }
    } catch (e) {
      log(e.toString());
    }
  }

  //store tests to hive
  Future<void> saveDiscountReasons(List<DiscReasonList> discount) async {
    final box = await Hive.openBox('Discount_reasons');

    for (final disc in discount) {
      if (disc.mstType == 'DiscR') {
        await box.add({'mstDesc': disc.mstDesc ?? ''});
      }
    }
  }

  //read discount reasons from hive
  Future<void> getDiscountFromHive() async {
    final box = await Hive.openBox('Discount_reasons');

    final discount = box.values
        .map<String>((item) => item['mstDesc'].toString())
        .toList();
    log('readed data from hive : ${discount.length}');
    state = state.copyWith(discountList: discount);
  }

  //clear hive
  Future<void> cleartests() async {
    final box = await Hive.openBox('Discount_reasons');
    await box.clear();
  }

  //set discount amount or percentage
  void discountCalculation({num? discountAmount, num? discountPercentage}) {
    if (state.totalPrice <= 0) return;

    // Percentage -> Amount
    if (discountPercentage != null) {
      final amount = (state.totalPrice * discountPercentage) / 100;

      state.discountPercentageController.text = discountPercentage.toString();

      state.discountAmountController.text = amount.toStringAsFixed(2);
      // state = state.copyWith(netAmount: state.netAmount - amount);
    }
    // Amount -> Percentage
    else if (discountAmount != null) {
      final percentage = (discountAmount / state.totalPrice) * 100;

      state.discountAmountController.text = discountAmount.toString();

      state.discountPercentageController.text = percentage.toStringAsFixed(2);
      // state = state.copyWith(netAmount: state.netAmount - discountAmount);
    }
  }

  //filter selectedresults
  Future<void> filterSelectedTests({
    required List<Map<String, dynamic>> testIDs,
  }) async {
    log("stored data :${testIDs.toString()}");
    final box = await Hive.openBox('test_lists');

    final newList = box.values.map<TestMasterSelected>((item) {
      final data = Map<String, dynamic>.from(item);

      return TestMasterSelected(
        testKey: data['testKey'],
        testName: data['testName'],
        testRate: data['testRate'],
        testShortCode: data['testShortCode'],
        testSelected: testIDs.any((test) => test['TestId'] == data['testKey']),
      );
    }).toList();

    state = state.copyWith(testMasterListSeeing: newList);
  }

  //store scheme id or role id
  Future<void> stroreSchemeRoleID({
    required int? schemeID,
    required int? roleID,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (schemeID != null && schemeID != 0) {
      await prefs.setInt('schemeID', schemeID);
    }
    if (roleID != null && roleID != 0) {
      await prefs.setInt('roleID', roleID);
    }
  }

  //add temperary selected tests
  void addTestsToTemperary({required TestMasterSelected test}) {
    final alreadyExists = state.testMasterListSelected.any(
      (item) => item.testKey == test.testKey,
    );

    if (alreadyExists) {
      log('Test already exists: ${test.testName}');
      return;
    }

    // Add to selected list
    final selectedList = [...state.testMasterListSelected, test];

    // Update seeing list
    final seeingList = state.testMasterListSeeing.map((item) {
      if (item.testKey == test.testKey) {
        return TestMasterSelected(
          testKey: item.testKey,
          testRate: item.testRate,
          testShortCode: item.testShortCode,
          testName: item.testName,
          testSelected: true,
        );
      }
      return item;
    }).toList();

    state = state.copyWith(
      testMasterListSelected: selectedList,
      testMasterListSeeing: seeingList,
    );

    log('temporary selected tests : ${state.testMasterListSelected}');
  }

  //remove temperary selected tests
  Future<void> removeTestsToTemperary({
    required TestMasterSelected test,
  }) async {
    log("selected lists :${state.testMasterListSelected}");
    final selectedList = state.testMasterListSelected
        .where((e) => e.testKey != test.testKey)
        .toList();

    final seeingList = state.testMasterListSeeing.map((item) {
      if (item.testKey == test.testKey) {
        return TestMasterSelected(
          testKey: item.testKey,
          testRate: item.testRate,
          testShortCode: item.testShortCode,
          testName: item.testName,
          testSelected: false,
        );
      }
      return item;
    }).toList();

    state = state.copyWith(
      testMasterListSelected: selectedList,
      testMasterListSeeing: seeingList,
    );
    log('5555555555555555555555');
    log('qqqqqqqqqqqqqqqqqqq ${selectedList.toString()}');
    log('5555555555555555555555');

    // log(seeingList.toString());
  }

  //state updation function
  void updatestate({
    bool? isUrgent,
    String? isSync,
    List<AccountsList>? specialSchemeList,
    List<TestMasterSelected>? testMasterListSeeing,
    List<TestMasterSelected>? testMasterListSelectedNewPrice,
    String? cardName,
    int? schemeIDSelected,
    bool? isCorporateBilling,
    bool? isSpecialschemeOpen,
    num? balanceAmount,
    num? amountPaid,
    num? primaryPaid,
    num? secondaryPaid,
    num? netAmount,
    num? grosAmount,
    String? primaryType,
    String? secondaryType,
  }) {
    state = state.copyWith(
      specialSchemeList: specialSchemeList,
      testMasterListSeeing: testMasterListSeeing,
      schemeIDSelected: schemeIDSelected,
      isCorporateBilling: isCorporateBilling,
      isSpecialschemeOpen: isCorporateBilling,
      balanceAmount: balanceAmount,
      amountPaid: amountPaid,
      netAmount: netAmount,
      totalPrice: grosAmount,
      primaryPaid: primaryPaid,
      secondaryPaid: secondaryPaid,
      primaryType: primaryType,
      secondaryType: secondaryType,
      testMasterListSelectedNewPrice: testMasterListSelectedNewPrice,
      isSync: isSync,
      cardName: cardName,
      isUrgent: isUrgent,
    );
  }

  //netamount balance amount calculate
  Future<void> updateNetBalanceAmounts() async {
    final grossAmount = state.totalPrice;

    final discountAmount =
        num.tryParse(state.discountAmountController.text) ?? 0;

    final serviceCharge = num.tryParse(state.servicesnargeController.text) ?? 0;

    final paidAmount = state.amountPaid;

    final netAmount1 = grossAmount - discountAmount;
    final netAmount2 = netAmount1 + serviceCharge;

    final balanceAmount = netAmount2 - paidAmount;

    state = state.copyWith(netAmount: netAmount2, balanceAmount: balanceAmount);
    log('========== BILL CALCULATION ==========');
    log('Gross Amount      : $grossAmount');
    log('Discount Amount   : $discountAmount');
    log('Service Charge    : $serviceCharge');
    log('Paid Amount       : $paidAmount');
    log('--------------------------------------');
    log(
      'Net Amount        : $grossAmount - $discountAmount + $serviceCharge = $netAmount2',
    );
    log('Balance Amount    : $netAmount2 - $paidAmount = $balanceAmount');
    log('======================================');
  }

  //update net amount and balance amount
  void uodateNetandBalanceAmount() {
    final discount = num.tryParse(state.discountAmountController.text) ?? 0;

    final totalAmount = state.testMasterListSelected.fold<num>(
      0,
      (sum, test) => sum + (test.testRate ?? 0),
    );

    final netAmount = totalAmount - discount;
    final balanceAmount = netAmount - state.amountPaid;
    log('length of list :${state.testMasterListSelectedNewPrice.length}');
    log("totalAmount :$totalAmount");
    log("netAmount :$netAmount");
    log("balanceAmount :$balanceAmount");

    state = state.copyWith(
      totalPrice: totalAmount,
      netAmount: netAmount,
      balanceAmount: balanceAmount,
    );
  }

  //upi id fetching
  void upiUpdates(String value) {
    state.upiRefferenceIdController.text = value;
  }

  //sync patient billing
  Future<bool> patientBillSyncingApi(PatientHiveModel patient) async {
    try {
      state = state.copyWith(isSyncLoading: true);
      final String currentDate = DateFormat(
        'yyyy-MM-dd',
      ).format(DateTime.now());
      final bool response = await PatientSyncingApi.patientSyncingApi(
        patId: patient.patId?.toString(),
        namePrefix: patient.namePrefix,
        patName: patient.patName,
        patAddress: patient.patAddress,
        invNo: int.tryParse(patient.invNo.toString()),
        patEmail: patient.patEmail,
        patPhno: patient.patPhno,
        patMobno: patient.patMobno,
        patAge: patient.patAge?.toInt(),
        patAgeHead: patient.patAgehead,
        patGender: patient.patGender,
        currentDateTime: currentDate,
        drId: int.tryParse(patient.drId.toString()),
        outDr: patient.outDr,
        passport: patient.passport,
        repEmail: int.tryParse(patient.repEmail.toString()),
        repWhatsapp: int.tryParse(patient.repWhtapp.toString()),
        urgent: patient.urgent?.toInt(),
        remarks: patient.remarks,
        ipop: patient.ipop,

        dob: patient.dob,
        driverId: patient.driverId ?? '',
        technicianId: int.tryParse(patient.techId ?? ''),
        grossAmt: patient.grossAmt,
        discAmt: patient.discAmt,
        servCharge: patient.servChrge,
        netAmt: patient.netAmt,
        paidAmt: patient.paidAmt,
        balance: patient.balance,
        paymentType: patient.primaryType,
        insId: int.tryParse(patient.insid.toString()),
        insNo: int.tryParse(patient.insNo.toString()),
        secondaryType: patient.secondaryType ?? '',
        primaryamount: patient.primaryPaid ?? 0,
        secondaryamount: patient.secondaryPaid ?? 0,
        testLists: patient.testlists,
      );
      log('syncing response :$response');
      return response;
    } catch (e) {
      log(e.toString());
      return false;
    } finally {
      state = state.copyWith(isSyncLoading: false);
    }
  }
  //update final list to see
  // void updateSpecialSchemePrice() {
  //   List<TestMasterSelected> updatedList = [];
  //   testMasterCalling();
  //   //specialRatesFetch();

  //   for (var test in state.finalListNewPrice) {
  //     num price = test.testRate ?? 0;

  //     log('controller schemeid selected: ${state.schemeIDSelected}');

  //     if (test.testKey == state.schemeIDSelected) {
  //       log('controller schemeid selected if: ${state.schemeIDSelected}');

  //       for (var item in state.specialSchemeRatesList) {
  //         if (item.schRTstid == state.schemeIDSelected) {
  //           price = item.schRate ?? price;
  //           break; // stop loop after first match
  //         }
  //       }
  //     } else {
  //       log('=======================================1');
  //       for (var item in state.testMasterListSeeing) {
  //         log('=======================================2');
  //         if (item.testKey == test.testKey) {
  //           log('=======================================3');
  //           price = item.testRate ?? price;
  //           log('=======================================$price');
  //           break; // stop loop after first match
  //         }
  //       }
  //     }

  //     updatedList.add(
  //       TestMasterSelected(
  //         testKey: test.testKey,
  //         testRate: price,
  //         testShortCode: test.testShortCode,
  //         testName: test.testName,
  //         testSelected: test.testSelected,
  //       ),
  //     );
  //   }

  //   num totalPrice = 0;

  //   for (var item in updatedList) {
  //     totalPrice += item.testRate ?? 0;
  //   }

  //   state = state.copyWith(
  //     finalListNewPrice: updatedList,
  //     totalPrice: totalPrice,
  //   );
  //   log('new special schemeid not selected : ${updatedList.toString()}');
  //   log('new final list ${state.finalListNewPrice}');
  //   log('new total price ${state.totalPrice}');
  // }

  //special scheme rate fetch by api
  Future<void> specialRatesFetch() async {
    try {
      final SpecialSchemeRatesResponseModel response =
          await SpecialSchemeRatesApi.specialSchemesApi();
      state = state.copyWith(
        specialSchemeRatesList: response.schemeRateList ?? [],
      );
    } catch (e) {
      log('conntroller catch : ${e.toString()}');
    }
  }

  Future<void> updateSpecialRateNewPriceList(TestMasterSelected list) async {
    final exists = state.testMasterListSelectedNewPrice.any(
      (item) => item == list,
    );
    if (!exists) {
      state = state.copyWith(
        testMasterListSelectedNewPrice: [
          ...state.testMasterListSelectedNewPrice,
          list,
        ],
      );
    }
  }

  Future<void> removalSpecialRateNewPriceList(String name) async {
    state = state.copyWith(
      testMasterListSelectedNewPrice: state.testMasterListSelectedNewPrice
          .where((item) => item.testName != name)
          .toList(),
    );
    log(
      'new specialscheme new rate list :${state.testMasterListSelectedNewPrice.toString()}',
    );
  }

  //remove tests from final list
  Future<void> removalFinalList(String name) async {
    state = state.copyWith(
      testMasterListSelectedNewPrice: state.testMasterListSelectedNewPrice
          .where((item) => item.testName != name)
          .toList(),
    );
    log(
      'new final new rate list :${state.testMasterListSelectedNewPrice.toString()}',
    );
  }

  // Future<void> checkedList(String testName) async {
  //   final exists = state.checkedTestes.any((item) => item == testName);

  //   if (!exists) {
  //     state = state.copyWith(checkedTestes: [...state.checkedTestes, testName]);
  //   }
  // }

  // void checkedListRemoval(String testName) {
  //   state = state.copyWith(
  //     checkedTestes: state.checkedTestes
  //         .where((item) => item != testName)
  //         .toList(),
  //   );
  //   log('selected list');
  // }

  // Future<void> testMasterCalling() async {
  //   try {
  //     final TestMasterResponseModel response =
  //         await TestMasterApi.testMasterApi();

  //     if (response.tests != null) {
  //       log(response.tests!.length.toString());
  //       final List<TestMaster> filteredResponse = (response.tests ?? [])
  //           .where(
  //             (item) =>
  //                 item.testName != null && item.testName!.trim().isNotEmpty,
  //           )
  //           .toList();
  //       final List<TestMasterSelected> selectedList = filteredResponse.map((
  //         item,
  //       ) {
  //         return TestMasterSelected(
  //           testKey: item.testKey,
  //           testRate: item.testRate,
  //           testShortCode: item.testShortCode,
  //           testName: item.testName,
  //           testSelected: state.checkedTestes.contains(item.testName),
  //         );
  //       }).toList();
  //       state = state.copyWith(
  //         testMasterList: response.tests ?? [],
  //         testMasterListSeeing: selectedList,
  //       );
  //     }
  //   } catch (e) {
  //     log('conntroller catch : ${e.toString()}');
  //   } finally {}
  // }

  void searchTestMaster(List<TestMasterSelected> search) {
    state = state.copyWith(testMasterListSeeing: search);
  }

  void updateSelectedTestsWithPrice(TestMasterSelected touch) {
    final updatedList = [...state.testMasterListSelected];

    updatedList.add(touch);

    state = state.copyWith(testMasterListSelected: updatedList);
  }

  // void updateSelectedTest({required int? index, required String? name}) {
  //   final updatedList = [...state.testMasterListSeeing];
  //   final updatedListPrice = [...state.finalListNewPrice];
  //   log("Received name: $name");
  //   log("Received index: $index");

  //   if (index != null) {
  //     updatedList[index] = TestMasterSelected(
  //       testKey: updatedList[index].testKey,
  //       testRate: updatedList[index].testRate,
  //       testShortCode: updatedList[index].testShortCode,
  //       testName: updatedList[index].testName,
  //       testSelected: !updatedList[index].testSelected,
  //     );
  //   }
  //   if (name != null) {
  //     log('detetting name :$name');
  //     final itemIndex = updatedList.indexWhere((item) => item.testName == name);

  //     if (itemIndex >= 0) {
  //       log('detetting name :$name');
  //       final item = updatedList[itemIndex];

  //       updatedList[itemIndex] = TestMasterSelected(
  //         testKey: item.testKey,
  //         testRate: item.testRate,
  //         testShortCode: item.testShortCode,
  //         testName: item.testName,
  //         testSelected: false,
  //       );
  //     }
  //     final selectedList = updatedList
  //         .where((item) => item.testSelected == true)
  //         .toList();
  //     num totalPrice =
  //         state.totalPrice -
  //         (updatedListPrice
  //                 .where((e) => e.testName == name)
  //                 .firstOrNull
  //                 ?.testRate ??
  //             0);

  //     state = state.copyWith(
  //       testMasterListSeeing: updatedList,
  //       testMasterListSelected: selectedList,
  //       totalPrice: totalPrice,
  //     );
  //   }

  //   state = state.copyWith(testMasterListSeeing: updatedList);
  // }

  // void updatefinalList(List<TestMasterSelected> tests) {
  //   num totalPrice = 0;
  //   state = state.copyWith(finalListNewPrice: tests);
  //   // if (state.finalListNewPrice.isNotEmpty) {
  //   //   List<TestMasterSelected> getSelectedTests =
  //   //       state.testMasterListSelectedNewPrice;

  //   //   for (TestMasterSelected n in getSelectedTests) {
  //   //     totalPrice += n.testRate ?? 0;
  //   //   }
  //   //   state = state.copyWith(
  //   //     totalPrice: totalPrice,
  //   //     finalListNewPrice: getSelectedTests,
  //   //   );
  //   // } else {
  //   List<TestMasterSelected> getSelectedTests =
  //       state.testMasterListSelectedNewPrice;

  //   for (TestMasterSelected n in getSelectedTests) {
  //     totalPrice += n.testRate ?? 0;
  //   }
  //   state = state.copyWith(
  //     totalPrice: totalPrice,
  //     finalListNewPrice: getSelectedTests,
  //   );
  //   // }
  // }

  // void updateSelectedList() {
  //   num totalPrice = 0;
  //   List<TestMasterSelected> getSelectedTests = state.testMasterListSeeing
  //       .where((item) => item.testSelected == true)
  //       .toList();
  //   for (TestMasterSelected n in getSelectedTests) {
  //     totalPrice += n.testRate ?? 0;
  //   }
  //   state = state.copyWith(
  //     testMasterListSelected: getSelectedTests,
  //     totalPrice: totalPrice,
  //   );
  // }
  void clearState() {
    // Clear controllers
    state.searchController.clear();
    state.specialSchemeController.clear();
    state.discountAmountController.clear();
    state.discountPercentageController.clear();
    state.servicesnargeController.clear();
    state.upiRefferenceIdController.clear();
    state.primaryAmountContoller.clear();
    state.secondaryAmountController.clear();
    state.discountReason.clear();

    // Remove focus
    state.specialSchemeFocusNode.unfocus();

    // Reset state values
    state = state.copyWith(
      discountList: [],
      specialSchemeList: [],
      testMasterList: [],
      testMasterListSeeing: [],
      testMasterListSelected: [],
      testMasterListSelectedNewPrice: [],
      specialSchemeRatesList: [],
      totalPrice: 0,
      schemeIDSelected: 0,
      netAmount: 0,
      amountPaid: 0,
      primaryPaid: 0,
      secondaryPaid: 0,
      balanceAmount: 0,
      primaryType: 'Cash',
      secondaryType: 'UPI',
      isCorporateBilling: false,
      isSpecialschemeOpen: false,
      isSync: 'No',
      isUrgent: false,
    );
  }
}

final addTestScreenProvider =
    StateNotifierProvider<AddTestScreenController, AddTestScreenState>((ref) {
      return AddTestScreenController();
    });
