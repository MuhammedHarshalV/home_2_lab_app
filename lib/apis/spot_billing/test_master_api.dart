import 'dart:developer';

import 'package:icon_infoware/core/constants/api_constants.dart';
import 'package:icon_infoware/core/constants/app_constance.dart';
import 'package:icon_infoware/core/services/device_details_picking/device_id_picking.dart';
import 'package:icon_infoware/core/services/api_services/api_services.dart';
import 'package:icon_infoware/models/spot_billing/test_master_response_model.dart';

class TestMasterApi {
  static Future<dynamic> testMasterApi() async {
    String deviceID = await DeviceIdPicking.getDeviceId();
    log(deviceID);

    try {
      final response = await PostApiServices.callApi(
        url: "/${ApiConstants.testMaster}",
        queryParams: {"Branchid": AppConstants.branchID},
      );

      if (response.toString().isEmpty || response == null) {
        return [];
      } else {
        return TestMasterResponseModel.fromJson(response);
      }
    } catch (e) {
      log('-------------');
      log(e.toString());

      return [];
    }
  }
}
