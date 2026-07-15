import 'package:flutter/material.dart';

import 'package:icon_infoware/models/spot_billing/done_by_search_response_model.dart';
import 'package:icon_infoware/models/spot_billing/normal_special_rates_response_model.dart';
import 'package:icon_infoware/models/spot_billing/special_scheme_rates_response_model.dart';
import 'package:icon_infoware/models/spot_billing/test_add_selection.dart';
import 'package:icon_infoware/models/spot_billing/test_master_response_model.dart';

class AddTestScreenState {
  final bool isSpecialLoading;
  final bool isTestSync;
  final bool isSyncLoading;
  final List<String> discountList;
  final List<AccountsList> specialSchemeList;
  final List<TestMaster> testMasterList;
  final List<TestMasterSelected> testMasterListSeeing;
  final TextEditingController specialSchemeController;
  final List<TestMasterSelected> testMasterListSelected;
  final List<TestMasterSelected> testMasterListSelectedNewPrice;
  final List<SpclRateList> normalSpecialRates;
  final TextEditingController discountAmountController;
  final TextEditingController discountPercentageController;
  final TextEditingController servicesnargeController;
  final TextEditingController upiRefferenceIdController;
  final TextEditingController primaryAmountContoller;
  final TextEditingController secondaryAmountController;
  final String secondaryType;
  final TextEditingController discountReason;
  final String primaryType;
  final String cardName;
  final num netAmount;
  final num amountPaid;
  final num primaryPaid;
  final num secondaryPaid;
  final String isSync;
  final num balanceAmount;
  final bool isUrgent;

  final List<SchemeRateList> specialSchemeRatesList;
  final TextEditingController searchController;
  // final List<String> checkedTestes;
  final num totalPrice;
  final int schemeIDSelected;
  final num rateIDSelected;
  final FocusNode specialSchemeFocusNode;
  final bool isCorporateBilling;
  final bool isSpecialschemeOpen;
  AddTestScreenState({
    this.isSpecialLoading = false,
    this.isTestSync = false,
    this.isUrgent = false,
    this.isSyncLoading = false,
    required this.discountReason,
    this.cardName = 'Home',
    this.secondaryPaid = 0,
    this.primaryPaid = 0,
    this.discountList = const [],
    this.normalSpecialRates = const [],

    this.specialSchemeList = const [],
    this.specialSchemeRatesList = const [],
    this.testMasterList = const [],
    this.testMasterListSeeing = const [],
    this.testMasterListSelected = const [],
    // this.checkedTestes = const [],
    this.testMasterListSelectedNewPrice = const [],
    this.isSync = 'No',
    this.totalPrice = 0,
    this.schemeIDSelected = 0,
    this.rateIDSelected = 0,
    this.isCorporateBilling = false,
    this.isSpecialschemeOpen = false,
    required this.searchController,
    required this.specialSchemeFocusNode,
    required this.specialSchemeController,
    required this.discountAmountController,
    required this.discountPercentageController,
    required this.servicesnargeController,
    required this.upiRefferenceIdController,
    required this.primaryAmountContoller,
    required this.secondaryAmountController,
    this.secondaryType = 'UPI',
    this.netAmount = 0,
    this.amountPaid = 0,
    this.balanceAmount = 0,
    this.primaryType = 'Cash',
  });
  AddTestScreenState copyWith({
    bool? isSpecialLoading,
    bool? isTestSync,
    bool? isUrgent,
    bool? isSyncLoading,
    List<String>? discountList,
    TextEditingController? discountReason,
    List<AccountsList>? specialSchemeList,
    List<TestMaster>? testMasterList,
    List<SpclRateList>? normalSpecialRates,

    List<TestMasterSelected>? testMasterListSeeing,
    List<TestMasterSelected>? testMasterListSelected,
    List<TestMasterSelected>? testMasterListSelectedNewPrice,
    String? cardName,
    num? primaryPaid,
    num? secondaryPaid,
    String? isSync,
    FocusNode? specialSchemeFocusNode,
    TextEditingController? searchController,
    TextEditingController? specialSchemeController,
    TextEditingController? discountAmountController,
    TextEditingController? discountPercentageController,
    TextEditingController? servicesnargeController,
    TextEditingController? upiRefferenceIdController,
    TextEditingController? primaryAmountContoller,
    TextEditingController? secondaryAmountController,
    List<SchemeRateList>? specialSchemeRatesList,
    // List<String>? checkedTestes,
    int? schemeIDSelected,
    num? rateIDSelected,
    num? totalPrice,
    num? netAmount,
    num? amountPaid,
    num? balanceAmount,
    String? secondaryType,
    String? primaryType,
    bool? isCorporateBilling,
    bool? isSpecialschemeOpen,
  }) {
    return AddTestScreenState(
      isSpecialLoading: isSpecialLoading ?? this.isSpecialLoading,
      isTestSync: isTestSync ?? this.isTestSync,
      isUrgent: isUrgent ?? this.isUrgent,
      isSyncLoading: isSyncLoading ?? this.isSyncLoading,
      discountList: discountList ?? this.discountList,
      specialSchemeList: specialSchemeList ?? this.specialSchemeList,
      testMasterList: testMasterList ?? this.testMasterList,
      searchController: searchController ?? this.searchController,
      testMasterListSeeing: testMasterListSeeing ?? this.testMasterListSeeing,
      schemeIDSelected: schemeIDSelected ?? this.schemeIDSelected,
      rateIDSelected: rateIDSelected ?? this.rateIDSelected,
      specialSchemeController:
          specialSchemeController ?? this.specialSchemeController,
      specialSchemeRatesList:
          specialSchemeRatesList ?? this.specialSchemeRatesList,
      specialSchemeFocusNode:
          specialSchemeFocusNode ?? this.specialSchemeFocusNode,
      normalSpecialRates: normalSpecialRates ?? this.normalSpecialRates,
      cardName: cardName ?? this.cardName,
      testMasterListSelectedNewPrice:
          testMasterListSelectedNewPrice ?? this.testMasterListSelectedNewPrice,
      testMasterListSelected:
          testMasterListSelected ?? this.testMasterListSelected,
      primaryPaid: primaryPaid ?? this.primaryPaid,
      secondaryPaid: secondaryPaid ?? this.secondaryPaid,
      //checkedTestes: checkedTestes ?? this.checkedTestes,
      totalPrice: totalPrice ?? this.totalPrice,
      isCorporateBilling: isCorporateBilling ?? this.isCorporateBilling,
      isSpecialschemeOpen: isSpecialschemeOpen ?? this.isSpecialschemeOpen,
      discountAmountController:
          discountAmountController ?? this.discountAmountController,

      discountPercentageController:
          discountPercentageController ?? this.discountPercentageController,

      servicesnargeController:
          servicesnargeController ?? this.servicesnargeController,

      upiRefferenceIdController:
          upiRefferenceIdController ?? this.upiRefferenceIdController,

      primaryAmountContoller:
          primaryAmountContoller ?? this.primaryAmountContoller,

      secondaryAmountController:
          secondaryAmountController ?? this.secondaryAmountController,
      primaryType: primaryType ?? this.primaryType,
      secondaryType: secondaryType ?? this.secondaryType,
      balanceAmount: balanceAmount ?? this.balanceAmount,
      amountPaid: amountPaid ?? this.amountPaid,
      netAmount: netAmount ?? this.netAmount,
      discountReason: discountReason ?? this.discountReason,
      isSync: isSync ?? this.isSync,
    );
  }
}
