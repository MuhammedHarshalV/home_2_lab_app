// To parse this JSON data, do
//
//     final helpSupportResponseModel = helpSupportResponseModelFromJson(jsonString);

import 'dart:convert';

HelpSupportResponseModel helpSupportResponseModelFromJson(String str) =>
    HelpSupportResponseModel.fromJson(json.decode(str));

String helpSupportResponseModelToJson(HelpSupportResponseModel data) =>
    json.encode(data.toJson());

class HelpSupportResponseModel {
  bool? success;
  String? message;
  HelpAndSupport? helpAndSupport;
  HelpAndSupport? termsAndConditions;
  HelpAndSupport? privacyPolicy;

  HelpSupportResponseModel({
    this.success,
    this.message,
    this.helpAndSupport,
    this.termsAndConditions,
    this.privacyPolicy,
  });

  factory HelpSupportResponseModel.fromJson(Map<String, dynamic> json) =>
      HelpSupportResponseModel(
        success: json["Success"],
        message: json["Message"],
        helpAndSupport: json["helpAndSupport"] == null
            ? null
            : HelpAndSupport.fromJson(json["helpAndSupport"]),
        termsAndConditions: json["termsAndConditions"] == null
            ? null
            : HelpAndSupport.fromJson(json["termsAndConditions"]),
        privacyPolicy: json["privacyPolicy"] == null
            ? null
            : HelpAndSupport.fromJson(json["privacyPolicy"]),
      );

  Map<String, dynamic> toJson() => {
    "Success": success,
    "Message": message,
    "helpAndSupport": helpAndSupport?.toJson(),
    "termsAndConditions": termsAndConditions?.toJson(),
    "privacyPolicy": privacyPolicy?.toJson(),
  };
}

class HelpAndSupport {
  String? content;
  List<Information>? notifications;

  HelpAndSupport({this.content, this.notifications});

  factory HelpAndSupport.fromJson(Map<String, dynamic> json) => HelpAndSupport(
    content: json["content"],
    notifications: json["notifications"] == null
        ? []
        : List<Information>.from(
            json["notifications"]!.map((x) => Information.fromJson(x)),
          ),
  );

  Map<String, dynamic> toJson() => {
    "content": content,
    "notifications": notifications == null
        ? []
        : List<dynamic>.from(notifications!.map((x) => x.toJson())),
  };
}

class Information {
  String? type;
  String? message;

  Information({this.type, this.message});

  factory Information.fromJson(Map<String, dynamic> json) =>
      Information(type: json["type"], message: json["message"]);

  Map<String, dynamic> toJson() => {"type": type, "message": message};
}
