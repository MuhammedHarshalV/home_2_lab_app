import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:icon_infoware/core/constants/api_constants.dart';
import 'package:icon_infoware/core/services/api_services/api_services.dart';
import 'package:icon_infoware/models/spot_billing/done_by_search_response_model.dart';

class DoneBySearchApi {
  static Future<List<AccountsList>> doneBySearch({
    required BuildContext context,
  }) async {
    try {
      final response = await PostApiService.callApi(
        context: context,
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
      // List<AccountsList> newAccountList = [];

      // for (var item in responseBody.accountsList ?? []) {
      //   final account = AccountsList.fromJson(item);

      //   if (account.type == "Staff") {
      //     newAccountList.add(account);
      //   }
      // }
      // log('>>>>>>>>>>>new list : $newAccountList');
      return responseBody.accountsList ?? [];
    } catch (e) {
      log("++++++++++++ catch log ${e.toString()}");
      return [];
    }
  }
}
