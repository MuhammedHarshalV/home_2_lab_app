// To parse this JSON data, do
//
//     final normalSpecialRatesResponseModel = normalSpecialRatesResponseModelFromJson(jsonString);

import 'dart:convert';

NormalSpecialRatesResponseModel normalSpecialRatesResponseModelFromJson(
  String str,
) => NormalSpecialRatesResponseModel.fromJson(json.decode(str));

String normalSpecialRatesResponseModelToJson(
  NormalSpecialRatesResponseModel data,
) => json.encode(data.toJson());

class NormalSpecialRatesResponseModel {
  bool? success;
  List<SpclRateList>? spclRateList;

  NormalSpecialRatesResponseModel({this.success, this.spclRateList});

  factory NormalSpecialRatesResponseModel.fromJson(Map<String, dynamic> json) =>
      NormalSpecialRatesResponseModel(
        success: json["Success"],
        spclRateList: json["SpclRateList"] == null
            ? []
            : List<SpclRateList>.from(
                json["SpclRateList"]!.map((x) => SpclRateList.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
    "Success": success,
    "SpclRateList": spclRateList == null
        ? []
        : List<dynamic>.from(spclRateList!.map((x) => x.toJson())),
  };
}

class SpclRateList {
  num? rateId;
  num? rate;
  num? rateTestid;
  num? rateDiscPer;

  SpclRateList({this.rateId, this.rate, this.rateTestid, this.rateDiscPer});

  factory SpclRateList.fromJson(Map<String, dynamic> json) => SpclRateList(
    rateId: json["rateId"],
    rate: json["Rate"],
    rateTestid: json["rateTestid"],
    rateDiscPer: json["RateDiscPer"],
  );

  Map<String, dynamic> toJson() => {
    "rateId": rateId,
    "Rate": rate,
    "rateTestid": rateTestid,
    "RateDiscPer": rateDiscPer,
  };
}
