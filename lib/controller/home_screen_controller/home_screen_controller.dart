import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:icon_infoware/apis/home_screen/patient_booking_details_api.dart';
import 'package:icon_infoware/controller/home_screen_controller/home_screen_state.dart';
import 'package:icon_infoware/core/services/network_services/connection_checking.dart';
import 'package:icon_infoware/models/home_screen/booking_patient_response_model.dart';
import 'package:icon_infoware/models/patient_bill_syncing_model/patient_bill_syncing_model.dart';

class HomeScreenController extends StateNotifier<HomeScreenState> {
  HomeScreenController() : super(HomeScreenState()) {
    getPatientBookingDetails(null);
  }
  Future<void> getPatientBookingDetails(bool? isApiCall) async {
    bool isConnected = await InternetChecker.hasConnection();
    try {
      state = state.copyWith(isLoading: true);
      await Future.delayed(Duration(seconds: 1));
      if (isConnected == true && isApiCall == null) {
        final BookingDetailsResponseModel response =
            await PatientBookingDetails.patientBookingDetails(context: null);
        if (response.success == true && response.bookPatientDetails != null) {
          await savePatients(
            response.bookPatientDetails ?? [],
          ); //strore to hive
          await getPatientsFromHive(); //read from hive and update state
        } else {
          await getPatientsFromHive(); //read from hive and update state
        }
      } else {
        await getPatientsFromHive(); //read from hive and update state
      }
    } catch (e) {
      log(e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  //store list of booking details to hive
  Future<void> savePatients(List<BookPatientDetail> patients) async {
    final box = await Hive.openBox('patient_booking');

    for (final patient in patients) {
      final exists = box.values.any((item) => item['invNo'] == patient.bookNo);
      if (exists) {
        log("exist this one in hive this :$patient");
      }
      if (!exists) {
        log("save to hive one :$patient");
        await box.add({
          'patId': patient.bookPatId ?? 0,
          'namePrefix': '',
          'patName': patient.bookName ?? '',
          'patAddress': patient.bookAddr ?? '',
          'invNo': patient.bookNo ?? 0,
          'patGender': patient.bookGender ?? '',
          'patAge': patient.bookAge ?? 0,
          'patAgehead': patient.bookAgeHead ?? '',
          'patPhno': patient.bookPhno ?? '',
          'patMobno': patient.bookMobno ?? '',
          'drId': '',
          'bookMapUrl': patient.bookMapUrl,
          'currentDatetime': '',
          'remarks': patient.remarks ?? '',
          'passport': '',
          'outDr': '',
          'flag': patient.flag.toString(),
          'patEmail': patient.bookEmail ?? '',
          'repEmail': 1,
          'smplMode': patient.smplMode,
          'repWhtapp': 1,
          'bookTime': patient.bookTime ?? '',
          'ipop': '',
          'patImg': '',
          'urgent': 0,
          'dob': '',
          'upiReferenceId': '',
          'driverId': '',
          'techId': '',
          'grossAmt': 0,
          'discAmt': 0,
          'servChrge': 0,
          'netAmt': 0,
          'paidAmt': 0,
          'balance': 0,
          'primaryType': '',
          'insid': '',
          'insNo': '',
          'isCompleted': 'No',
          "isSync": 'No',
          "secondaryType": "",
          "secondaryPaid": 0,
          "primaryPaid": 0,
          "timeToSave": '',
          'dateToSave': '',
          // Save test list also
          'testlists': [
            {"TestId": '0'},
          ],
        });
      }
    }
  }

  //store patient details to hive
  Future<void> savePatient(PatientHiveModel patient) async {
    final box = await Hive.openBox('patient_booking');

    await box.add({
      'patId': patient.patId ?? '',
      'namePrefix': patient.namePrefix ?? '',
      'patName': patient.patName ?? '',
      'patAddress': patient.patAddress ?? '',
      'invNo': patient.invNo ?? 0,
      'patGender': patient.patGender ?? '',
      'patAge': patient.patAge ?? 0,
      'patAgehead': patient.patAgehead ?? '',
      'patPhno': patient.patPhno ?? '',
      'patMobno': patient.patMobno ?? '',
      'drId': '',
      'upiReferenceId': '',
      "bookTime": patient.bookTime ?? '',
      'bookMapUrl': '',
      'currentDatetime': '',
      'remarks': patient.remarks ?? '',
      'passport': patient.passport ?? '',
      'outDr': '',
      'flag': '0',
      'patEmail': patient.patEmail ?? '',
      'repEmail': 1,
      'smplMode': "Random",
      'repWhtapp': 1,
      'ipop': '',
      'patImg': '',
      'urgent': 0,
      'dob': '',
      'driverId': '',
      'techId': '',
      'grossAmt': 0,
      'discAmt': 0,
      'servChrge': 0,
      'netAmt': 0,
      'paidAmt': 0,
      'balance': 0,
      'primaryType': '',
      'insid': '',
      'insNo': '',
      'isCompleted': patient.isCompleted ?? '',
      "isSync": patient.isSync ?? '',
      "secondaryType": "",
      "secondaryPaid": 0,
      "primaryPaid": 0,
      "timeToSave": '',
      'dateToSave': '',
      // Save test list also
      'testlists': [
        {"TestId": '0'},
      ],
    });
    await getPatientBookingDetails(true);
  }

  //edit stored data
  Future<void> updatePatient({
    required int index,
    String? patId,
    String? namePrefix,
    String? patName,
    String? patAddress,
    num? invNo,
    String? patGender,
    num? patAge,
    String? patAgehead,
    String? patPhno,
    String? patMobno,
    String? drId,
    String? bookTime,
    String? bookMapUrl,
    String? currentDatetime,
    String? remarks,
    String? passport,
    String? outDr,
    String? flag,
    String? patEmail,
    num? repEmail,
    String? smplMode,
    num? repWhtapp,
    String? ipop,
    String? patImg,
    num? urgent,
    String? dob,
    String? driverId,
    String? techId,
    num? grossAmt,
    num? discAmt,
    num? servChrge,
    num? netAmt,
    num? paidAmt,
    num? balance,
    num? secondaryPaid,
    num? primaryPaid,
    String? upiReferenceId,
    String? secondaryType,
    String? primaryType,
    String? insid,
    String? insNo,
    String? isCompleted,
    String? isSync,
    String? timeToSave,
    String? dateToSave,

    List<Map<String, dynamic>>? testlists,
  }) async {
    final box = await Hive.openBox('patient_booking');

    final oldData = Map<String, dynamic>.from(box.getAt(index));

    oldData['patId'] = patId ?? oldData['patId'];
    oldData['namePrefix'] = namePrefix ?? oldData['namePrefix'];
    oldData['patName'] = patName ?? oldData['patName'];
    oldData['patAddress'] = patAddress ?? oldData['patAddress'];
    oldData['invNo'] = invNo ?? oldData['invNo'];
    oldData['patGender'] = patGender ?? oldData['patGender'];
    oldData['patAge'] = patAge ?? oldData['patAge'];
    oldData['patAgehead'] = patAgehead ?? oldData['patAgehead'];
    oldData['patPhno'] = patPhno ?? oldData['patPhno'];
    oldData['patMobno'] = patMobno ?? oldData['patMobno'];
    oldData['drId'] = drId ?? oldData['drId'];
    oldData['bookTime'] = bookTime ?? oldData['bookTime'];
    oldData['bookMapUrl'] = bookMapUrl ?? oldData['bookMapUrl'];
    oldData['currentDatetime'] = currentDatetime ?? oldData['currentDatetime'];
    oldData['remarks'] = remarks ?? oldData['remarks'];
    oldData['passport'] = passport ?? oldData['passport'];
    oldData['outDr'] = outDr ?? oldData['outDr'];
    oldData['flag'] = flag ?? oldData['flag'];
    oldData['patEmail'] = patEmail ?? oldData['patEmail'];
    oldData['repEmail'] = repEmail ?? oldData['repEmail'];
    oldData['smplMode'] = smplMode ?? oldData['smplMode'];
    oldData['repWhtapp'] = repWhtapp ?? oldData['repWhtapp'];
    oldData['ipop'] = ipop ?? oldData['ipop'];
    oldData['upiReferenceId'] = upiReferenceId ?? oldData['upiReferenceId'];
    oldData['timeToSave'] = timeToSave ?? oldData['timeToSave'];
    oldData['dateToSave'] = dateToSave ?? oldData['dateToSave'];

    oldData['patImg'] = patImg ?? oldData['patImg'];
    oldData['urgent'] = urgent ?? oldData['urgent'];
    oldData['dob'] = dob ?? oldData['dob'];
    oldData['driverId'] = driverId ?? oldData['driverId'];
    oldData['techId'] = techId ?? oldData['techId'];
    oldData['grossAmt'] = grossAmt ?? oldData['grossAmt'];
    oldData['discAmt'] = discAmt ?? oldData['discAmt'];
    oldData['servChrge'] = servChrge ?? oldData['servChrge'];
    oldData['netAmt'] = netAmt ?? oldData['netAmt'];
    oldData['paidAmt'] = paidAmt ?? oldData['paidAmt'];
    oldData['balance'] = balance ?? oldData['balance'];
    oldData['primaryType'] = primaryType ?? oldData['primaryType'];
    oldData['insid'] = insid ?? oldData['insid'];
    oldData['insNo'] = insNo ?? oldData['insNo'];
    oldData['isCompleted'] = isCompleted ?? oldData['isCompleted'];
    oldData['isSync'] = isSync ?? oldData['isSync'];
    oldData['secondaryType'] = secondaryType ?? oldData['secondaryType'];
    oldData['secondaryPaid'] = secondaryPaid ?? oldData['secondaryPaid'];
    oldData['primaryPaid'] = primaryPaid ?? oldData['primaryPaid'];

    oldData['testlists'] = testlists ?? oldData['testlists'];

    log('Before save: ${oldData['testlists']}');
    log('New testlists: $testlists');
    log(oldData['isSync']);
    final params = {
      'index': index,
      'patId': patId,
      'namePrefix': namePrefix,
      'patName': patName,
      'patAddress': patAddress,
      'invNo': invNo,
      'patGender': patGender,
      'patAge': patAge,
      'patAgehead': patAgehead,
      'patPhno': patPhno,
      'patMobno': patMobno,
      'drId': drId,
      'bookTime': bookTime,
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
      'primaryPaid': primaryPaid,
      'secondaryPaid': secondaryPaid,
      'primaryType': primaryType,
      'secondaryType': secondaryType,
      'upiReferenceId': upiReferenceId,
      'insid': insid,
      'insNo': insNo,
      'isCompleted': isCompleted,
      'isSync': isSync,
      "dateToSave": dateToSave,
      "timeToSave": timeToSave,
      'testlists': testlists,
    };

    params.forEach((key, value) {
      log('$key: $value');
    });
    await box.putAt(index, oldData);
    final updated = box.getAt(index);
    log('After save: ${updated['testlists']}');

    await getPatientBookingDetails(true);
    // final updateda = box.getAt(index);
    // log('After save: ${updateda['testlists']}');
  }

  //read patients details from hive
  Future<void> getPatientsFromHive() async {
    final box = await Hive.openBox('patient_booking');

    final patients = box.values.map<PatientHiveModel>((item) {
      return PatientHiveModel(
        invNo: item['invNo'],
        patId: item['patId'],
        namePrefix: item['namePrefix'],
        patName: item['patName'],
        patAddress: item['patAddress'],
        patGender: item['patGender'],
        patAge: item['patAge'],
        patAgehead: item['patAgehead'],
        patPhno: item['patPhno'],
        patMobno: item['patMobno'],
        bookTime: item['bookTime'],
        drId: item['drId'],
        currentDatetime: item['currentDatetime'],
        remarks: item['remarks'],
        passport: item['passport'],
        outDr: item['outDr'],
        patEmail: item['patEmail'],
        repEmail: item['repEmail'],
        repWhtapp: item['repWhtapp'],
        ipop: item['ipop'],
        upiReferenceId: item['upiReferenceId'],
        patImg: item['patImg'],
        urgent: item['urgent'],
        dob: item['dob'],
        driverId: item['driverId'],
        techId: item['techId'],
        grossAmt: item['grossAmt'],
        discAmt: item['discAmt'],
        servChrge: item['servChrge'],
        netAmt: item['netAmt'],
        paidAmt: item['paidAmt'],
        balance: item['balance'],
        primaryType: item['primaryType'],
        insid: item['insid'],
        insNo: item['insNo'],
        bookMapUrl: item['bookMapUrl'],
        smplMode: item['smplMode'],
        flag: item['flag'],
        isCompleted: item['isCompleted'],
        isSync: item['isSync'],
        secondaryPaid: item['secondaryPaid'],
        secondaryType: item['secondaryType'],
        primaryPaid: item['primaryPaid'],
        timeToSave: item['timeToSave'],
        dateToSave: item['dateToSave'],

        testlists: item['testlists'] != null
            ? (item['testlists'] as List)
                  .map((e) => Map<String, dynamic>.from(e as Map))
                  .toList()
            : [],
      );
    }).toList();

    //only for log
    for (int i = 0; i < patients.length; i++) {
      final testLists = patients[i].testlists ?? [];

      if (testLists.isEmpty) {
        log('Patient $i -> testlists: []');
      } else {
        log('Patient $i -> testlists: $testLists');
      }
    }

    //update state class
    state = state.copyWith(patientBookingList: patients);
  }

  //delete entire patient details
  Future<void> deletePatient(int index) async {
    final box = await Hive.openBox('patient_booking');

    if (index >= 0 && index < box.length) {
      await box.deleteAt(index);

      log('Deleted patient at index: $index');

      await getPatientsFromHive(); // Refresh state
    }
  }

  //clear hive
  Future<void> clearPatients() async {
    final box = await Hive.openBox('patient_booking');
    await box.clear();
  }
}

final homeScreenProvider =
    StateNotifierProvider<HomeScreenController, HomeScreenState>((ref) {
      return HomeScreenController();
    });
