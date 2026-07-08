import 'dart:developer';

import 'package:icon_infoware/core/constants/api_constants.dart';
import 'package:icon_infoware/core/constants/app_constance.dart';
import 'package:icon_infoware/core/services/api_services/api_services.dart';

class PatientSyncingApi {
  static Future<dynamic> patientSyncingApi({
    String? billLocation,
    int? assignBrId,
    int? corpId,
    String? patId,
    String? namePrefix,
    String? patName,
    String? patAddress,
    String? invNo,
    String? patEmail,
    String? patPhno,
    String? patMobno,
    int? patAge,
    String? patAgeHead,
    String? patGender,
    String? currentDateTime,
    int? drId,
    String? outDr,
    String? passport,
    bool? repEmail,
    bool? repWhatsapp,
    int? urgent,
    String? remarks,
    String? ipop,
    int? discRsnId,
    String? patImg,
    String? dob,
    int? driverId,
    int? technicianId,
    num? grossAmt,
    num? discAmt,
    num? servCharge,
    num? netAmt,
    num? paidAmt,
    num? balance,
    String? paymentType,
    int? insId,
    int? insNo,
    String? startTime,
    String? endTime,
    num? priPaidAmt,
    String? secPayType,
    num? secPaidAmt,
    String? transactionRef,
    List<Map<String, dynamic>>? testLists,
  }) async {
    try {
      final body = <String, dynamic>{};

      if (billLocation != null) body["BillLctn"] = billLocation;
      if (assignBrId != null) body["AssignBrId"] = assignBrId;
      if (corpId != null) body["CorpID"] = corpId;
      if (patId != null) body["patId"] = patId;
      if (namePrefix != null) body["NamePrefix"] = namePrefix;
      if (patName != null) body["patName"] = patName;
      if (patAddress != null) body["patAddress"] = patAddress;
      if (invNo != null) body["Inv_No"] = invNo;
      if (patEmail != null) body["patEmail"] = patEmail;
      if (patPhno != null) body["patPhno"] = patPhno;
      if (patMobno != null) body["patMobno"] = patMobno;
      if (patAge != null) body["patAge"] = patAge;
      if (patAgeHead != null) body["patAgehead"] = patAgeHead;
      if (patGender != null) body["patGender"] = patGender;
      if (currentDateTime != null) body["CurrentDatetime"] = currentDateTime;
      if (drId != null) body["DrId"] = drId;
      if (outDr != null) body["OutDr"] = outDr;
      if (passport != null) body["Passport"] = passport;
      if (repEmail != null) body["RepEmail"] = repEmail;
      if (repWhatsapp != null) body["RepWhtapp"] = repWhatsapp;
      if (urgent != null) body["Urgent"] = urgent;
      if (remarks != null) body["Remarks"] = remarks;
      if (ipop != null) body["Ipop"] = ipop;
      if (discRsnId != null) body["DiscRsnId"] = discRsnId;
      if (patImg != null) body["PatImg"] = patImg;
      if (dob != null) body["Dob"] = dob;
      if (driverId != null) body["DriverId"] = driverId;
      if (technicianId != null) body["TechntnId"] = technicianId;
      if (grossAmt != null) body["GrossAmt"] = grossAmt;
      if (discAmt != null) body["DiscAmt"] = discAmt;
      if (servCharge != null) body["ServChrge"] = servCharge;
      if (netAmt != null) body["NetAmt"] = netAmt;
      if (paidAmt != null) body["PaidAmt"] = paidAmt;
      if (balance != null) body["Balance"] = balance;
      if (paymentType != null) body["PaymentType"] = paymentType;
      if (insId != null) body["Insid"] = insId;
      if (insNo != null) body["InsNo"] = insNo;
      if (startTime != null) body["StartTime"] = startTime;
      if (endTime != null) body["EndTime"] = endTime;
      if (priPaidAmt != null) body["PriPaidAmt"] = priPaidAmt;
      if (secPayType != null) body["SecPayType"] = secPayType;
      if (secPaidAmt != null) body["SecPaidAmt"] = secPaidAmt;
      if (transactionRef != null) {
        body["TransactnRefDet"] = transactionRef;
      }
      if (testLists != null) body["Testlists"] = testLists;

      final response = await PostApiServices.callApi(
        body: {
          "YrId": 2425,
          "BrId": AppConstants.branchID,
          "DevCode": AppConstants.deviceID,
          "Pat_List": [body],
        },
        url: ApiConstants.patientSync,
      );

      if (response == null) return null;

      return response['Success'];
    } catch (e) {
      log("Patient Sync API Error: $e");
      return null;
    }
  }
}
