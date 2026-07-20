import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:icon_infoware/core/constants/api_constants.dart';
import 'package:icon_infoware/core/constants/app_constants.dart';

import 'package:icon_infoware/core/services/api_services/api_services.dart';

class YearIdFetching {
  static Future<dynamic> yearIdFetching({required BuildContext context}) async {
    try {
      final response = await GetApiServices.callApi(
        context: context,

        url: ApiConstants.yearIdFetching,
        queryParams: {"DevCode": AppConstants.deviceID},
      );

      if (response.toString().isEmpty || response == null) {
        return 'Api error';
      } else {
        AppConstants.yearId = response['YrId'].toString();
        AppConstants.syncId = response['InvNo'].toString();
        return response;
      }
    } catch (e) {
      log('-------------');
      log(e.toString());

      return null;
    }
  }
}
