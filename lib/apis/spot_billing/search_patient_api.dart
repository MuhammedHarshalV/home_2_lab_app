import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:icon_infoware/core/constants/api_constants.dart';
import 'package:icon_infoware/core/services/api_services/api_services.dart';
import 'package:icon_infoware/models/spot_billing/search_patient_response_model.dart';

class SearchPatientApi {
  static Future<dynamic> searchPatientApi({
    required BuildContext context,
    required String body,
  }) async {
    try {
      final response = await PostApiServices.callApi(
        context: context,
        url: ApiConstants.searchApi,
        body: {"SrchVal": body},
      );
      log('+++++++++++++++++++++${response.toString()}');
      if (response == null || response.toString().isEmpty) {
        log('======Response :${response.toString()}');
        return [];
      }

      return SearchPatientResponseModel.fromJson(response);
      ;
    } catch (e) {
      log("++++++++++++ catch log ${e.toString()}");
      return [];
    }
  }
}
