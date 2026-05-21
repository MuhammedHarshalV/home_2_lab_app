import 'dart:developer';

import 'package:icon_infoware/core/constants/api_constants.dart';
import 'package:icon_infoware/core/constants/app_constance.dart';
import 'package:icon_infoware/core/services/device_details_picking/device_id_picking.dart';
import 'package:icon_infoware/core/services/api_services/api_services.dart';
import 'package:icon_infoware/models/spot_billing/test_master_response_model.dart';

class TestMasterApi {
  static Future<List<TestMaster>> testMasterApi() async {
    String deviceID = await DeviceIdPicking.getDeviceId();
    log(deviceID);

    try {
      final response = await PostApiService.callApi(
        url:
            "${ApiConstants.baseUrl}/${ApiConstants.testMaster}?Branchid=${AppConstance.branchID}",
      );

      if (response.toString().isEmpty || response == null) {
        return [];
      } else {
        TestMasterResponseModel responseBody = testMasterResponseModelFromJson(
          response,
        );
        return responseBody.tests ?? [];
      }
    } catch (e) {
      log('-------------');
      log(e.toString());

      return [];
    }
  }
}
