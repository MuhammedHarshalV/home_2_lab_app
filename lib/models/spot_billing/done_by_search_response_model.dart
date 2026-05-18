// To parse this JSON data, do
//
//     final doneBySearchResponseModel = doneBySearchResponseModelFromJson(jsonString);

import 'dart:convert';

DoneBySearchResponseModel doneBySearchResponseModelFromJson(String str) =>
    DoneBySearchResponseModel.fromJson(json.decode(str));

String doneBySearchResponseModelToJson(DoneBySearchResponseModel data) =>
    json.encode(data.toJson());

class DoneBySearchResponseModel {
  bool? success;
  List<AccountsList>? accountsList;

  DoneBySearchResponseModel({this.success, this.accountsList});

  factory DoneBySearchResponseModel.fromJson(Map<String, dynamic> json) =>
      DoneBySearchResponseModel(
        success: json["Success"],
        accountsList: json["AccountsList"] == null
            ? []
            : List<AccountsList>.from(
                json["AccountsList"]!.map((x) => AccountsList.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
    "Success": success,
    "AccountsList": accountsList == null
        ? []
        : List<dynamic>.from(accountsList!.map((x) => x.toJson())),
  };
}

class AccountsList {
  int? key;
  String? name;
  String? type;
  int? schemeId;

  AccountsList({this.key, this.name, this.type, this.schemeId});

  factory AccountsList.fromJson(Map<String, dynamic> json) => AccountsList(
    key: json["Key"],
    name: json["Name"],
    type: json["Type"],
    schemeId: json["SchemeId"],
  );

  Map<String, dynamic> toJson() => {
    "Key": key,
    "Name": name,
    "Type": type,
    "SchemeId": schemeId,
  };
}
