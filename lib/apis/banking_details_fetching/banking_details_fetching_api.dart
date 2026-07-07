import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:icon_infoware/core/constants/api_constants.dart';

import 'package:icon_infoware/core/services/api_services/api_services.dart';
import 'package:icon_infoware/models/banking_fetching/banking_fetching_response_model.dart';

class BankingDetailsFetchingApi {
  static Future<dynamic> bankingDetailsFetchingApi({
    required BuildContext? context,
  }) async {
    try {
      final response = await PostApiServices.callApi(
        context: context,

        url: ApiConstants.bankFetching,
      );

      if (response.toString().isEmpty || response == null) {
        return 'Bank fetching error';
      } else {
        return BankFetchingResponseModel.fromJson(response);
      }
    } catch (e) {
      log('-------------');
      log(e.toString());

      return null;
    }
  }
}
