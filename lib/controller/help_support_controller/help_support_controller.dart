import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icon_infoware/apis/help_support_fetching/help_support_api.dart';

import 'package:icon_infoware/controller/help_support_controller/help_support_state.dart';
import 'package:icon_infoware/models/help_support_response/help_support_response_model.dart';

class HelpSupportController extends StateNotifier<HelpSupportState> {
  HelpSupportController() : super(HelpSupportState()) {
    helpSupportApi(null);
  }
  Future<void> helpSupportApi(BuildContext? context) async {
    try {
      state = state.copyWith(isLoading: true);
      final HelpSupportResponseModel? response =
          await HelpSupportApi.helpSupportApi(context: context);
      if (response != null && response.success == true) {
        state = state.copyWith(
          helpAndSupport: response.helpAndSupport,
          privacyPolicy: response.privacyPolicy,
          termsAndConditions: response.termsAndConditions,
        );
      }
    } catch (e) {
      log(e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  @override
  void dispose() {
    log('===========Help and support Disposed===========');
    super.dispose();
  }
}

final helpAndSupportProvider =
    StateNotifierProvider.autoDispose<HelpSupportController, HelpSupportState>((
      ref,
    ) {
      return HelpSupportController();
    });
