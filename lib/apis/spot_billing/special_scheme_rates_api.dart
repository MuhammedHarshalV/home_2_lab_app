import 'dart:developer';

import 'package:icon_infoware/core/constants/api_constants.dart';

import 'package:icon_infoware/core/services/api_services/api_services.dart';
import 'package:icon_infoware/models/spot_billing/special_scheme_rates_response_model.dart';

class SpecialSchemeRatesApi {
  static Future<List<SchemeRateList>> specialSchemesApi() async {
    try {
      final response = await PostApiService.callApi(
        url: "${ApiConstants.baseUrl}${ApiConstants.specialSchemeRates}",
      );

      if (response.toString().isEmpty || response == null) {
        return [];
      } else {
        SpecialSchemeRatesResponseModel responseBody =
            specialSchemeRatesResponseModelFromJson(response);
        return responseBody.schemeRateList ?? [];
      }
    } catch (e) {
      log('-------------');
      log(e.toString());

      return [];
    }
  }
}
