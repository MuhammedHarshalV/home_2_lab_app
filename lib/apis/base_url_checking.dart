import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:icon_infoware/core/constants/api_constants.dart';
import 'package:icon_infoware/core/constants/app_constants.dart';
import 'package:icon_infoware/core/services/device_details_picking/device_id_picking.dart';
import 'package:icon_infoware/core/services/api_services/api_services.dart';
import 'package:icon_infoware/models/base_url_response/base_url_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BaseUrlChecking {
  static Future<dynamic> baseUrlRegister({
    required BuildContext context,
    required String baseUrl,

    required String branchID,
  }) async {
    String deviceID = await DeviceIdPicking.getDeviceId();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('DeviceID', deviceID);
    await prefs.setString('BranchID', branchID);
    ApiConstants.baseUrl = baseUrl;
    AppConstants.deviceID = deviceID;
    AppConstants.branchID = branchID;

    log('storing device ID :$deviceID');
    log('storing branch ID :$branchID');

    log(deviceID);

    try {
      final response = await GetApiServices.callApi(
        context: context,

        url: ApiConstants.baseUrlChecking,
        queryParams: {"BrnchCode": branchID, "UniqueId": deviceID},
      );

      if (response.toString().isEmpty || response == null) {
        return 'Branch ID is wrong';
      } else {
        return BaseUrlResponseModel.fromJson(response);
      }
    } catch (e) {
      log('-------------');
      log(e.toString());

      return null;
    }
  }
}
