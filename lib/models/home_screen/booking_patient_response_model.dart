// To parse this JSON data, do
//
//     final bookingDetailsResponseModel = bookingDetailsResponseModelFromJson(jsonString);

import 'dart:convert';

BookingDetailsResponseModel bookingDetailsResponseModelFromJson(String str) =>
    BookingDetailsResponseModel.fromJson(json.decode(str));

String bookingDetailsResponseModelToJson(BookingDetailsResponseModel data) =>
    json.encode(data.toJson());

class BookingDetailsResponseModel {
  bool? success;
  List<BookPatientDetail>? bookPatientDetails;

  BookingDetailsResponseModel({this.success, this.bookPatientDetails});

  factory BookingDetailsResponseModel.fromJson(Map<String, dynamic> json) =>
      BookingDetailsResponseModel(
        success: json["Success"],
        bookPatientDetails: json["Book_PatientDetails"] == null
            ? []
            : List<BookPatientDetail>.from(
                json["Book_PatientDetails"]!.map(
                  (x) => BookPatientDetail.fromJson(x),
                ),
              ),
      );

  Map<String, dynamic> toJson() => {
    "Success": success,
    "Book_PatientDetails": bookPatientDetails == null
        ? []
        : List<dynamic>.from(bookPatientDetails!.map((x) => x.toJson())),
  };
}

class BookPatientDetail {
  num? bookNo;
  String? bookName;
  String? bookAddr;
  String? bookLandmark;
  String? bookGender;
  num? bookAge;
  String? bookAgeHead;
  String? bookPhno;
  String? bookMobno;
  String? bookDAte;
  String? bookTime;
  num? bookPatId;
  String? bookEmail;
  String? bookMapUrl;
  String? bookAbhmid;
  String? smplMode;
  String? remarks;
  num? flag;

  BookPatientDetail({
    this.bookNo,
    this.bookName,
    this.bookAddr,
    this.bookLandmark,
    this.bookGender,
    this.bookAge,
    this.bookAgeHead,
    this.bookPhno,
    this.bookMobno,
    this.bookDAte,
    this.bookTime,
    this.bookPatId,
    this.bookEmail,
    this.bookMapUrl,
    this.bookAbhmid,
    this.smplMode,
    this.remarks,
    this.flag,
  });

  factory BookPatientDetail.fromJson(Map<String, dynamic> json) =>
      BookPatientDetail(
        bookNo: json["BookNo"],
        bookName: json["BookName"],
        bookAddr: json["BookAddr"],
        bookLandmark: json["BookLandmark"],
        bookGender: json["BookGender"],
        bookAge: json["BookAge"],
        bookAgeHead: json["BookAgeHead"],
        bookPhno: json["BookPhno"],
        bookMobno: json["BookMobno"],
        bookDAte: json["BookDAte"],
        bookTime: json["BookTime"],
        bookPatId: json["BookPatId"],
        bookEmail: json["BookEmail"],
        bookMapUrl: json["BookMapUrl"],
        bookAbhmid: json["BookAbhmid"],
        smplMode: json["SmplMode"],
        remarks: json["Remarks"],
        flag: json["Flag"],
      );

  Map<String, dynamic> toJson() => {
    "BookNo": bookNo,
    "BookName": bookName,
    "BookAddr": bookAddr,
    "BookLandmark": bookLandmark,
    "BookGender": bookGender,
    "BookAge": bookAge,
    "BookAgeHead": bookAgeHead,
    "BookPhno": bookPhno,
    "BookMobno": bookMobno,
    "BookDAte": bookDAte,
    "BookTime": bookTime,
    "BookPatId": bookPatId,
    "BookEmail": bookEmail,
    "BookMapUrl": bookMapUrl,
    "BookAbhmid": bookAbhmid,
    "SmplMode": smplMode,
    "Remarks": remarks,
    "Flag": flag,
  };
}
