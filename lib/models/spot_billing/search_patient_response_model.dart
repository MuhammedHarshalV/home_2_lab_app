// To parse this JSON data, do
//
// final searchPatientResponseModel =
//     searchPatientResponseModelFromJson(jsonString);

import 'dart:convert';

SearchPatientResponseModel searchPatientResponseModelFromJson(String str) =>
    SearchPatientResponseModel.fromJson(json.decode(str));

String searchPatientResponseModelToJson(SearchPatientResponseModel data) =>
    json.encode(data.toJson());

class SearchPatientResponseModel {
  bool? success;
  List<PatientsList>? patientsList;

  SearchPatientResponseModel({this.success, this.patientsList});

  factory SearchPatientResponseModel.fromJson(Map<String, dynamic> json) =>
      SearchPatientResponseModel(
        success: json["Success"],
        patientsList: json["Patients_List"] == null
            ? []
            : List<PatientsList>.from(
                json["Patients_List"].map((x) => PatientsList.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
    "Success": success,
    "Patients_List": patientsList == null
        ? []
        : List<dynamic>.from(patientsList!.map((x) => x.toJson())),
  };
}

class PatientsList {
  num? discAmt;
  num? scharge;
  String? patId;
  String? namePrefix;
  String? patName;
  String? patAddress;
  String? patEmail;
  String? patPhno;
  num? patAge;
  String? patAgehead;
  String? patGender;
  String? passport;
  DateTime? dob;

  PatientsList({
    this.discAmt,
    this.scharge,
    this.patId,
    this.namePrefix,
    this.patName,
    this.patAddress,
    this.patEmail,
    this.patPhno,
    this.patAge,
    this.patAgehead,
    this.patGender,
    this.passport,
    this.dob,
  });

  factory PatientsList.fromJson(Map<String, dynamic> json) => PatientsList(
    discAmt: (json["DiscAmt"] as num?) ?? 0,
    scharge: (json["Scharge"] as num?) ?? 0,
    patId: json["patId"]?.toString(),
    namePrefix: json["NamePrefix"],
    patName: json["patName"],
    patAddress: json["patAddress"],
    patEmail: json["patEmail"],
    patPhno: json["patPhno"],
    patAge: json["patAge"],
    patAgehead: json["patAgehead"],
    patGender: json["patGender"],
    passport: json["Passport"],
    dob: json["Dob"] == null ? null : DateTime.tryParse(json["Dob"]),
  );

  Map<String, dynamic> toJson() => {
    "DiscAmt": discAmt,
    "Scharge": scharge,
    "patId": patId,
    "NamePrefix": namePrefix,
    "patName": patName,
    "patAddress": patAddress,
    "patEmail": patEmail,
    "patPhno": patPhno,
    "patAge": patAge,
    "patAgehead": patAgehead,
    "patGender": patGender,
    "Passport": passport,
    "Dob": dob?.toIso8601String(),
  };

  @override
  String toString() {
    return 'PatientsList('
        'patName: $patName, '
        'patAge: $patAge, '
        'patGender: $patGender, '
        'patPhno: $patPhno'
        ')';
  }
}
