import 'package:icon_infoware/models/home_screen/booking_patient_response_model.dart';
import 'package:icon_infoware/models/patient_bill_syncing_model/patient_bill_syncing_model.dart';


class HomeScreenState {
  final List<PatientHiveModel> patientBookingList;
  final List<PatientHiveModel> patientBookingListCompleted;
  final List<PatientHiveModel> patientBookingListPending;

  final bool isLoading;

  HomeScreenState({
    this.patientBookingList = const [],
    this.isLoading = false,
    this.patientBookingListCompleted = const [],
    this.patientBookingListPending = const [],
  });
  HomeScreenState copyWith({
    List<PatientHiveModel>? patientBookingList,
    List<PatientHiveModel>? patientBookingListCompleted,
    List<PatientHiveModel>? patientBookingListPending,

    bool? isLoading,
  }) {
    return HomeScreenState(
      patientBookingList: patientBookingList ?? this.patientBookingList,
      patientBookingListPending:
          patientBookingListPending ?? this.patientBookingListPending,

      patientBookingListCompleted:
          patientBookingListCompleted ?? this.patientBookingListCompleted,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
