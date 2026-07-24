import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:icon_infoware/core/constants/api_constants.dart';

import 'package:icon_infoware/core/services/api_services/api_services.dart';

import 'package:icon_infoware/models/help_support_response/help_support_response_model.dart';

class HelpSupportApi {
  static Future<dynamic> helpSupportApi({
    required BuildContext? context,
  }) async {
    try {
      final response = await GetApiServices.callApi(
        context: context,

        url: ApiConstants.helpSupportApi,
      );

      if (response.toString().isEmpty || response == null) {
        return 'Help and Support error';
      } else {
        return HelpSupportResponseModel.fromJson(response);
      }
    } catch (e) {
      log('-------------');
      log(e.toString());

      return null;
    }
  }
}
