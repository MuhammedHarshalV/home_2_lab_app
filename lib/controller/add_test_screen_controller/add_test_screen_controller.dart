import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icon_infoware/apis/spot_billing/special_scheme_rates_api.dart';
import 'package:icon_infoware/apis/spot_billing/test_master_api.dart';
import 'package:icon_infoware/controller/add_test_screen_controller/add_test_screen_state.dart';

import 'package:icon_infoware/models/spot_billing/done_by_search_response_model.dart';
import 'package:icon_infoware/models/spot_billing/test_add_selection.dart';

class AddTestScreenController extends StateNotifier<AddTestScreenState> {
  AddTestScreenController()
    : super(
        AddTestScreenState(
          searchController: TextEditingController(),
          specialSchemeController: TextEditingController(),
          specialSchemeFocusNode: FocusNode(),
        ),
      ) {
    Future.microtask(() {
      testMasterCalling();
      specialRatesFetch();
    });
  }

  void updatestate({
    List<AccountsList>? specialSchemeList,
    List<TestMasterSelected>? testMasterListSeeing,
    num? schemeIDSelected,
    bool? isCorporateBilling,
    bool? isSpecialschemeOpen,
  }) {
    state = state.copyWith(
      specialSchemeList: specialSchemeList,
      testMasterListSeeing: testMasterListSeeing,
      schemeIDSelected: schemeIDSelected,
      isCorporateBilling: isCorporateBilling,
      isSpecialschemeOpen: isCorporateBilling,
    );
  }

  void updateSpecialSchemePrice() {
    final updatedList = state.finalListNewPrice.map((test) {
      num price = test.testRate ?? 0;
      log(
        'controller schemeid selected  :${state.schemeIDSelected.toString()}',
      );
      // first check testKey == selectedSchemeId
      if (test.testKey == state.schemeIDSelected) {
        log(
          'controller schemeid selected if:${state.schemeIDSelected.toString()}',
        );
        // then check matching scheme rate
        final matchedItem = state.specialSchemeRatesList
            .where((item) => item.schRTstid == state.schemeIDSelected)
            .first;

        price = matchedItem.schRate ?? price;
      }

      return TestMasterSelected(
        testKey: test.testKey,
        testRate: price,
        testShortCode: test.testShortCode,
        testName: test.testName,
        testSelected: test.testSelected,
      );
    }).toList();

    num totalPrice = 0;
    List<TestMasterSelected> getSelectedTests = updatedList;

    for (TestMasterSelected n in getSelectedTests) {
      totalPrice += n.testRate ?? 0;
    }

    state = state.copyWith(
      finalListNewPrice: updatedList,
      totalPrice: totalPrice,
    );
    log('new final list ${state.finalListNewPrice.toList()}');
    log('new total price :${state.totalPrice.toString()}');
  }

  Future<void> specialRatesFetch() async {
    try {
      final response = await SpecialSchemeRatesApi.specialSchemesApi();
      state = state.copyWith(specialSchemeRatesList: response);
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
  }

  Future<void> removalFinalList(String name) async {
    state = state.copyWith(
      finalListNewPrice: state.finalListNewPrice
          .where((item) => item.testName != name)
          .toList(),
    );
  }

  Future<void> checkedList(String testName) async {
    final exists = state.checkedTestes.any((item) => item == testName);

    if (!exists) {
      state = state.copyWith(checkedTestes: [...state.checkedTestes, testName]);
    }
  }

  void checkedListRemoval(String testName) {
    state = state.copyWith(
      checkedTestes: state.checkedTestes
          .where((item) => item != testName)
          .toList(),
    );
  }

  Future<void> testMasterCalling() async {
    try {
      final response = await TestMasterApi.testMasterApi();

      log(response.length.toString());
      final filteredResponse = response
          .where(
            (item) => item.testName != null && item.testName!.trim().isNotEmpty,
          )
          .toList();
      final List<TestMasterSelected> selectedList = filteredResponse.map((
        item,
      ) {
        return TestMasterSelected(
          testKey: item.testKey,
          testRate: item.testRate,
          testShortCode: item.testShortCode,
          testName: item.testName,
          testSelected: state.checkedTestes.contains(item.testName),
        );
      }).toList();
      state = state.copyWith(
        testMasterList: filteredResponse,
        testMasterListSeeing: selectedList,
      );
    } catch (e) {
      log('conntroller catch : ${e.toString()}');
    } finally {}
  }

  void searchTestMaster(List<TestMasterSelected> search) {
    state = state.copyWith(testMasterListSeeing: search);
  }

  void updateSelectedTestsWithPrice(TestMasterSelected touch) {
    final updatedList = [...state.testMasterListSelected];

    updatedList.add(touch);

    state = state.copyWith(testMasterListSelected: updatedList);
  }

  void updateSelectedTest({required int? index, required String? name}) {
    final updatedList = [...state.testMasterListSeeing];
    final updatedListPrice = [...state.finalListNewPrice];

    if (index != null) {
      updatedList[index] = TestMasterSelected(
        testKey: updatedList[index].testKey,
        testRate: updatedList[index].testRate,
        testShortCode: updatedList[index].testShortCode,
        testName: updatedList[index].testName,
        testSelected: !updatedList[index].testSelected,
      );
    }
    if (name != null) {
      log('detetting name :$name');
      final itemIndex = updatedList.indexWhere((item) => item.testName == name);

      if (itemIndex >= 0) {
        log('detetting name :$name');
        final item = updatedList[itemIndex];

        updatedList[itemIndex] = TestMasterSelected(
          testKey: item.testKey,
          testRate: item.testRate,
          testShortCode: item.testShortCode,
          testName: item.testName,
          testSelected: false,
        );
      }
      final selectedList = updatedList
          .where((item) => item.testSelected == true)
          .toList();
      num totalPrice =
          state.totalPrice -
          (updatedListPrice
                  .where((e) => e.testName == name)
                  .firstOrNull
                  ?.testRate ??
              0);

      state = state.copyWith(
        testMasterListSeeing: updatedList,
        testMasterListSelected: selectedList,
        totalPrice: totalPrice,
      );
    }

    state = state.copyWith(testMasterListSeeing: updatedList);
  }

  void updatefinalList() {
    num totalPrice = 0;
    // if (state.finalListNewPrice.isNotEmpty) {
    //   List<TestMasterSelected> getSelectedTests =
    //       state.testMasterListSelectedNewPrice;

    //   for (TestMasterSelected n in getSelectedTests) {
    //     totalPrice += n.testRate ?? 0;
    //   }
    //   state = state.copyWith(
    //     totalPrice: totalPrice,
    //     finalListNewPrice: getSelectedTests,
    //   );
    // } else {
    List<TestMasterSelected> getSelectedTests =
        state.testMasterListSelectedNewPrice;

    for (TestMasterSelected n in getSelectedTests) {
      totalPrice += n.testRate ?? 0;
    }
    state = state.copyWith(
      totalPrice: totalPrice,
      finalListNewPrice: getSelectedTests,
    );
    // }
  }

  void updateSelectedList() {
    num totalPrice = 0;
    List<TestMasterSelected> getSelectedTests = state.testMasterListSeeing
        .where((item) => item.testSelected == true)
        .toList();
    for (TestMasterSelected n in getSelectedTests) {
      totalPrice += n.testRate ?? 0;
    }
    state = state.copyWith(
      testMasterListSelected: getSelectedTests,
      totalPrice: totalPrice,
    );
  }
}

final addTestScreenProvider =
    StateNotifierProvider<AddTestScreenController, AddTestScreenState>((ref) {
      return AddTestScreenController();
    });
