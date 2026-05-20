import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:icon_infoware/core/constants/api_constants.dart';
import 'package:icon_infoware/core/services/device_details_picking/device_id_picking.dart';
import 'package:icon_infoware/core/services/api_services/api_services.dart';

class BaseUrlChecking {
  static Future<String?> baseUrlRegister({
    required BuildContext context,
    required String baseUrl,

    required String branchID,
  }) async {
    String deviceID = await DeviceIdPicking.getDeviceId();
    log(deviceID);

    try {
      final response = await GetApiService.callApi(
        context: context,

        url:
            "$baseUrl${ApiConstants.baseUrlChecking}BrnchCode=$branchID&UniqueId=$deviceID",
      );

      if (response.toString().isEmpty || response == null) {
        return 'Branch ID is wrong';
      } else {
        return response['Success'] == true ? response['Cus_logo'] : 'fail';
      }
    } catch (e) {
      log('-------------');
      log(e.toString());

      return null;
    }
  }
}
