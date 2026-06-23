import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:icon_infoware/core/constants/api_constants.dart';

import 'package:icon_infoware/core/services/api_services/api_services.dart';
import 'package:icon_infoware/core/services/device_details_picking/device_id_picking.dart';
import 'package:icon_infoware/models/home_screen/booking_patient_response_model.dart';
import 'package:intl/intl.dart';

class PatientBookingDetails {
  static Future<dynamic> patientBookingDetails({
    required BuildContext? context,
  }) async {
    try {
      String deviceID = await DeviceIdPicking.getDeviceId();
      String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
      final response = await PostApiServices.callApi(
        context: context,
        // body: {"today": currentDate, "devcode": deviceID},
        body: {"today": "2026-06-16", "devcode": deviceID},
        url: ApiConstants.patientBookingDetails,
      );

      if (response.toString().isEmpty || response == null) {
        return;
      } else {
        return BookingDetailsResponseModel.fromJson(response);
      }
    } catch (e) {
      log('-------------');
      log(e.toString());

      return null;
    }
  }
}
