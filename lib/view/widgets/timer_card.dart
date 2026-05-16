import 'package:flutter/material.dart';
import 'package:icon_infoware/controller/timer_controller/timer_controller.dart';
import 'package:icon_infoware/controller/timer_controller/timer_state.dart';
import 'package:icon_infoware/core/themes/colors.dart';

class TimerCard extends StatelessWidget {
  const TimerCard({
    super.key,
    required this.timerState,
    required this.timerController,
  });

  final CustomTimerState timerState;
  final TimerController timerController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: AppColors.appPrimaryColor, // Light green background
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
         mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(
              timerState.isRunning ? Icons.pause : Icons.play_arrow,
              color: AppColors.appWhite, // Brand green
            ),
            onPressed: () => timerController.toggleTimer(),
          ),
          Text(
            "${timerState.label}  ${timerController.getFormattedTime()}",
            style: const TextStyle(
              color: AppColors.appWhite,
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace', // Keeps the timer text stable
            ),
          ),
        ],
      ),
    );
  }
}
