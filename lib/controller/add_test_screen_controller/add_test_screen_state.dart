import 'package:flutter/material.dart';
import 'package:icon_infoware/models/spot_billing/done_by_search_response_model.dart';
import 'package:icon_infoware/models/spot_billing/special_scheme_rates_response_model.dart';
import 'package:icon_infoware/models/spot_billing/test_add_selection.dart';
import 'package:icon_infoware/models/spot_billing/test_master_response_model.dart';

class AddTestScreenState {
  final List<AccountsList> specialSchemeList;
  final List<TestMaster> testMasterList;
  final List<TestMasterSelected> testMasterListSeeing;
  final TextEditingController specialSchemeController;
  final List<TestMasterSelected> testMasterListSelected;
  final List<TestMasterSelected> testMasterListSelectedNewPrice;
 
  final List<TestMasterSelected> finalListNewPrice;

  final List<SchemeRateList> specialSchemeRatesList;
  final TextEditingController searchController;
  final List<String> checkedTestes;
  final num totalPrice;
  final num schemeIDSelected;
  final FocusNode specialSchemeFocusNode;
  final bool isCorporateBilling;
  final bool isSpecialschemeOpen;
  AddTestScreenState({
    this.specialSchemeList = const [],
    this.specialSchemeRatesList = const [],
    this.testMasterList = const [],
    this.testMasterListSeeing = const [],
    this.testMasterListSelected = const [],
    this.checkedTestes = const [],
    this.testMasterListSelectedNewPrice = const [],
    this.finalListNewPrice = const [],

    this.totalPrice = 0,
    this.schemeIDSelected = 0,
    this.isCorporateBilling = false,
    this.isSpecialschemeOpen = false,
    required this.searchController,
    required this.specialSchemeFocusNode,
    required this.specialSchemeController,
  });
  AddTestScreenState copyWith({
    List<AccountsList>? specialSchemeList,
    List<TestMaster>? testMasterList,
    List<TestMasterSelected>? testMasterListSeeing,
    List<TestMasterSelected>? testMasterListSelected,
    List<TestMasterSelected>? testMasterListSelectedNewPrice,
    List<TestMasterSelected>? finalListNewPrice,
    FocusNode? specialSchemeFocusNode,
    TextEditingController? searchController,
    TextEditingController? specialSchemeController,
    List<SchemeRateList>? specialSchemeRatesList,
    List<String>? checkedTestes,
    num? schemeIDSelected,
    num? totalPrice,
    bool? isCorporateBilling,
    bool? isSpecialschemeOpen,
  }) {
    return AddTestScreenState(
      specialSchemeList: specialSchemeList ?? this.specialSchemeList,
      testMasterList: testMasterList ?? this.testMasterList,
      searchController: searchController ?? this.searchController,
      testMasterListSeeing: testMasterListSeeing ?? this.testMasterListSeeing,
      schemeIDSelected: schemeIDSelected ?? this.schemeIDSelected,
      specialSchemeController:
          specialSchemeController ?? this.specialSchemeController,
      specialSchemeRatesList:
          specialSchemeRatesList ?? this.specialSchemeRatesList,
      specialSchemeFocusNode:
          specialSchemeFocusNode ?? this.specialSchemeFocusNode,
      finalListNewPrice: finalListNewPrice ?? this.finalListNewPrice,
      testMasterListSelectedNewPrice:
          testMasterListSelectedNewPrice ?? this.testMasterListSelectedNewPrice,
      testMasterListSelected:
          testMasterListSelected ?? this.testMasterListSelected,
      checkedTestes: checkedTestes ?? this.checkedTestes,
      totalPrice: totalPrice ?? this.totalPrice,
      isCorporateBilling: isCorporateBilling ?? this.isCorporateBilling,
      isSpecialschemeOpen: isSpecialschemeOpen ?? this.isSpecialschemeOpen,
    );
  }
}
