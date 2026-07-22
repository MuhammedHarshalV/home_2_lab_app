class CashCloserState {
  final bool isLoading;

  const CashCloserState({this.isLoading = false});

  CashCloserState copyWith({bool? isLoading}) {
    return CashCloserState(isLoading: isLoading ?? this.isLoading);
  }
}
