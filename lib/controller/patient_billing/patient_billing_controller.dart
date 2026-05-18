import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icon_infoware/apis/spot_billing/done_by_search_api.dart';
import 'package:icon_infoware/apis/spot_billing/search_patient_api.dart';
import 'package:icon_infoware/controller/patient_billing/patient_billing_state.dart';
import 'package:icon_infoware/models/spot_billing/done_by_search_response_model.dart';

import 'package:icon_infoware/models/spot_billing/search_patient_response_model.dart';

class PatientBillingController extends StateNotifier<PatientBillingState> {
  PatientBillingController()
    : super(
        PatientBillingState(
          formKey: GlobalKey<FormState>(),
          ageController: TextEditingController(),
          patientSearchController: TextEditingController(),
          patientDetailsController: TextEditingController(),
          patientNameController: TextEditingController(),
          patientPhoneController: TextEditingController(),
          patientEmailController: TextEditingController(),
          patientDateOfBirthController: TextEditingController(),
          genderController: TextEditingController(),
          addressController: TextEditingController(),
          referredByController: TextEditingController(),
          assignedByController: TextEditingController(),
          doneByController: TextEditingController(),
          abhaIdController: TextEditingController(),
          passPortNumberController: TextEditingController(),
          noteController: TextEditingController(),
        ),
      );

  //Update state

  //Search Patient Post Api
  Future<void> searchPatient({
    required BuildContext context,
    required String body,
  }) async {
    try {
      state = state.copyWith(isLoading: true);
      final List<PatientsList> response =
          await SearchPatientApi.searchPatientApi(context: context, body: body);
      log("response in controller :${response.toString()}");
      log(response.length.toString());
      state = state.copyWith(searchPatientList: response);
    } catch (e) {
      log('conntroller catch : ${e.toString()}');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  //Search done by api
  Future<void> doneBySearch({
    required String searchText,
    required BuildContext context,
  }) async {
    if (state.doneByAccountListApi.isEmpty) {
      final response = await DoneBySearchApi.doneBySearch(context: context);
      log('00000000000${response.toString()}');
      List<AccountsList> newAccountList = [];

      for (var item in response) {
        final account = item;

        if (account.type == "Staff") {
          newAccountList.add(account);
        }
      }
      log('>>>>>>>>>>>new list : $newAccountList');
      state = state.copyWith(
        doneByAccountListApi: newAccountList,
        isDoneByApi: true,
      );
    } else {
      final searchTexts = searchText.toLowerCase();

      if (searchTexts.isEmpty) {
        state = state.copyWith(doneByAccountListSearch: [], isDoneByApi: true);
      } else {
        List<String> newsearchList = [];

        for (var item in state.doneByAccountListApi) {
          final name = item.name?.toLowerCase() ?? '';

          if (name.contains(searchTexts)) {
            newsearchList.add(item.name ?? '');

            log('====================new search account list : $newsearchList');
          }
        }

        state = state.copyWith(
          doneByAccountListSearch: newsearchList,
          isDoneByApi: true,
        );
      }
    }

    // state = state.copyWith(
    //   doneByAccountListApi: newAccountList,
    //   isDoneByApi: true,
    // );
  }

  /// COMMON UPDATE METHOD
  void updateState({
    String? age,

    List<PatientsList>? searchPatientList,
    List<AccountsList>? doneByAccountListApi,
    List<String>? doneByAccountListSearch,

    bool? isSubmitted,
    bool? isAge,
    bool? isLoading,
    bool? isTextClear,
    bool? isDoneByApi,

    bool? isAdditional,
    bool? isUrgent,
    GlobalKey<FormState>? formKey,
  }) {
    state = state.copyWith(
      age: age,

      searchPatientList: searchPatientList,
      doneByAccountListApi: doneByAccountListApi,
      doneByAccountListSearch: doneByAccountListSearch,

      isSubmitted: isSubmitted,
      isAge: isAge,
      isLoading: isLoading,
      isTextClear: isTextClear,
      isDoneByApi: isDoneByApi,

      isAdditional: isAdditional,
      isUrgent: isUrgent,
      formKey: formKey,
    );
  }

  int calculateAge(DateTime birthDate) {
    final currentDate = DateTime.now();
    log('current year : ${currentDate.year}');
    log("${DateTime.now()}");

    int age = currentDate.year - birthDate.year;
    // state=state.copyWith(age: age.toString());

    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month &&
            currentDate.day < birthDate.day)) {
      age--;
    }
    state = state.copyWith(age: age.toString()); //after correction

    log(age.toString());
    return age;
  }
}

final patientBillingProvider =
    StateNotifierProvider<PatientBillingController, PatientBillingState>((ref) {
      return PatientBillingController();
    });
