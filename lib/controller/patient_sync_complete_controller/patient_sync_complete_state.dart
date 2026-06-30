import 'package:icon_infoware/models/patient_bill_syncing_model/patient_sync_complete_model.dart';

class PatientSyncState {
  final List<PatientSyncCompleteModel> patientBookingListCompleted;
  final bool isLoading;

  const PatientSyncState({
    this.patientBookingListCompleted = const [],
    this.isLoading = false,
  });

  PatientSyncState copyWith({
    List<PatientSyncCompleteModel>? patientBookingListCompleted,
    bool? isLoading,
  }) {
    return PatientSyncState(
      patientBookingListCompleted:
          patientBookingListCompleted ?? this.patientBookingListCompleted,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
