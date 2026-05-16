import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icon_infoware/controller/timer_controller/timer_state.dart';

class TimerController extends StateNotifier<CustomTimerState> {
  TimerController() : super(CustomTimerState());

  Timer? _timer;

  void toggleTimer() {
    if (state.isRunning) {
      _timer?.cancel();
      state = state.copyWith(isRunning: false, label: 'Start');
    } else {
      state = state.copyWith(isRunning: true, label: 'Stop');
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        state = state.copyWith(seconds: state.seconds + 1);
      });
    }
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