import 'dart:developer';

import 'package:icon_infoware/core/constants/api_constants.dart';

import 'package:icon_infoware/core/services/api_services/api_services.dart';
import 'package:icon_infoware/models/spot_billing/special_scheme_rates_response_model.dart';

class SpecialSchemeRatesApi {
  static Future<dynamic> specialSchemesApi() async {
    try {
      final response = await PostApiServices.callApi(
        url: ApiConstants.specialSchemeRates,
      );

      if (response.toString().isEmpty || response == null) {
        return [];
      } else {
       
        return  SpecialSchemeRatesResponseModel.fromJson(response);
      }
    } catch (e) {
      log('-------------');
      log(e.toString());

      return [];
    }
  }
}
