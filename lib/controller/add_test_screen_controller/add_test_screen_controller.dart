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
    : super(AddTestScreenState(searchController: TextEditingController())) {
    Future.microtask(() {
      testMasterCalling();
      specialRatesFetch();
    });
  }

  void updatestate({
    List<AccountsList>? specialSchemeList,
    List<TestMasterSelected>? testMasterListSeeing,
    int? schemeIDSelected,
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

  Future<void> specialRatesFetch() async {
    try {
      final response = await SpecialSchemeRatesApi.specialSchemesApi();
      state = state.copyWith(specialSchemeRalesList: response);
    } catch (e) {
      log('conntroller catch : ${e.toString()}');
    }
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
          testSelected: false, // initial value
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
      final itemIndex = updatedList.indexWhere((item) => item.testName == name);

      if (itemIndex >= 0) {
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
      num totalPrice = state.totalPrice - updatedList[itemIndex].testRate!;

      state = state.copyWith(
        testMasterListSeeing: updatedList,
        testMasterListSelected: selectedList,
        totalPrice: totalPrice,
      );
    }

    state = state.copyWith(testMasterListSeeing: updatedList);
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
