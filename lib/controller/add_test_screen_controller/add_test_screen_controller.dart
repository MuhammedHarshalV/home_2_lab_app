import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icon_infoware/apis/spot_billing/test_master_api.dart';
import 'package:icon_infoware/controller/add_test_screen_controller/add_test_screen_state.dart';

import 'package:icon_infoware/models/spot_billing/done_by_search_response_model.dart';

class AddTestScreenController extends StateNotifier<AddTestScreenState> {
  AddTestScreenController() : super(AddTestScreenState()) {
    testMasterCalling();
  }

  void updatestate({
    List<AccountsList>? specialSchemeList,
    bool? isCorporateBilling,
    bool? isSpecialschemeOpen,
  }) {
    state = state.copyWith(
      specialSchemeList: specialSchemeList,
      isCorporateBilling: isCorporateBilling,
      isSpecialschemeOpen: isCorporateBilling,
    );
  }

  Future<void> testMasterCalling() async {
    try {
      final response = await TestMasterApi.testMasterApi();
      log("response in controller :${response.toString()}");
      log(response.length.toString());
      state = state.copyWith(testMasterList: response);
    } catch (e) {
      log('conntroller catch : ${e.toString()}');
    } finally {}
  }
}

final addTestScreenProvider =
    StateNotifierProvider<AddTestScreenController, AddTestScreenState>((ref) {
      return AddTestScreenController();
    });
