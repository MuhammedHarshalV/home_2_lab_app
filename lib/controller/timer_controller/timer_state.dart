class CustomTimerState {
  final int seconds;
  final bool isRunning;
  final String label; // For "Stop" or "Start" text

  CustomTimerState({
    this.seconds = 0,
    this.isRunning = false,
    this.label = 'Start',
  });

  CustomTimerState copyWith({
    int? seconds,
    bool? isRunning,
    String? label,
  }) {
    return CustomTimerState(
      seconds: seconds ?? this.seconds,
      isRunning: isRunning ?? this.isRunning,
      label: label ?? this.label,
    );
  }
}