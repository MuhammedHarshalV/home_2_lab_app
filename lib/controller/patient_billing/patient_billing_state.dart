import 'package:flutter/material.dart';
import 'package:icon_infoware/models/spot_billing/done_by_search_response_model.dart';
import 'package:icon_infoware/models/spot_billing/search_patient_response_model.dart';

class PatientBillingState {
  final TextEditingController patientSearchController;
  final TextEditingController patientDetailsController;
  final TextEditingController patientNameController;
  final TextEditingController patientPhoneController;
  final TextEditingController patientEmailController;
  final TextEditingController patientDateOfBirthController;
  final TextEditingController ageController;
  final TextEditingController abhaIdController;
  final TextEditingController passPortNumberController;
  final TextEditingController noteController;
  //final String age;
  final TextEditingController genderController;
  final TextEditingController addressController;
  final TextEditingController referredByController;
  final TextEditingController assignedByController;
  final TextEditingController doneByController;

  final List<PatientsList> searchPatientList;
  final List<AccountsList> doneByAccountListApi;
 // final List<AccountsList> doneByAccountListApi;
  final List<String> doneByAccountListSearch;

  final bool isSubmitted;
  final bool isAge;
  final bool isAdditional;
  final bool isLoading;
  final bool isTextClear;
  final bool isDoneByApi;

  final bool isUrgent;
  final GlobalKey<FormState> formKey;

  PatientBillingState({
   // this.age = '',
    required this.formKey,
    this.searchPatientList = const [],
    this.doneByAccountListApi = const [],
    this.doneByAccountListSearch = const [],

    this.isSubmitted = false,
    this.isAge = false,
    this.isLoading = false,
    this.isTextClear = false,
    this.isDoneByApi = false,

    this.isAdditional = false,
    this.isUrgent = false,
    required this.patientSearchController,
    required this.patientDetailsController,
    required this.patientNameController,
    required this.patientPhoneController,
    required this.patientEmailController,
    required this.patientDateOfBirthController,
    required this.genderController,
    required this.addressController,
    required this.referredByController,
    required this.assignedByController,
    required this.doneByController,
    required this.ageController,
    required this.abhaIdController,
    required this.passPortNumberController,
    required this.noteController,
  });

  PatientBillingState copyWith({
    TextEditingController? patientSearchController,
    TextEditingController? patientDetailsController,
    TextEditingController? patientNameController,
    TextEditingController? patientPhoneController,
    TextEditingController? patientEmailController,
    TextEditingController? patientDateOfBirthController,
    TextEditingController? abhaIdController,
    TextEditingController? passPortNumberController,
    TextEditingController? noteController,
   // String? age,
    TextEditingController? genderController,
    TextEditingController? ageController,

    TextEditingController? addressController,
    TextEditingController? referredByController,
    TextEditingController? assignedByController,
    TextEditingController? doneByController,
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
    return PatientBillingState(
      formKey: formKey ?? this.formKey,
      patientSearchController:
          patientSearchController ?? this.patientSearchController,
      ageController: ageController ?? this.ageController,
      patientDetailsController:
          patientDetailsController ?? this.patientDetailsController,
      patientNameController:
          patientNameController ?? this.patientNameController,
      patientPhoneController:
          patientPhoneController ?? this.patientPhoneController,
      patientEmailController:
          patientEmailController ?? this.patientEmailController,
      patientDateOfBirthController:
          patientDateOfBirthController ?? this.patientDateOfBirthController,
      abhaIdController: abhaIdController ?? this.abhaIdController,
      passPortNumberController:
          passPortNumberController ?? this.passPortNumberController,
      noteController: noteController ?? this.noteController,
      //age: age ?? this.age,
      genderController: genderController ?? this.genderController,
      addressController: addressController ?? this.addressController,
      referredByController: referredByController ?? this.referredByController,
      assignedByController: assignedByController ?? this.assignedByController,
      doneByController: doneByController ?? this.doneByController,
      searchPatientList: searchPatientList ?? this.searchPatientList,
      doneByAccountListApi: doneByAccountListApi ?? this.doneByAccountListApi,
      doneByAccountListSearch:
          doneByAccountListSearch ?? this.doneByAccountListSearch,

      isSubmitted: isSubmitted ?? this.isSubmitted,
      isAge: isAge ?? this.isAge,
      isDoneByApi: isDoneByApi ?? this.isDoneByApi,

      isTextClear: isTextClear ?? this.isTextClear,
      isLoading: isLoading ?? this.isLoading,
      isAdditional: isAdditional ?? this.isAdditional,
      isUrgent: isUrgent ?? this.isUrgent,
    );
  }
}
