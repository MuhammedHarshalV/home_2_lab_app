class OrderDetailsScreenState {
  final int selectedTabIndex;

  const OrderDetailsScreenState({this.selectedTabIndex = 0});

  OrderDetailsScreenState copyWith({int? selectedTabIndex}) {
    return OrderDetailsScreenState(
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
    );
  }
}
