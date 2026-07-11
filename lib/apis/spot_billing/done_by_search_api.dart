import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:icon_infoware/core/constants/api_constants.dart';
import 'package:icon_infoware/core/services/api_services/api_services.dart';
import 'package:icon_infoware/models/spot_billing/done_by_search_response_model.dart';

class DoneBySearchApi {
  static Future<dynamic> doneBySearch(BuildContext? context) async {
    try {
      final response = await PostApiServices.callApi(
        url: ApiConstants.doneBySearchApi,
        context: context,
      );

      if (response == null || response.toString().isEmpty) {
        log('======Response :${response.toString()}');
        return [];
      }

      return DoneBySearchResponseModel.fromJson(response);
    } catch (e) {
      log("++++++++++++ catch log ${e.toString()}");
      return [];
    }
  }
}
