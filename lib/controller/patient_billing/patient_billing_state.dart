import 'package:flutter/material.dart';
import 'package:icon_infoware/models/spot_billing/search_patient_response_model.dart';

class PatientBillingState {
  final TextEditingController patientSearchController;
  final TextEditingController patientDetailsController;
  final TextEditingController patientNameController;
  final TextEditingController patientPhoneController;
  final TextEditingController patientEmailController;
  final TextEditingController patientDateOfBirthController;
  final TextEditingController ageController;

  final String age;
  final TextEditingController genderController;
  final TextEditingController addressController;
  final TextEditingController referredByController;
  final TextEditingController assignedByController;
  final TextEditingController doneByController;

  final List<PatientsList> searchPatientList;

  final bool isSubmitted;
  final bool isAge;
  final bool isAdditional;
  final bool isLoading;
  final bool isTextClear;

  final bool isUrgent;
  final GlobalKey<FormState> formKey;

  PatientBillingState({
    this.age = '',
    required this.formKey,
    this.searchPatientList = const [],
    this.isSubmitted = false,
    this.isAge = false,
    this.isLoading = false,
    this.isTextClear = false,

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
  });

  PatientBillingState copyWith({
    TextEditingController? patientSearchController,
    TextEditingController? patientDetailsController,
    TextEditingController? patientNameController,
    TextEditingController? patientPhoneController,
    TextEditingController? patientEmailController,
    TextEditingController? patientDateOfBirthController,
    String? age,
    TextEditingController? genderController,
    TextEditingController? ageController,

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
      age: age ?? this.age,
      genderController: genderController ?? this.genderController,
      addressController: addressController ?? this.addressController,
      referredByController: referredByController ?? this.referredByController,
      assignedByController: assignedByController ?? this.assignedByController,
      doneByController: doneByController ?? this.doneByController,
      searchPatientList: searchPatientList ?? this.searchPatientList,
      isSubmitted: isSubmitted ?? this.isSubmitted,
      isAge: isAge ?? this.isAge,
      isTextClear: isTextClear ?? this.isTextClear,
      isLoading: isLoading ?? this.isLoading,
      isAdditional: isAdditional ?? this.isAdditional,
      isUrgent: isUrgent ?? this.isUrgent,
    );
  }
}
