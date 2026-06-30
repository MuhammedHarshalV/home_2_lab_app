import 'dart:developer';

import 'package:icon_infoware/core/constants/api_constants.dart';

import 'package:icon_infoware/core/services/api_services/api_services.dart';
import 'package:icon_infoware/models/discount_reasons/discount_reasons_response_model.dart';

class DiscountFetchingApi {
  static Future<dynamic> discountFetchingApi() async {
    try {
      final response = await PostApiServices.callApi(
        url: ApiConstants.discountFetching,
      );

      if (response.toString().isEmpty || response == null) {
        return 'no discount reasons';
      } else {
        return DiscountReasonResponseModel.fromJson(response);
      }
    } catch (e) {
      log('-------------');
      log(e.toString());

      return null;
    }
  }
}
