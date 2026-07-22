import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:icon_infoware/apis/spot_billing/cash_closing_api.dart';
import 'package:icon_infoware/controller/cash_closer_controller/cash_closer_state.dart';
import 'package:icon_infoware/core/errors/api_errors/api_errors.dart';
import 'package:icon_infoware/models/patient_bill_syncing_model/patient_bill_syncing_model.dart';

class CashClosingController extends StateNotifier<CashCloserState> {
  CashClosingController() : super(CashCloserState());
  Future<bool> cashClosingApi({
    required List<PatientHiveModel> patients,
    required BuildContext context,
  }) async {
    try {
      state = state.copyWith(isLoading: true);
      if (patients.isEmpty) {
        context.pop();
        AppMessage.show(context, "No Synced data Available.");
        return false;
      }
      final bool response = await CashClosingApi.cashClosingApi(
        patients: patients,
        context: context,
      );
      if (response == true) {
        context.pop();
        AppMessage.show(context, "Cash closing has been successfully synced.");
        return true;
      }
      return false;
    } catch (e) {
      log(e.toString());
      return false;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  @override
  void dispose() {
    log(
      '===================CashClosingController disposed=======================',
    );
    super.dispose();
  }
}

final cashCloserProvider =
    StateNotifierProvider.autoDispose<CashClosingController, CashCloserState>((
      ref,
    ) {
      return CashClosingController();
    });
