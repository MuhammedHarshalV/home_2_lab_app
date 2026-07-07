// To parse this JSON data, do
//
//     final bankFetchingResponseModel = bankFetchingResponseModelFromJson(jsonString);

import 'dart:convert';

BankFetchingResponseModel bankFetchingResponseModelFromJson(String str) =>
    BankFetchingResponseModel.fromJson(json.decode(str));

String bankFetchingResponseModelToJson(BankFetchingResponseModel data) =>
    json.encode(data.toJson());

class BankFetchingResponseModel {
  bool? success;
  List<BankList>? bankList;

  BankFetchingResponseModel({this.success, this.bankList});

  factory BankFetchingResponseModel.fromJson(Map<String, dynamic> json) =>
      BankFetchingResponseModel(
        success: json["Success"],
        bankList: json["BankList"] == null
            ? []
            : List<BankList>.from(
                json["BankList"]!.map((x) => BankList.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
    "Success": success,
    "BankList": bankList == null
        ? []
        : List<dynamic>.from(bankList!.map((x) => x.toJson())),
  };
}

class BankList {
  int? key;
  String? name;
  String? type;
  String? upiId;

  BankList({this.key, this.name, this.type, this.upiId});

  factory BankList.fromJson(Map<String, dynamic> json) => BankList(
    key: json["Key"],
    name: json["Name"],
    type: json["Type"],
    upiId: json["UpiId"],
  );

  Map<String, dynamic> toJson() => {
    "Key": key,
    "Name": name,
    "Type": type,
    "UpiId": upiId,
  };
}
