// To parse this JSON data, do
//
//     final testMasterResponseModel = testMasterResponseModelFromJson(jsonString);

import 'dart:convert';

TestMasterResponseModel testMasterResponseModelFromJson(String str) =>
    TestMasterResponseModel.fromJson(json.decode(str));

String testMasterResponseModelToJson(TestMasterResponseModel data) =>
    json.encode(data.toJson());

class TestMasterResponseModel {
  bool? success;
  List<TestMaster>? tests;
  dynamic splRt;

  TestMasterResponseModel({this.success, this.tests, this.splRt});

  factory TestMasterResponseModel.fromJson(Map<String, dynamic> json) =>
      TestMasterResponseModel(
        success: json["Success"],
        tests: json["Tests"] == null
            ? []
            : List<TestMaster>.from(
                json["Tests"]!.map((x) => TestMaster.fromJson(x)),
              ),
        splRt: json["SplRt"],
      );

  Map<String, dynamic> toJson() => {
    "Success": success,
    "Tests": tests == null
        ? []
        : List<dynamic>.from(tests!.map((x) => x.toJson())),
    "SplRt": splRt,
  };
}

class TestMaster {
  num? testKey;
  num? testRate;
  String? testShortCode;
  String? testName;

  TestMaster({this.testKey, this.testRate, this.testShortCode, this.testName});

  factory TestMaster.fromJson(Map<String, dynamic> json) => TestMaster(
    testKey: json["TestKey"],
    testRate: json["TestRate"],
    testShortCode: json["TestShortCode"],
    testName: json["TestName"],
  );

  Map<String, dynamic> toJson() => {
    "TestKey": testKey,
    "TestRate": testRate,
    "TestShortCode": testShortCode,
    "TestName": testName,
  };
}
