import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:icon_infoware/controller/patient_sync_complete_controller/patient_sync_complete_state.dart';
import 'package:icon_infoware/core/services/network_services/connection_checking.dart';
import 'package:icon_infoware/models/patient_bill_syncing_model/patient_bill_syncing_model.dart';


class PatientSyncCompleteController extends StateNotifier<PatientSyncState> {
  PatientSyncCompleteController() : super(PatientSyncState()) {
    getCompletedBillingDetails();
  }
  Future<void> getCompletedBillingDetails() async {
    bool isConnected = await InternetChecker.hasConnection();
    try {
      state = state.copyWith(isLoading: true);
      await Future.delayed(Duration(seconds: 1));
      final box = await Hive.openBox('patient_completed');
      if (box.isNotEmpty) {
        final completedList = box.values.map<PatientHiveModel>((item) {
          return PatientHiveModel(
            patId: item['patId'],
            namePrefix: item['namePrefix'],
            patName: item['patName'],
            patAddress: item['patAddress'],
            invNo: item['invNo'],
            patGender: item['patGender'],
            patAge: item['patAge'],
            patAgehead: item['patAgehead'],
            patPhno: item['patPhno'],
            patMobno: item['patMobno'],
            drId: item['drId'],
            bookTime: item['bookTime'],
            bookMapUrl: item['bookMapUrl'],
            remarks: item['remarks'],
            passport: item['passport'],
            outDr: item['outDr'],
            flag: item['flag'],
            patEmail: item['patEmail'],
            smplMode: item['smplMode'],
            ipop: item['ipop'],
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
            paymentType: item['paymentType'],
            insid: item['insid'],
            insNo: item['insNo'],
            isCompleted: item['isCompleted'],
            isSync: item['isSync'],

            testlists: item['testlists'] != null
                ? (item['testlists'] as List)
                      .map((e) => Map<String, dynamic>.from(e))
                      .toList()
                : [],
          );
        }).toList();

        state = state.copyWith(patientBookingListCompleted: completedList);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  //store patient details to hive
  Future<void> savePatientToCompletetion(PatientHiveModel patient) async {
    final box = await Hive.openBox('patient_completed');

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
      'drId': patient.drId ?? '',
      "bookTime": patient.bookTime ?? '',
      'bookMapUrl': patient.bookMapUrl ?? '',
      'currentDatetime': '',
      'remarks': patient.remarks ?? '',
      'passport': patient.passport ?? '',
      'outDr': patient.outDr ?? '',
      'flag': patient.flag ?? '',
      'patEmail': patient.patEmail ?? '',
      'repEmail': 1,
      'smplMode': patient.smplMode ?? '',
      'repWhtapp': 1,
      'ipop': patient.ipop ?? '',
      'patImg': patient.patImg ?? '',
      'urgent': patient.urgent ?? '',
      'dob': patient.dob ?? '',
      'driverId': patient.driverId ?? '',

      'techId': patient.techId ?? '',
      'grossAmt': patient.grossAmt ?? 0,
      'discAmt': patient.discAmt ?? 0,
      'servChrge': patient.servChrge ?? 0,
      'netAmt': patient.netAmt ?? 0,
      'paidAmt': patient.paidAmt ?? 0,
      'balance': patient.balance ?? 0,
      'paymentType': patient.paymentType ?? '',
      'insid': patient.insid ?? '',
      'insNo': patient.insNo ?? '',
      'isSync': patient.isSync ?? '',
      'isCompleted': patient.isCompleted ?? '',
      'testlists': patient.testlists ?? <Map<String, dynamic>>[],
    });
    await getCompletedBillingDetails();
  }

  //edit stored data
  Future<void> updatePatientCompleted({
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
    String? paymentType,
    String? insid,
    String? insNo,
    List<Map<String, dynamic>>? testlists,
    String? isCompleted,
    String? issync,
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
    oldData['paymentType'] = paymentType ?? oldData['paymentType'];
    oldData['insid'] = insid ?? oldData['insid'];
    oldData['insNo'] = insNo ?? oldData['insNo'];
    oldData['testlists'] = testlists ?? [];
    oldData['isCompleted'] = isCompleted ?? oldData['isCompleted'];
    oldData['isSync'] = issync ?? oldData['isSync'];

    log('Before save: ${oldData['testlists']}');
    log('New testlists: $testlists');

    await box.putAt(index, oldData);
    final updated = box.getAt(index);
    log('After save: ${updated['completed']}');
    await getCompletedBillingDetails();
    // final updateda = box.getAt(index);
    // log('After save: ${updateda['testlists']}');
  }

  //read patients details from hive
  // Future<void> getPatientsFromHive() async {
  //   final box = await Hive.openBox('patient_completed');

  //   final patients = box.values.map<PatientSyncCompleteModel>((item) {
  //     return PatientSyncCompleteModel(
  //       invNo: item['invNo'],
  //       patId: item['patId'],
  //       namePrefix: item['namePrefix'],
  //       patName: item['patName'],
  //       patAddress: item['patAddress'],
  //       patGender: item['patGender'],
  //       patAge: item['patAge'],
  //       patAgehead: item['patAgehead'],
  //       patPhno: item['patPhno'],
  //       patMobno: item['patMobno'],
  //       bookTime: item['bookTime'],
  //       drId: item['drId'],
  //       currentDatetime: item['currentDatetime'],
  //       remarks: item['remarks'],
  //       passport: item['passport'],
  //       outDr: item['outDr'],
  //       patEmail: item['patEmail'],
  //       repEmail: item['repEmail'],
  //       repWhtapp: item['repWhtapp'],
  //       ipop: item['ipop'],
  //       patImg: item['patImg'],
  //       urgent: item['urgent'],
  //       dob: item['dob'],
  //       driverId: item['driverId'],
  //       techId: item['techId'],
  //       grossAmt: item['grossAmt'],
  //       discAmt: item['discAmt'],
  //       servChrge: item['servChrge'],
  //       netAmt: item['netAmt'],
  //       paidAmt: item['paidAmt'],
  //       balance: item['balance'],
  //       paymentType: item['paymentType'],
  //       insid: item['insid'],
  //       insNo: item['insNo'],
  //       bookMapUrl: item['bookMapUrl'],
  //       smplMode: item['smplMode'],
  //       flag: item['flag'],
  //       testlists: item['testlists'] != null
  //           ? (item['testlists'] as List)
  //                 .map((e) => Map<String, dynamic>.from(e as Map))
  //                 .toList()
  //           : [],
  //       completed: item['completed'],
  //     );
  //   }).toList();

  //only for log
  // for (num i = 0; i < patients.length; i++) {
  //   final testLists = patients[i].testlists ?? [];

  //   if (testLists.isEmpty) {
  //     log('Patient $i -> testlists: []');
  //   } else {
  //     log('Patient $i -> testlists: $testLists');
  //   }
  // }

  //update state class
  // state = state.copyWith(patientBookingListCompleted: patients);
  //}

  //delete entire patient details
  // Future<void> deletePatient(num index) async {
  //   final box = await Hive.openBox('patient_booking');

  //   if (index >= 0 && index < box.length) {
  //     await box.deleteAt(index);

  //     log('Deleted patient at index: $index');

  //     //await getPatientsFromHive(); // Refresh state
  //   }
  // }

  //clear hive
  Future<void> clearPatients() async {
    final box = await Hive.openBox('patient_booking');
    await box.clear();
  }
}

final patientSyncCompleteProvider =
    StateNotifierProvider<PatientSyncCompleteController, PatientSyncState>((
      ref,
    ) {
      return PatientSyncCompleteController();
    });
