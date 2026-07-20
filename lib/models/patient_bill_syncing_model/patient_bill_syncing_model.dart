class PatientHiveModel {
  int? indexClick;
  int? checkId;
  num? patId;
  String? namePrefix;
  String? patName;
  String? patAddress;
  num? invNo;
  String? patGender;
  num? patAge;
  String? patAgehead;
  String? patPhno;
  String? patMobno;
  String? drId;
  String? bookMapUrl;
  String? currentDatetime;
  String? remarks;
  String? passport;
  String? outDr;
  String? flag;
  String? patEmail;
  String? upiReferenceId;
  num? repEmail;
  String? smplMode;
  num? repWhtapp;
  String? ipop;
  String? patImg;
  String? abhaId;
  String? note;
  num? urgent;
  String? bookTime;
  String? dob;
  String? driverId;
  String? techId;
  num? grossAmt;
  num? discAmt;
  num? servChrge;
  num? netAmt;
  num? paidAmt;
  num? balance;
  num? primaryPaid;
  num? secondaryPaid;
  String? secondaryType;
  String? timeToSave;
  String? dateToSave;
  String? primaryType;
  String? insid;
  String? insNo;
  String? isCompleted;
  String? isSync;
  int? specialSchemeID;
  num? rateIdSelected;
  String? specialSchemeName;
  List<Map<String, dynamic>>? testlists;

  PatientHiveModel({
    this.abhaId,
    this.note,
    this.indexClick,
    this.patId,
    this.namePrefix,
    this.patName,
    this.patAddress,
    this.invNo,
    this.patGender,
    this.patAge,
    this.patAgehead,
    this.patPhno,
    this.patMobno,
    this.drId,
    this.bookTime,
    this.bookMapUrl,
    this.currentDatetime,
    this.remarks,
    this.passport,
    this.checkId,
    this.outDr,
    this.flag,
    this.upiReferenceId,
    this.patEmail,
    this.timeToSave,
    this.dateToSave,
    this.repEmail,
    this.smplMode,
    this.repWhtapp,
    this.ipop,
    this.patImg,
    this.urgent,
    this.dob,
    this.driverId,
    this.techId,
    this.grossAmt,
    this.discAmt,
    this.servChrge,
    this.netAmt,
    this.paidAmt,
    this.balance,
    this.primaryType,
    this.insid,
    this.insNo,
    this.isCompleted,
    this.isSync,
    this.secondaryPaid,
    this.primaryPaid,
    this.secondaryType,
    this.rateIdSelected,
    this.specialSchemeID,
    this.specialSchemeName,
    this.testlists,
  });

  factory PatientHiveModel.fromMap(Map<dynamic, dynamic> map) {
    return PatientHiveModel(
      indexClick: map['indexClick'] ?? 0,
      note: map['note'] ?? '',
      abhaId: map['abhaId'] ?? '',
      checkId: map['checkId'],
      patId: map['patId'] ?? 0,
      namePrefix: map['namePrefix'] ?? '',
      patName: map['patName'] ?? '',
      patAddress: map['patAddress'] ?? '',
      invNo: map['invNo'] ?? 0,
      patGender: map['patGender'] ?? '',
      patAge: map['patAge'] ?? 0,
      patAgehead: map['patAgehead'] ?? '',
      patPhno: map['patPhno'] ?? '',
      bookTime: map['bookTime'] ?? '',
      patMobno: map['patMobno'] ?? '',
      drId: map['drId'] ?? '',
      timeToSave: map['timeToSave'] ?? '',
      dateToSave: map['dateToSave'] ?? '',

      upiReferenceId: map['upiReferenceId'] ?? '',
      bookMapUrl: map['bookMapUrl'] ?? '',
      currentDatetime: map['currentDatetime'] ?? '',
      remarks: map['remarks'] ?? '',
      passport: map['passport'] ?? '',
      outDr: map['outDr'] ?? '',
      flag: map['flag'] ?? '',
      patEmail: map['patEmail'] ?? '',
      repEmail: map['repEmail'] ?? 0,
      smplMode: map['smplMode'] ?? '',
      repWhtapp: map['repWhtapp'] ?? 0,
      ipop: map['ipop'] ?? '',
      patImg: map['patImg'] ?? '',
      urgent: map['urgent'] ?? 0,
      dob: map['dob'] ?? '',
      driverId: map['driverId'] ?? '',
      techId: map['techId'] ?? '',
      grossAmt: map['grossAmt'] ?? 0,
      discAmt: map['discAmt'] ?? 0,
      servChrge: map['servChrge'] ?? 0,
      netAmt: map['netAmt'] ?? 0,
      paidAmt: map['paidAmt'] ?? 0,
      balance: map['balance'] ?? 0,
      primaryType: map['primaryType'] ?? '',
      insid: map['insid'] ?? '',
      insNo: map['insNo'] ?? '',
      isCompleted: map['isCompleted'] ?? "",
      isSync: map['isSync'] ?? "",
      primaryPaid: map['primaryPaid'] ?? "",
      secondaryPaid: map['secondaryPaid'] ?? "",
      secondaryType: map['secondaryType'] ?? "",
      specialSchemeID: map["specialSchemeID"] ?? 0,
      rateIdSelected: map["rateIdSelected"] ?? 0,
      specialSchemeName: map["specialSchemeName"] ?? '',
      testlists: map['testlists'] != null
          ? (map['testlists'] as List)
                .map((e) => Map<String, dynamic>.from(e as Map))
                .toList()
          : [],
    );
  }

  Map<dynamic, dynamic> toMap() {
    return {
      'indexClick': indexClick,
      'patId': patId,
      'namePrefix': namePrefix,
      'patName': patName,
      'patAddress': patAddress,
      'invNo': invNo,
      'checkId': checkId,
      'patGender': patGender,
      'patAge': patAge,
      'patAgehead': patAgehead,
      'patPhno': patPhno,
      'bookTime': bookTime,
      'patMobno': patMobno,
      'drId': drId,
      'bookMapUrl': bookMapUrl,
      'currentDatetime': currentDatetime,
      'remarks': remarks,
      'passport': passport,
      'outDr': outDr,
      'upiReferenceId': upiReferenceId,
      'flag': flag,
      'timeToSave': timeToSave,
      'dateToSave': dateToSave,
      'patEmail': patEmail,
      'repEmail': repEmail,
      'smplMode': smplMode,
      'repWhtapp': repWhtapp,
      'ipop': ipop,
      'patImg': patImg,
      'urgent': urgent,
      'dob': dob,
      'driverId': driverId,
      'techId': techId,
      'grossAmt': grossAmt,
      'discAmt': discAmt,
      'servChrge': servChrge,
      'netAmt': netAmt,
      'paidAmt': paidAmt,
      'balance': balance,
      'primaryType': primaryType,
      'insid': insid,
      'insNo': insNo,
      "abhaId": abhaId,
      "note": note,
      'isCompleted': isCompleted,
      'isSync': isSync,
      'primaryPaid': primaryPaid,
      'secondaryPaid': secondaryPaid,
      'secondaryType': secondaryType,
      "specialSchemeName": specialSchemeName,
      "rateIdSelected": rateIdSelected,
      "specialSchemeID": specialSchemeID,
      'testlists': testlists,
    };
  }

  PatientHiveModel copyWith({
    String? bookTime,
    String? currentDatetime,
    String? timeToSave,
    String? dateToSave,
  }) {
    return PatientHiveModel(
      indexClick: indexClick,
      patId: patId,
      namePrefix: namePrefix,
      patName: patName,
      patAddress: patAddress,
      invNo: invNo,
      patGender: patGender,
      patAge: patAge,
      checkId: checkId,
      patAgehead: patAgehead,
      patPhno: patPhno,
      patMobno: patMobno,
      drId: drId,
      bookTime: bookTime ?? this.bookTime,
      bookMapUrl: bookMapUrl,
      currentDatetime: currentDatetime ?? this.currentDatetime,
      remarks: remarks,
      passport: passport,
      outDr: outDr,
      abhaId: abhaId,
      note: note,
      flag: flag,
      patEmail: patEmail,
      upiReferenceId: upiReferenceId,
      timeToSave: timeToSave ?? this.timeToSave,
      dateToSave: dateToSave ?? this.dateToSave,
      repEmail: repEmail,
      smplMode: smplMode,
      repWhtapp: repWhtapp,
      ipop: ipop,
      patImg: patImg,
      urgent: urgent,
      dob: dob,
      driverId: driverId,
      techId: techId,
      grossAmt: grossAmt,
      discAmt: discAmt,
      servChrge: servChrge,
      netAmt: netAmt,
      paidAmt: paidAmt,
      balance: balance,
      primaryPaid: primaryPaid,
      secondaryPaid: secondaryPaid,
      primaryType: primaryType,
      secondaryType: secondaryType,
      insid: insid,
      insNo: insNo,
      isCompleted: isCompleted,
      isSync: isSync,
      testlists: testlists == null
          ? null
          : List<Map<String, dynamic>>.from(testlists!),
    );
  }
}
