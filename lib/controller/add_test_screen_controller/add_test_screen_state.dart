import 'package:flutter/material.dart';
import 'package:icon_infoware/models/spot_billing/done_by_search_response_model.dart';
import 'package:icon_infoware/models/spot_billing/special_scheme_rates_response_model.dart';
import 'package:icon_infoware/models/spot_billing/test_add_selection.dart';
import 'package:icon_infoware/models/spot_billing/test_master_response_model.dart';

class AddTestScreenState {
  final List<AccountsList> specialSchemeList;
  final List<TestMaster> testMasterList;
  final List<TestMasterSelected> testMasterListSeeing;
  final List<TestMasterSelected> testMasterListSelected;
  final List<SchemeRateList> specialSchemeRalesList;
  final TextEditingController searchController;
  final List<String> checkedTestes;
  final num totalPrice;
  final int schemeIDSelected;

  final bool isCorporateBilling;
  final bool isSpecialschemeOpen;
  AddTestScreenState({
    this.specialSchemeList = const [],
    this.specialSchemeRalesList = const [],
    this.testMasterList = const [],
    this.testMasterListSeeing = const [],
    this.testMasterListSelected = const [],
    this.checkedTestes = const [],
    this.totalPrice = 0,
    this.schemeIDSelected = 0,
    this.isCorporateBilling = false,
    this.isSpecialschemeOpen = false,
    required this.searchController,
  });
  AddTestScreenState copyWith({
    List<AccountsList>? specialSchemeList,
    List<TestMaster>? testMasterList,
    List<TestMasterSelected>? testMasterListSeeing,
    List<TestMasterSelected>? testMasterListSelected,
    TextEditingController? searchController,
    List<SchemeRateList>? specialSchemeRalesList,
    List<String>? checkedTestes,
    int? schemeIDSelected,
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
      specialSchemeRalesList:
          specialSchemeRalesList ?? this.specialSchemeRalesList,
      testMasterListSelected:
          testMasterListSelected ?? this.testMasterListSelected,
      checkedTestes: checkedTestes ?? this.checkedTestes,
      totalPrice: totalPrice ?? this.totalPrice,
      isCorporateBilling: isCorporateBilling ?? this.isCorporateBilling,
      isSpecialschemeOpen: isSpecialschemeOpen ?? this.isSpecialschemeOpen,
    );
  }
}
