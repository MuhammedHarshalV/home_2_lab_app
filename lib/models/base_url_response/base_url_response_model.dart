// To parse this JSON data, do
//
//     final baseUrlResponseModel = baseUrlResponseModelFromJson(jsonString);

import 'dart:convert';

BaseUrlResponseModel baseUrlResponseModelFromJson(String str) =>
    BaseUrlResponseModel.fromJson(json.decode(str));

String baseUrlResponseModelToJson(BaseUrlResponseModel data) =>
    json.encode(data.toJson());

class BaseUrlResponseModel {
  bool? success;
  int? flag;
  String? brName;
  String? brAddr;
  String? brPhno;
  String? webaddr;
  String? deviceCode;
  int? beginBillno;
  String? colorCode;
  String? clrTone;
  String? cusLogo;
  String? cusBWlogo;
  String? cusTagLine;
  String? cusSclMedia;
  String? qRaddr;

  BaseUrlResponseModel({
    this.success,
    this.flag,
    this.brName,
    this.brAddr,
    this.brPhno,
    this.webaddr,
    this.deviceCode,
    this.beginBillno,
    this.colorCode,
    this.clrTone,
    this.cusLogo,
    this.cusBWlogo,
    this.cusTagLine,
    this.cusSclMedia,
    this.qRaddr,
  });

  factory BaseUrlResponseModel.fromJson(Map<String, dynamic> json) =>
      BaseUrlResponseModel(
        success: json["Success"],
        flag: json["Flag"],
        brName: json["Br_name"],
        brAddr: json["Br_addr"],
        brPhno: json["Br_phno"],
        webaddr: json["Webaddr"],
        deviceCode: json["Device_Code"],
        beginBillno: json["Begin_Billno"],
        colorCode: json["ColorCode"],
        clrTone: json["ClrTone"],
        cusLogo: json["Cus_logo"],
        cusBWlogo: json["Cus_BWlogo"],
        cusTagLine: json["Cus_TagLine"],
        cusSclMedia: json["Cus_SclMedia"],
        qRaddr: json["QRaddr"],
      );

  Map<String, dynamic> toJson() => {
    "Success": success,
    "Flag": flag,
    "Br_name": brName,
    "Br_addr": brAddr,
    "Br_phno": brPhno,
    "Webaddr": webaddr,
    "Device_Code": deviceCode,
    "Begin_Billno": beginBillno,
    "ColorCode": colorCode,
    "ClrTone": clrTone,
    "Cus_logo": cusLogo,
    "Cus_BWlogo": cusBWlogo,
    "Cus_TagLine": cusTagLine,
    "Cus_SclMedia": cusSclMedia,
    "QRaddr": qRaddr,
  };
}
