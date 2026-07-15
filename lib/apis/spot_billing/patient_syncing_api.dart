import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:icon_infoware/core/constants/api_constants.dart';
import 'package:icon_infoware/core/constants/app_constants.dart';
import 'package:icon_infoware/core/services/api_services/api_services.dart';
import 'package:icon_infoware/models/patient_bill_syncing_model/patient_bill_syncing_model.dart';
import 'package:intl/intl.dart';

class PatientSyncingApi {
  static Future<dynamic> patientSyncingApi({
    required List<PatientHiveModel> patients,
    required BuildContext? context,
  }) async {
    try {
      final List<Map<String, dynamic>> patList = [];

      for (final patient in patients) {
        final body = <String, dynamic>{};

        body["patId"] = patient.patId?.toString();
        body["NamePrefix"] = patient.namePrefix ?? '';
        body["patName"] = patient.patName ?? '';
        body["patAddress"] = patient.patAddress ?? '';
        body["Inv_No"] = (patient.indexClick ?? 0) + 1;
        body["patEmail"] = patient.patEmail ?? '';
        body["patPhno"] = patient.patPhno ?? '';
        body["patMobno"] = patient.patMobno ?? '';
        body["patAge"] = patient.patAge ?? 0;
        body["patAgehead"] = patient.patAgehead ?? '';
        body["patGender"] = patient.patGender ?? '';
        body["CurrentDatetime"] = DateFormat(
          'yyyy-MM-dd',
        ).format(DateTime.now());
        body["DrId"] = int.tryParse(patient.drId ?? '0');
        body["OutDr"] = patient.outDr ?? '';
        body["Passport"] = patient.passport ?? '';
        body["RepEmail"] = patient.repEmail ?? 1;
        body["RepWhtapp"] = patient.repWhtapp ?? 1;
        body["Urgent"] = patient.urgent ?? 0;
        body["Remarks"] = patient.remarks ?? '';
        body["Ipop"] = patient.ipop ?? '';
        body["Dob"] = patient.dob ?? '';
        body["DriverId"] = patient.driverId ?? '';
        body["TechId"] = int.tryParse(patient.techId ?? '0');
        body["GrossAmt"] = patient.grossAmt ?? 0;
        body["DiscAmt"] = patient.discAmt ?? 0;
        body["ServChrge"] = patient.servChrge ?? 0;
        body["NetAmt"] = patient.netAmt ?? 0;
        body["PaidAmt"] = patient.paidAmt ?? 0;
        body["Balance"] = patient.balance ?? 0;
        body["PaymentType"] = patient.primaryType ?? '';
        body["SecPayType"] = patient.secondaryType ?? '';
        body["PriPaidAmt"] = patient.primaryPaid ?? 0;
        body["SecPaidAmt"] = patient.secondaryPaid ?? 0;
        body["Insid"] = int.tryParse(patient.insid ?? '0');
        body["InsNo"] = int.tryParse(patient.insNo ?? '0');
        body["Testlists"] = patient.testlists ?? [];

        patList.add(body);
      }

      log("PAT LIST : $patList");

      final response = await PostApiServices.callApi(
        context: context,
        url: ApiConstants.patientSync,
        body: {
          "YrId": 2425,
          "BrId": int.tryParse(AppConstants.branchID) ?? 0,
          "DevCode": AppConstants.deviceID,
          "Pat_List": patList,
        },
      );

      if (response == null) return false;

      return response["Success"] == true;
    } catch (e) {
      log("Patient Sync API Error: $e");
      return false;
    }
  }
}
