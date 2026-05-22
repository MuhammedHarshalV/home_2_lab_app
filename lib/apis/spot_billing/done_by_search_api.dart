import 'dart:developer';

import 'package:icon_infoware/core/constants/api_constants.dart';
import 'package:icon_infoware/core/services/api_services/api_services.dart';
import 'package:icon_infoware/models/spot_billing/done_by_search_response_model.dart';

class DoneBySearchApi {
  static Future<List<AccountsList>> doneBySearch() async {
    try {
      final response = await PostApiService.callApi(
        url: '${ApiConstants.baseUrl}${ApiConstants.doneBySearchApi}',
      );
      log('+++++++++++++++++++++${response.toString()}');
      if (response == null || response.toString().isEmpty) {
        log('======Response :${response.toString()}');
        return [];
      }
      DoneBySearchResponseModel responseBody =
          doneBySearchResponseModelFromJson(response);

      log('===============response :${responseBody.accountsList}');

      return responseBody.accountsList ?? [];
    } catch (e) {
      log("++++++++++++ catch log ${e.toString()}");
      return [];
    }
  }
}
