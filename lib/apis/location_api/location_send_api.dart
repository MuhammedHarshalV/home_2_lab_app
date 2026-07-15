import 'dart:developer';

import 'package:icon_infoware/core/constants/api_constants.dart';

import 'package:icon_infoware/core/services/api_services/api_services.dart';

class LocationSendApi {
  static Future<dynamic> locationSendApi({
    required Map<String, dynamic> body,
  }) async {
    try {
      final response = await PostApiServices.callApi(
        body: body,

        url: ApiConstants.userLocation,
      );

      if (response.toString().isEmpty || response == null) {
        return 'location send error';
      } else {
        return response['Success'];
      }
    } catch (e) {
      log('-------------');
      log(e.toString());

      return null;
    }
  }
}
