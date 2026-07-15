import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:icon_infoware/controller/add_test_screen_controller/add_test_screen_controller.dart';
import 'package:icon_infoware/controller/color_controller/color_controller.dart';
import 'package:icon_infoware/controller/home_screen_controller/home_screen_controller.dart';
import 'package:icon_infoware/controller/timer_controller/timer_controller.dart';
import 'package:icon_infoware/core/errors/api_errors/api_errors.dart';
import 'package:icon_infoware/core/services/location_services/location_services.dart';
import 'package:icon_infoware/core/services/network_services/connection_checking.dart';
import 'package:icon_infoware/core/themes/colors.dart';
import 'package:icon_infoware/models/patient_bill_syncing_model/patient_bill_syncing_model.dart';

class ActiveSessionCard extends ConsumerWidget {
  const ActiveSessionCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watching the timer state and accessing controller logic
    final timerState = ref.watch(customTimerProvider);
    final timerController = ref.read(customTimerProvider.notifier);
    final colorState = ref.watch(colorProvider);
    final homeState = ref.watch(homeScreenProvider);
    final homeController = ref.read(homeScreenProvider.notifier);
    final addTestController = ref.read(addTestScreenProvider.notifier);

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: colorState.secondaryColor.withOpacity(.2),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: colorState.primaryColor.withOpacity(.2),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header Row
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xFFFFEBEE), // Soft red background
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: colorState.primaryColor.withOpacity(.2),
                  ),
                ),
                child: Icon(
                  Icons.access_time_filled,
                  color: colorState.primaryColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Active Session",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    "Track your shift duration",
                    style: TextStyle(
                      color: AppColors.appGrey,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              // Status Badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 3,
                      backgroundColor: timerState.isRunning
                          ? Colors.green
                          : Colors.grey,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      timerState.isRunning ? "Active" : "Not active",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Timer Text
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFFFEBEE),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Row(
                spacing: 15,
                children: [
                  Text(
                    timerController.getFormattedTime(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      //letterSpacing: -1,
                      color: AppColors.appBlack,
                      //Color(0xFF1A1C1E),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        try {
                          final Position position = await getCurrentLocation();

                          timerController.toggleTimer();
                          final bool isConnect =
                              await InternetChecker.hasConnection();
                          if (isConnect == true) {
                            timerController.userLocationApi(
                              position: position,
                              isStart: timerState.label == 'Stop'
                                  ? false
                                  : true,
                            );
                            if (timerState.label == 'Stop') {
                              final List<PatientHiveModel> patients = [];
                              for (final patient
                                  in homeState.allBookingDetails) {
                                if (patient.isCompleted == 'Yes' &&
                                    patient.isSync != 'Yes') {
                                  patients.add(patient);
                                }
                              }

                              final bool isSync = await addTestController
                                  .patientBillSyncingApi(
                                    patient: patients,
                                    context: context,
                                  );
                              if (isSync == true) {
                                for (final patient in patients) {
                                  await homeController.updatePatient(
                                    index: patient.indexClick ?? 0,
                                    isSync: "Yes",
                                  );
                                }
                                AppMessage.show(
                                  context,
                                  'Patient records synced successfully.',
                                );
                              }
                            }
                          }
                        } catch (e) {
                          debugPrint(e.toString());
                        }
                      },
                      icon: Icon(
                        timerState.isRunning ? Icons.pause : Icons.play_arrow,
                      ),
                      label: Text(timerState.isRunning ? "Stop" : "Start"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  // Expanded(
                  //   child: TextButton.icon(
                  //     onPressed: () => timerController.resetTimer(),
                  //     icon: const Icon(Icons.refresh),
                  //     label: const Text("Reset"),
                  //     style: TextButton.styleFrom(
                  //       foregroundColor: AppColors.appWhite,
                  //       backgroundColor: AppColors.appRed,
                  //       padding: const EdgeInsets.symmetric(vertical: 3),
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(10),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          //const SizedBox(height: 24),
          // Action Buttons
          // Row(
          //   children: [
          //     Expanded(
          //       child: ElevatedButton.icon(
          //         onPressed: () => timerController.toggleTimer(),
          //         icon: Icon(
          //           timerState.isRunning ? Icons.pause : Icons.play_arrow,
          //         ),
          //         label: Text(timerState.isRunning ? "Stop" : "Start"),
          //         style: ElevatedButton.styleFrom(
          //           backgroundColor:colorState.primaryColor,
          //           foregroundColor: Colors.white,
          //           elevation: 0,
          //           padding: const EdgeInsets.symmetric(vertical: 16),
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(10),
          //           ),
          //         ),
          //       ),
          //     ),
          //     const SizedBox(width: 12),
          //     Expanded(
          //       child: OutlinedButton.icon(
          //         onPressed: () => timerController.resetTimer(),
          //         icon: const Icon(Icons.refresh),
          //         label: const Text("Reset"),
          //         style: OutlinedButton.styleFrom(
          //           foregroundColor:colorState.primaryColor,
          //           backgroundColor: const Color(0xFFFFEBEE),
          //           side: BorderSide.none,
          //           padding: const EdgeInsets.symmetric(vertical: 16),
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(10),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
