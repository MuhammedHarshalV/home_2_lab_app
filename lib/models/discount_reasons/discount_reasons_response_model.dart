// To parse this JSON data, do
//
//     final discountReasonResponseModel = discountReasonResponseModelFromJson(jsonString);

import 'dart:convert';

DiscountReasonResponseModel discountReasonResponseModelFromJson(String str) =>
    DiscountReasonResponseModel.fromJson(json.decode(str));

String discountReasonResponseModelToJson(DiscountReasonResponseModel data) =>
    json.encode(data.toJson());

class DiscountReasonResponseModel {
  bool? success;
  List<DiscReasonList>? discReasonList;

  DiscountReasonResponseModel({this.success, this.discReasonList});

  factory DiscountReasonResponseModel.fromJson(Map<String, dynamic> json) =>
      DiscountReasonResponseModel(
        success: json["Success"],
        discReasonList: json["DiscReasonList"] == null
            ? []
            : List<DiscReasonList>.from(
                json["DiscReasonList"]!.map((x) => DiscReasonList.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
    "Success": success,
    "DiscReasonList": discReasonList == null
        ? []
        : List<dynamic>.from(discReasonList!.map((x) => x.toJson())),
  };
}

class DiscReasonList {
  int? mstKey;
  String? mstDesc;
  String? mstType;

  DiscReasonList({this.mstKey, this.mstDesc, this.mstType});

  factory DiscReasonList.fromJson(Map<String, dynamic> json) => DiscReasonList(
    mstKey: json["MstKey"],
    mstDesc: json["MstDesc"],
    mstType: json["MstType"],
  );

  Map<String, dynamic> toJson() => {
    "MstKey": mstKey,
    "MstDesc": mstDesc,
    "MstType": mstType,
  };
}
