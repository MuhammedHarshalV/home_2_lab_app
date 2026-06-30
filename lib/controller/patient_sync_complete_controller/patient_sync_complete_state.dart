import 'package:icon_infoware/models/patient_bill_syncing_model/patient_bill_syncing_model.dart';

class PatientSyncState {
  final List<PatientHiveModel> patientBookingListCompleted;
  final bool isLoading;

  const PatientSyncState({
    this.patientBookingListCompleted = const [],
    this.isLoading = false,
  });

  PatientSyncState copyWith({
    List<PatientHiveModel>? patientBookingListCompleted,
    bool? isLoading,
  }) {
    return PatientSyncState(
      patientBookingListCompleted:
          patientBookingListCompleted ?? this.patientBookingListCompleted,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
