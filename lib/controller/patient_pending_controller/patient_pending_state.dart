import 'package:icon_infoware/models/patient_bill_syncing_model/patient_bill_syncing_model.dart';

class PatientPendingState {
  final List<PatientHiveModel> patientBookingListPending;
  final bool isLoading;

  const PatientPendingState({
    this.patientBookingListPending = const [],
    this.isLoading = false,
  });

  PatientPendingState copyWith({
    List<PatientHiveModel>? patientBookingListPending,
    bool? isLoading,
  }) {
    return PatientPendingState(
      patientBookingListPending:
          patientBookingListPending ?? this.patientBookingListPending,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
