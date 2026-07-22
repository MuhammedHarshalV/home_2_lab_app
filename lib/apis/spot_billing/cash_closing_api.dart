import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:icon_infoware/core/constants/api_constants.dart';
import 'package:icon_infoware/core/constants/app_constants.dart';
import 'package:icon_infoware/core/services/api_services/api_services.dart';
import 'package:icon_infoware/models/patient_bill_syncing_model/patient_bill_syncing_model.dart';
import 'package:intl/intl.dart';

class CashClosingApi {
  static Future<dynamic> cashClosingApi({
    required List<PatientHiveModel> patients,
    required BuildContext? context,
  }) async {
    try {
      final List<Map<String, dynamic>> patList = [];

      for (final patient in patients) {
        patList.add({
          "billDate": patient.dateToSave?.toString(),
          "Billno": patient.invNo ?? '',
          "billAmount": patient.netAmt ?? 0,
        });
      }

      final Map<String, dynamic> body = {
        'CurDate': DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(DateTime.now()),
        "DevCode": AppConstants.deviceID,
        "TotalAmount": patients
            .fold<num>(0, (sum, item) => sum + (item.netAmt ?? 0))
            .toStringAsFixed(2),
        "ttlcash": patients
            .fold<num>(0, (sum, item) {
              num total = sum;

              if ((item.primaryType ?? '').toLowerCase() == 'cash') {
                total += item.primaryPaid ?? 0;
              }

              if ((item.secondaryType ?? '').toLowerCase() == 'cash') {
                total += item.secondaryPaid ?? 0;
              }

              return total;
            })
            .toStringAsFixed(2),
        "ttlupi": patients
            .fold<num>(0, (sum, item) {
              num total = sum;

              if ((item.primaryType ?? '').toLowerCase() == 'upi') {
                total += item.primaryPaid ?? 0;
              }

              if ((item.secondaryType ?? '').toLowerCase() == 'upi') {
                total += item.secondaryPaid ?? 0;
              }

              return total;
            })
            .toStringAsFixed(2),
        "ttlcard": patients
            .fold<num>(0, (sum, item) {
              num total = sum;

              if ((item.primaryType ?? '').toLowerCase() == 'card') {
                total += item.primaryPaid ?? 0;
              }

              if ((item.secondaryType ?? '').toLowerCase() == 'card') {
                total += item.secondaryPaid ?? 0;
              }

              return total;
            })
            .toStringAsFixed(2),
        "Bills_List": patList,
      };

      log("PAT LIST : $patList");

      final response = await PostApiServices.callApi(
        context: context,
        url: ApiConstants.cashClosingApi,
        body: body,
      );

      if (response == null) return false;

      return response["Success"] == true;
    } catch (e) {
      log("cash closing API Error: $e");
      return false;
    }
  }
}
