import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:icon_infoware/apis/spot_billing/done_by_search_api.dart';
import 'package:icon_infoware/apis/spot_billing/search_patient_api.dart';

import 'package:icon_infoware/controller/patient_billing/patient_billing_state.dart';
import 'package:icon_infoware/core/errors/api_errors/api_errors.dart';
import 'package:icon_infoware/core/services/network_services/connection_checking.dart';
import 'package:icon_infoware/models/spot_billing/done_by_search_response_model.dart';

import 'package:icon_infoware/models/spot_billing/search_patient_response_model.dart';

class PatientBillingController extends StateNotifier<PatientBillingState> {
  final Ref ref;

  PatientBillingController(this.ref)
    : super(
        PatientBillingState(
          outDoctorController: TextEditingController(),
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
          doneByController: TextEditingController(text: 'Sumesh'),
          abhaIdController: TextEditingController(),
          passPortNumberController: TextEditingController(),
          noteController: TextEditingController(),
        ),
      ) {
    Future.microtask(() {
      doneBySearch(searchText: '', apiCall: false, context: null);
    });
  }

  //Update state

  //Search Patient Post Api
  Future<void> searchPatient({
    required BuildContext context,
    required String body,
  }) async {
    try {
      state = state.copyWith(isLoading: true);
      final SearchPatientResponseModel response =
          await SearchPatientApi.searchPatientApi(context: context, body: body);
      log("response in controller :${response.toString()}");
      if (response.patientsList != null) {
        log(response.patientsList!.length.toString());
        state = state.copyWith(searchPatientList: response.patientsList ?? []);
      }
    } catch (e) {
      log('conntroller catch : ${e.toString()}');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  //Search done by api
  Future<void> doneBySearch({
    required String searchText,
    required bool apiCall,
    required BuildContext? context,
  }) async {
    try {
      state = state.copyWith(isLoading: true);
      bool isConnect = await InternetChecker.hasConnection();
      final box = await Hive.openBox('staff_account');

      //==================== Done By Account API ====================//
      if (apiCall == true) {
        final response = await DoneBySearchApi.doneBySearch(context);
        log('done by api response in controller :${response.toString()}');
        if (response == null || response is! DoneBySearchResponseModel) {
          return;
        }
        List<AccountsList> newAccountList = [];
        List<AccountsList> specialSchemeList = [];
        if (context != null) {
          AppMessage.show(context, "Account heads synced successfully.");
        }
        for (var item in response.accountsList ?? []) {
          final account = item;

          if (account.type == "Staff") {
            log("staffs : ready");
            newAccountList.add(account);
          } else if (account.type == 'Hosp' || account.type == 'AccHd') {
            specialSchemeList.add(account);
          }
        }

        log('done by account list : $newAccountList');
        state = state.copyWith(
          doneByAccountListApi: newAccountList,
          isDoneByApi: true,
        );
        await saveStaffAccounts(
          accounts: newAccountList,
          specialSchemeList: specialSchemeList,
        );
      }
      //================== End Done By Account API ==================//
      //==================== Done By Account API when Hive have no data ====================//
      else if (isConnect == true && box.isEmpty) {
        final response = await DoneBySearchApi.doneBySearch(context);
        log('done by api response in controller :${response.toString()}');
        if (response == null || response is! DoneBySearchResponseModel) {
          return;
        }
        List<AccountsList> newAccountList = [];
        List<AccountsList> specialSchemeList = [];

        for (var item in response.accountsList ?? []) {
          final account = item;

          if (account.type == "Staff") {
            log("staffs : ready");
            newAccountList.add(account);
          } else if (account.type == 'Hosp' || account.type == 'AccHd') {
            specialSchemeList.add(account);
          }
        }

        log('done by account list : $newAccountList');
        state = state.copyWith(
          doneByAccountListApi: newAccountList,
          isDoneByApi: true,
        );
        await saveStaffAccounts(
          accounts: newAccountList,
          specialSchemeList: specialSchemeList,
        );
      } //====================end Done By Account API when Hive have no data ====================//
      //====================stored data fetching ====================//
      else if (state.doneByAccountListApi.isEmpty) {
        List<AccountsList> staffAccountList = await getStaffAccounts();
        log(staffAccountList.toString());
        state = state.copyWith(doneByAccountListApi: staffAccountList);
        log(state.doneByAccountListApi.toString());
      } else {
        final searchTexts = searchText.toLowerCase();

        if (searchTexts.isEmpty) {
          state = state.copyWith(
            doneByAccountListSearch: [],
            isDoneByApi: true,
          );
        } else {
          List<String> newsearchList = [];

          for (var item in state.doneByAccountListApi) {
            final name = item.name?.toLowerCase() ?? '';

            if (name.contains(searchTexts)) {
              newsearchList.add(item.name ?? '');

              log('done by search account list : $newsearchList');
            }
          }

          state = state.copyWith(
            doneByAccountListSearch: newsearchList,
            isDoneByApi: true,
          );
        }
      }
    } catch (e) {
      log(e.toString());
      if (context != null) {
        AppMessage.show(context, e.toString());
      }
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  //store to account heads staffs to hive
  Future<void> saveStaffAccounts({
    required List<AccountsList> accounts,
    required List<AccountsList> specialSchemeList,
  }) async {
    final staffBox = await Hive.openBox('staff_account');
    final schemeBox = await Hive.openBox('special_scheme');

    await staffBox.clear(); // Optional: remove old data
    await schemeBox.clear();
    for (final account in accounts) {
      await staffBox.add(account.toJson());
    }

    for (final scheme in specialSchemeList) {
      await schemeBox.add(scheme.toJson());
    }
  }

  //get stored account heads by staff
  Future<List<AccountsList>> getStaffAccounts() async {
    final box = await Hive.openBox('staff_account');

    return box.values
        .map((item) => AccountsList.fromJson(Map<String, dynamic>.from(item)))
        .toList();
  }

  /// COMMON UPDATE METHOD
  void updateState({
    //  String? age,
    List<PatientsList>? searchPatientList,
    List<AccountsList>? doneByAccountListApi,
    List<String>? doneByAccountListSearch,
    String? ageByYear,
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
      // age: age,
      searchPatientList: searchPatientList,
      doneByAccountListApi: doneByAccountListApi,
      doneByAccountListSearch: doneByAccountListSearch,
      ageByYear: ageByYear,
      isSubmitted: isSubmitted,
      isAge: isAge,
      isLoading: isLoading,
      isTextClear: isTextClear,
      isDoneByApi: isDoneByApi,

      isAdditional: isAdditional,
      isUrgent: isUrgent,
    );
  }

  //age calcutation
  int calculateAge(DateTime birthDate) {
    final currentDate = DateTime.now();
    log('current year : ${currentDate.year}');
    log("${DateTime.now()}");

    int age = currentDate.year - birthDate.year;

    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month &&
            currentDate.day < birthDate.day)) {
      age--;
    }
    int ageText;

    if (age == 0) {
      // Calculate total months
      int months =
          (currentDate.year - birthDate.year) * 12 +
          (currentDate.month - birthDate.month);

      // Adjust if day not reached
      if (currentDate.day < birthDate.day) {
        months--;
      }
      state = state.copyWith(ageByYear: 'Months');
      ageText = months;
    } else {
      ageText = age;
      state = state.copyWith(ageByYear: 'Years');
    }
    state = state.copyWith(
      ageController: TextEditingController(text: ageText.toString()),
    ); //after correction

    log(ageText.toString());
    return ageText;
  }
}

final patientBillingProvider =
    StateNotifierProvider<PatientBillingController, PatientBillingState>((ref) {
      return PatientBillingController(ref);
    });
