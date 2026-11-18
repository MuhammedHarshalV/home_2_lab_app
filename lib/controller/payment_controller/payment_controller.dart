import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icon_infoware/apis/spot_billing/patient_syncing_api.dart';
import 'package:icon_infoware/controller/payment_controller/payment_state.dart';
import 'package:icon_infoware/core/errors/api_errors/api_errors.dart';
import 'package:icon_infoware/models/patient_bill_syncing_model/patient_bill_syncing_model.dart';

class PaymentController extends StateNotifier<PaymentState> {
  PaymentController() : super(const PaymentState());

  // Initialize checkbox list
  void initializePatientList(List<PatientHiveModel> patients) {
    state = state.copyWith(
      isCompleteList: List.generate(patients.length, (index) => false),
    );
  }

  final primaryController = TextEditingController();
  final secondaryController = TextEditingController();
  // Update primary payment amount
  void updatePrimaryAmount(String value) {
    final amount = num.tryParse(value) ?? 0;

    state = state.copyWith(primaryAmount: amount);
    final gross = state.grossAmount;
    final discount = state.discountAmount;
    final service = state.serviceAmount;

    final net = gross - discount + service;
    final paid = state.primaryAmount + state.secondaryAmount;
    final balance = net - paid;

    state = state.copyWith(
      netAmount: net,
      paidAmount: paid,
      balanceAmount: balance,
    );
  }

  // Update secondary payment amount
  void updateSecondaryAmount(String value) {
    final amount = num.tryParse(value) ?? 0;

    state = state.copyWith(secondaryAmount: amount);
    final gross = state.grossAmount;
    final discount = state.discountAmount;
    final service = state.serviceAmount;

    final net = gross - discount + service;
    final paid = state.primaryAmount + state.secondaryAmount;
    final balance = net - paid;

    state = state.copyWith(
      netAmount: net,
      paidAmount: paid,
      balanceAmount: balance,
    );
  }

  //split payment

  Future<bool> splitPayments({BuildContext? context}) async {
    if (state.balanceAmount < 0) {
      AppMessage.show(context!, "Payment amount exceeds the total bill amount");
      return false;
    }

    if (state.grossAmount <= 0) {
      AppMessage.show(
        context!,
        "Please add tests to the bill before making payment",
      );
      return false;
    }

    state = state.copyWith(isPaymentCompletion: true);

    num primaryRemaining = state.primaryAmount;
    num secondaryRemaining = state.secondaryAmount;

    final List<PatientHiveModel> updatedList = [];

    for (final patient in state.patientList) {
      num patientBalance = patient.balance ?? 0;

      num primaryPaid = 0;
      num secondaryPaid = 0;

      // Allocate entered Primary amount
      if (primaryRemaining > 0 && patientBalance > 0) {
        primaryPaid = primaryRemaining >= patientBalance
            ? patientBalance
            : primaryRemaining;

        primaryRemaining -= primaryPaid;
        patientBalance -= primaryPaid;
      }

      // Allocate entered Secondary amount
      if (secondaryRemaining > 0 && patientBalance > 0) {
        secondaryPaid = secondaryRemaining >= patientBalance
            ? patientBalance
            : secondaryRemaining;

        secondaryRemaining -= secondaryPaid;
        patientBalance -= secondaryPaid;
      }

      // Original payment types
      String primaryType = state.primaryPaymentType;
      String secondaryType = state.secondaryPaymentType;

      // Swap separately for each patient if Secondary is higher
      if (secondaryPaid > primaryPaid) {
        final tempAmount = primaryPaid;
        primaryPaid = secondaryPaid;
        secondaryPaid = tempAmount;

        final tempType = primaryType;
        primaryType = secondaryType;
        secondaryType = tempType;
      }

      final num totalPaid = primaryPaid + secondaryPaid;

      // UPI reference
      String upiReference = '';

      if ((primaryPaid > 0 && primaryType == 'UPI') ||
          (secondaryPaid > 0 && secondaryType == 'UPI')) {
        upiReference = state.upiReferenceId;
      }

      updatedList.add(
        patient.copyWith(
          primaryPaid: primaryPaid,
          secondaryPaid: secondaryPaid,
          primaryType: primaryPaid > 0 ? primaryType : '',
          secondaryType: secondaryPaid > 0 ? secondaryType : '',
          upiReferenceId: upiReference,
          paidAmt: (patient.paidAmt ?? 0) + totalPaid,
          balance: patientBalance,
        ),
      );
    }

    final num totalPaid = updatedList.fold<num>(
      0,
      (sum, patient) =>
          sum + (patient.primaryPaid ?? 0) + (patient.secondaryPaid ?? 0),
    );

    final num totalBalance = updatedList.fold<num>(
      0,
      (sum, patient) => sum + (patient.balance ?? 0),
    );

    state = state.copyWith(
      patientList: updatedList,
      paidAmount: totalPaid,
      balanceAmount: totalBalance,
    );

    log('========== UPDATED PATIENT LIST ==========');

    for (final patient in updatedList) {
      log('''
Patient: ${patient.patName}
Invoice: ${patient.invNo}
Primary Type: ${patient.primaryType}
Primary Paid: ${patient.primaryPaid}
Secondary Type: ${patient.secondaryType}
Secondary Paid: ${patient.secondaryPaid}
UPI Reference: ${patient.upiReferenceId}
Total Paid: ${patient.paidAmt}
Remaining Balance: ${patient.balance}
------------------------------------------
''');
    }

    final bool syncing = await patientBillSyncingApi(
      context: context,
      patient: updatedList,
    );

    log('Sync status : $syncing');

    return syncing;
  }

  // bill syncing api
  Future<bool> patientBillSyncingApi({
    required BuildContext? context,
    required List<PatientHiveModel> patient,
  }) async {
    try {
      final bool response = await PatientSyncingApi.patientSyncingApi(
        patients: patient,
        context: context,
        syncId: null,
      );
      log('syncing response :$response');
      if (response == true) {}
      return response;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  // Add or remove selected patient
  void updatePatientSelection(
    int index,
    PatientHiveModel patient,
    bool isSelected,
  ) {
    final updatedCheckboxList = List<bool>.from(state.isCompleteList);
    final updatedPatientList = List<PatientHiveModel>.from(state.patientList);

    updatedCheckboxList[index] = isSelected;

    num grossAmount = state.grossAmount;
    num discountAmount = state.discountAmount;
    num serviceAmount = state.serviceAmount;

    if (isSelected) {
      updatedPatientList.add(patient);

      grossAmount += patient.grossAmt ?? 0;
      discountAmount += patient.discAmt ?? 0;
      serviceAmount += patient.servChrge ?? 0;
    } else {
      updatedPatientList.remove(patient);

      grossAmount -= patient.grossAmt ?? 0;
      discountAmount -= patient.discAmt ?? 0;
      serviceAmount -= patient.servChrge ?? 0;
    }

    final netAmount = grossAmount - discountAmount + serviceAmount;

    final paidAmount = state.primaryAmount + state.secondaryAmount;
    final balanceAmount = netAmount - paidAmount;

    state = state.copyWith(
      isCompleteList: updatedCheckboxList,
      patientList: updatedPatientList,
      totalAmount: updatedPatientList.fold<num>(
        0,
        (sum, item) => sum + (item.balance ?? 0),
      ),
      grossAmount: grossAmount,
      discountAmount: discountAmount,
      serviceAmount: serviceAmount,
      netAmount: netAmount,
      paidAmount: paidAmount,
      balanceAmount: balanceAmount,
    );
  }

  //upi refference id setting
  void updateState({
    String? upiReferenceId,
    String? primaryType,
    String? secondaryType,
    bool? isPaymentCompletion,
  }) {
    state = state.copyWith(
      upiReferenceId: upiReferenceId,
      primaryPaymentType: primaryType,
      secondaryPaymentType: secondaryType,
      isPaymentCompletion: isPaymentCompletion,
    );
  }

  void clearPaymentState() {
    primaryController.clear();
    secondaryController.clear();

    state = state.copyWith(
      // Payment details
      primaryPaymentType: 'Cash',
      secondaryPaymentType: 'UPI',
      primaryAmount: 0,
      secondaryAmount: 0,
      upiReferenceId: '',

      // Bill amounts
      grossAmount: 0,
      discountAmount: 0,
      serviceAmount: 0,
      netAmount: 0,
      paidAmount: 0,
      balanceAmount: 0,
      patientList: [],
      isCompleteList: [],
      totalAmount: 0,

      // Completion status
      isPaymentCompletion: false,
    );
  }

  @override
  void dispose() {
    log("===== payment section dispose =====");
    super.dispose();
  }
}

final paymentScreenProvider =
    StateNotifierProvider.autoDispose<PaymentController, PaymentState>((ref) {
      return PaymentController();
    });
