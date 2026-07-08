import 'package:icon_infoware/models/patient_bill_syncing_model/patient_bill_syncing_model.dart';

class HomeScreenState {
  final List<PatientHiveModel> patientBookingList;
  final List<PatientHiveModel> patientBookingListCompleted;
  final List<PatientHiveModel> patientBookingListPending;
  final List<PatientHiveModel> upcomingBookingList;
  final List<PatientHiveModel> allBookingDetails;

  final bool isLoading;

  HomeScreenState({
    this.patientBookingList = const [],
    this.allBookingDetails = const [],

    this.isLoading = false,
    this.patientBookingListCompleted = const [],
    this.patientBookingListPending = const [],
    this.upcomingBookingList = const [],
  });
  HomeScreenState copyWith({
    List<PatientHiveModel>? patientBookingList,
    List<PatientHiveModel>? patientBookingListCompleted,
    List<PatientHiveModel>? patientBookingListPending,
    List<PatientHiveModel>? upcomingBookingList,
    List<PatientHiveModel>? allBookingDetails,

    bool? isLoading,
  }) {
    return HomeScreenState(
      allBookingDetails: allBookingDetails ?? this.allBookingDetails,
      patientBookingList: patientBookingList ?? this.patientBookingList,
      patientBookingListPending:
          patientBookingListPending ?? this.patientBookingListPending,
      upcomingBookingList: upcomingBookingList ?? this.upcomingBookingList,
      patientBookingListCompleted:
          patientBookingListCompleted ?? this.patientBookingListCompleted,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
