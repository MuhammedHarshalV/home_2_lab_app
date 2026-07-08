import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icon_infoware/apis/banking_details_fetching/banking_details_fetching_api.dart';
import 'package:icon_infoware/controller/progress_screen_controller/bank_fetching_state.dart';
import 'package:icon_infoware/core/constants/app_constance.dart';
import 'package:icon_infoware/models/banking_fetching/banking_fetching_response_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BankFetchingController extends StateNotifier<BankFetchingState> {
  BankFetchingController() : super(const BankFetchingState());
  // @override
  // void dispose() {
  //   log(
  //     'bank fetching controller disposed---------------------------------------------------------',
  //   );
  //   super.dispose();
  // }

  Future<void> bankFetchingApi(BuildContext context) async {
    try {
      state = state.copyWith(isLoading: true);
      if (state.bankFetching.isEmpty) {
        final BankFetchingResponseModel? response =
            await BankingDetailsFetchingApi.bankingDetailsFetchingApi(
              context: context,
            );
        if (response != null && response.bankList != null) {
          state = state.copyWith(bankFetching: response.bankList ?? []);
        }
      }
    } catch (e) {
      log(e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  //store upiid to phone storage
  Future<void> storeUpiId({required String? upiId}) async {
    final trimmedUpiId = upiId?.trim();

    if (trimmedUpiId == null || trimmedUpiId.isEmpty) {
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('upiId', trimmedUpiId);
    AppConstants.upiPaymentId = trimmedUpiId;
  }
}

final bankFetchingProvider =
    StateNotifierProvider<BankFetchingController, BankFetchingState>((ref) {
      return BankFetchingController();
    });
