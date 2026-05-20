import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:icon_infoware/core/constants/api_constants.dart';
import 'package:icon_infoware/core/services/api_services/api_services.dart';
import 'package:icon_infoware/models/spot_billing/search_patient_response_model.dart';

class SearchPatientApi {
  static Future<List<PatientsList>> searchPatientApi({
    required BuildContext context,
    required String body,
  }) async {
    try {
      final response = await PostApiService.callApi(
        context: context,
        url: '${ApiConstants.baseUrl}${ApiConstants.searchApi}',
        body: {"SrchVal": body},
      );
      log('+++++++++++++++++++++${response.toString()}');
      if (response == null || response.toString().isEmpty) {
        log('======Response :${response.toString()}');
        return [];
      }
      SearchPatientResponseModel responseBody =
          searchPatientResponseModelFromJson(response);
      log('===============response :${responseBody.patientsList}');
      return responseBody.patientsList ?? [];
    } catch (e) {
      log("++++++++++++ catch log ${e.toString()}");
      return [];
    }
  }
}
