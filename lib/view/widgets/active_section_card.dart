import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icon_infoware/controller/timer_controller/timer_controller.dart';
import 'package:icon_infoware/core/themes/colors.dart';

class ActiveSessionCard extends ConsumerWidget {
  const ActiveSessionCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watching the timer state and accessing controller logic
    final timerState = ref.watch(customTimerProvider);
    final timerController = ref.read(customTimerProvider.notifier);

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.appWhite,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.appBlack.withOpacity(.2), width: 2),
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
                ),
                child: const Icon(
                  Icons.access_time_filled,
                  color: AppColors.appPrimaryColor,
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
                      onPressed: () => timerController.toggleTimer(),
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
                  Expanded(
                    child: TextButton.icon(
                      onPressed: () => timerController.resetTimer(),
                      icon: const Icon(Icons.refresh),
                      label: const Text("Reset"),
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.appWhite,
                        backgroundColor: AppColors.appRed,
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
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
          //           backgroundColor: AppColors.appPrimaryColor,
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
          //           foregroundColor: AppColors.appPrimaryColor,
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
