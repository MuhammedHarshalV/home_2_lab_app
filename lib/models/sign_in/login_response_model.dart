// To parse this JSON data, do
//
//     final loginResponeModel = loginResponeModelFromJson(jsonString);

import 'dart:convert';

LoginResponeModel loginResponeModelFromJson(String str) =>
    LoginResponeModel.fromJson(json.decode(str));

String loginResponeModelToJson(LoginResponeModel data) =>
    json.encode(data.toJson());

class LoginResponeModel {
  int? maxYrId;
  int? userId;
  String? message;
  bool? success;

  LoginResponeModel({this.maxYrId, this.userId, this.message, this.success});

  factory LoginResponeModel.fromJson(Map<String, dynamic> json) =>
      LoginResponeModel(
        maxYrId: json["MaxYrId"],
        userId: json["UserId"],
        message: json["Message"],
        success: json["Success"],
      );

  Map<String, dynamic> toJson() => {
    "MaxYrId": maxYrId,
    "UserId": userId,
    "Message": message,
    "Success": success,
  };
}
