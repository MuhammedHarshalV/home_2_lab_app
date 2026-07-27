import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:icon_infoware/core/constants/api_constants.dart';
import 'package:icon_infoware/core/constants/app_constants.dart';

import 'package:icon_infoware/core/services/api_services/api_services.dart';

class PatientWorkAddRemoveApi {
  static Future<dynamic> patientWorkAddRemoveApi({
    required BuildContext? context,
    required String purpose,
    required int bookNo,
  }) async {
    try {
      final response = await PostApiServices.callApi(
        context: context,
        body: {
          "Perform": purpose,
          "BookNo": bookNo,
          "UsrId": int.tryParse(AppConstants.userId),
          "DevCode": AppConstants.deviceID,
        },

        url: ApiConstants.workAddAndRemove,
      );

      if (response.toString().isEmpty || response == null) {
        return;
      } else {
        return response['Message'];
      }
    } catch (e) {
      log('-------------');
      log(e.toString());

      return null;
    }
  }
}
