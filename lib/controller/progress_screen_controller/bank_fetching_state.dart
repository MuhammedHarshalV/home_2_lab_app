import 'package:icon_infoware/models/banking_fetching/banking_fetching_response_model.dart';

class BankFetchingState {
  final bool isLoading;
  final List<BankList> bankFetching;
  
  const BankFetchingState({
    this.isLoading = false,
    this.bankFetching = const [],
  
  });

  BankFetchingState copyWith({
    bool? isLoading,
    List<BankList>? bankFetching,
   
  }) {
    return BankFetchingState(
      isLoading: isLoading ?? this.isLoading,
      bankFetching: bankFetching ?? this.bankFetching,
   
    );
  }
}
