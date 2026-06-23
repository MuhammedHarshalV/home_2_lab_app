class PatientSyncCompleteModel {
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
  num? repEmail;
  String? smplMode;
  num? repWhtapp;
  String? ipop;
  String? patImg;
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
  String? paymentType;
  String? insid;
  String? insNo;
  List<Map<String, dynamic>>? testlists;
  String? completed;

  PatientSyncCompleteModel({
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
    this.outDr,
    this.flag,
    this.patEmail,
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
    this.paymentType,
    this.insid,
    this.insNo,
    this.testlists,
    this.completed,
  });

  factory PatientSyncCompleteModel.fromMap(Map<dynamic, dynamic> map) {
    return PatientSyncCompleteModel(
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
      paymentType: map['paymentType'] ?? '',
      insid: map['insid'] ?? '',
      insNo: map['insNo'] ?? '',
      testlists: map['testlists'] != null
          ? (map['testlists'] as List)
                .map((e) => Map<String, dynamic>.from(e as Map))
                .toList()
          : [],
      completed: map['completed'] ?? 'No',
    );
  }

  Map<dynamic, dynamic> toMap() {
    return {
      'patId': patId,
      'namePrefix': namePrefix,
      'patName': patName,
      'patAddress': patAddress,
      'invNo': invNo,
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
      'flag': flag,
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
      'paymentType': paymentType,
      'insid': insid,
      'insNo': insNo,
      'testlists': testlists,
    };
  }
}
