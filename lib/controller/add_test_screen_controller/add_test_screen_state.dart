import 'package:icon_infoware/models/spot_billing/done_by_search_response_model.dart';
import 'package:icon_infoware/models/spot_billing/test_master_response_model.dart';

class AddTestScreenState {
  final List<AccountsList> specialSchemeList;
  final List<TestMaster> testMasterList;
  final bool isCorporateBilling;
  final bool isSpecialschemeOpen;
  AddTestScreenState({
    this.specialSchemeList = const [],
    this.testMasterList = const [],

    this.isCorporateBilling = false,
    this.isSpecialschemeOpen = false,
  });
  AddTestScreenState copyWith({
    List<AccountsList>? specialSchemeList,
    List<TestMaster>? testMasterList,
    bool? isCorporateBilling,
    bool? isSpecialschemeOpen,
  }) {
    return AddTestScreenState(
      specialSchemeList: specialSchemeList ?? this.specialSchemeList,
      testMasterList: testMasterList ?? this.testMasterList,
      isCorporateBilling: isCorporateBilling ?? this.isCorporateBilling,
      isSpecialschemeOpen: isSpecialschemeOpen ?? this.isSpecialschemeOpen,
    );
  }
}
