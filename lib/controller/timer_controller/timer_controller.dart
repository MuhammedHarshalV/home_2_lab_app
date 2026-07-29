import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:icon_infoware/apis/location_api/location_send_api.dart';
import 'package:icon_infoware/controller/timer_controller/timer_state.dart';
import 'package:icon_infoware/core/constants/app_constants.dart';
import 'package:intl/intl.dart';

class TimerController extends StateNotifier<CustomTimerState> {
  TimerController() : super(CustomTimerState());

  Timer? _timer;

  void toggleTimer() {
    if (state.isRunning) {
      // STOP
      _timer?.cancel();

      state = state.copyWith(
        isRunning: false,
        label: 'Start',
        seconds: 0, // Reset to 00:00:00
      );
    } else {
      // START
      state = state.copyWith(isRunning: true, label: 'Stop', seconds: 0);

      _timer?.cancel();

      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        state = state.copyWith(seconds: state.seconds + 1);
      });
    }
  }

  Future<void> userLocationApi({
    required Position position,
    required bool isStart,
  }) async {
    await LocationSendApi.locationSendApi(
      body: {
        "UsrId": AppConstants.userId,
        "CurrDateTime": DateFormat('yyyy-MM-dd').format(DateTime.now()),
        "Latitude": "${position.latitude}, ${position.longitude}",
        "Device_Code": AppConstants.deviceID,
        "UsrLoc_IsStartLoc boolean": isStart,
      },
    );
  }

  void resetTimer() {
    _timer?.cancel();
    state = CustomTimerState();
  }

  String getFormattedTime() {
    final hours = (state.seconds ~/ 3600).toString().padLeft(2, '0');
    final minutes = ((state.seconds % 3600) ~/ 60).toString().padLeft(2, '0');
    final seconds = (state.seconds % 60).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

// Global Provider
final customTimerProvider =
    StateNotifierProvider<TimerController, CustomTimerState>((ref) {
      return TimerController();
    });
