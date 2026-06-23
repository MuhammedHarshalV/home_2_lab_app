import 'package:icon_infoware/models/spot_billing/test_add_selection.dart';

class StoreTestsHiveState {
  final List<TestMasterSelected> finalListNewPrice;
  final int schemeIDSelected;
  StoreTestsHiveState({
    this.finalListNewPrice = const [],
    this.schemeIDSelected = 0,
  });
  StoreTestsHiveState copyWith({
    List<TestMasterSelected>? finalListNewPrice,
    int? schemeIDSelected,
  }) {
    return StoreTestsHiveState(
      finalListNewPrice: finalListNewPrice ?? this.finalListNewPrice,
      schemeIDSelected: schemeIDSelected ?? this.schemeIDSelected,
    );
  }
}
