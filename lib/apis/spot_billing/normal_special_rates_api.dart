import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:icon_infoware/core/constants/api_constants.dart';

import 'package:icon_infoware/core/services/api_services/api_services.dart';
import 'package:icon_infoware/models/spot_billing/normal_special_rates_response_model.dart';

class NormalSpecialRatesApi {
  static Future<dynamic> normalSpecialRatesApi(BuildContext? context) async {
    try {
      final response = await PostApiServices.callApi(
        url: ApiConstants.normalSpecialRates,
        context: context,
      );

      if (response.toString().isEmpty || response == null) {
        return [];
      } else {
        return NormalSpecialRatesResponseModel.fromJson(response);
      }
    } catch (e) {
      log('-------------');
      log(e.toString());

      return [];
    }
  }
}
