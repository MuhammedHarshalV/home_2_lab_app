import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icon_infoware/apis/spot_billing/search_patient_api.dart';
import 'package:icon_infoware/controller/patient_billing/patient_billing_state.dart';

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

  /// COMMON UPDATE METHOD
  void updateState({
    TextEditingController? patientSearchController,
    TextEditingController? patientDetailsController,
    TextEditingController? patientNameController,
    TextEditingController? patientPhoneController,
    TextEditingController? patientEmailController,
    TextEditingController? ageController,

    TextEditingController? patientDateOfBirthController,
    String? age,
    TextEditingController? genderController,
    TextEditingController? addressController,
    TextEditingController? referredByController,
    TextEditingController? assignedByController,
    TextEditingController? doneByController,
    List<PatientsList>? searchPatientList,
    bool? isSubmitted,
    bool? isAge,
    bool? isLoading,
    bool? isTextClear,

    bool? isAdditional,
    bool? isUrgent,
    GlobalKey<FormState>? formKey,
  }) {
    state = state.copyWith(
      patientSearchController: patientSearchController,
      patientDetailsController: patientDetailsController,
      patientNameController: patientNameController,
      patientPhoneController: patientPhoneController,
      patientEmailController: patientEmailController,
      patientDateOfBirthController: patientDateOfBirthController,
      ageController: ageController,
      age: age,
      genderController: genderController,
      addressController: addressController,
      referredByController: referredByController,
      assignedByController: assignedByController,
      doneByController: doneByController,
      searchPatientList: searchPatientList,
      isSubmitted: isSubmitted,
      isAge: isAge,
      isLoading: isLoading,
      isTextClear: isTextClear,

      isAdditional: isAdditional,
      isUrgent: isUrgent,
      formKey: formKey,
    );
  }
  // Update Age

  // Update Gender

  // Reset All Fields

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
