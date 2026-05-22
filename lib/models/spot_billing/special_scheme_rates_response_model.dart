// To parse this JSON data, do
//
//     final specialSchemeRatesResponseModel = specialSchemeRatesResponseModelFromJson(jsonString);

import 'dart:convert';

SpecialSchemeRatesResponseModel specialSchemeRatesResponseModelFromJson(
  String str,
) => SpecialSchemeRatesResponseModel.fromJson(json.decode(str));

String specialSchemeRatesResponseModelToJson(
  SpecialSchemeRatesResponseModel data,
) => json.encode(data.toJson());

class SpecialSchemeRatesResponseModel {
  bool? success;
  List<SchemeRateList>? schemeRateList;

  SpecialSchemeRatesResponseModel({this.success, this.schemeRateList});

  factory SpecialSchemeRatesResponseModel.fromJson(Map<String, dynamic> json) =>
      SpecialSchemeRatesResponseModel(
        success: json["Success"],
        schemeRateList: json["SchemeRateList"] == null
            ? []
            : List<SchemeRateList>.from(
                json["SchemeRateList"]!.map((x) => SchemeRateList.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
    "Success": success,
    "SchemeRateList": schemeRateList == null
        ? []
        : List<dynamic>.from(schemeRateList!.map((x) => x.toJson())),
  };
}

class SchemeRateList {
  int? schRateId;
  num? schRate;
  int? schRTstid;
  num? schRDisPer;
  int? acctSchemeId;

  SchemeRateList({
    this.schRateId,
    this.schRate,
    this.schRTstid,
    this.schRDisPer,
    this.acctSchemeId,
  });

  factory SchemeRateList.fromJson(Map<String, dynamic> json) => SchemeRateList(
    schRateId: json["SchRateId"],
    schRate: json["SchRate"]?.toDouble(),
    schRTstid: json["SchRTstid"],
    schRDisPer: json["SchR_DisPer"],
    acctSchemeId: json["Acct_SchemeId"],
  );

  Map<String, dynamic> toJson() => {
    "SchRateId": schRateId,
    "SchRate": schRate,
    "SchRTstid": schRTstid,
    "SchR_DisPer": schRDisPer,
    "Acct_SchemeId": acctSchemeId,
  };
}
