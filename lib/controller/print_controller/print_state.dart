import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

enum PaperType { mm58, mm72, mm80 }

class PrintState {
  final bool isLoading;
  final List<BluetoothInfo> printDevices;
  final BluetoothInfo? selectedPrinter;
  final PaperType paperType;

  const PrintState({
    this.isLoading = false,
    this.printDevices = const [],
    this.selectedPrinter,
    this.paperType = PaperType.mm58,
  });

  PrintState copyWith({
    bool? isLoading,
    List<BluetoothInfo>? printDevices,
    BluetoothInfo? selectedPrinter,
    PaperType? paperType,
  }) {
    return PrintState(
      isLoading: isLoading ?? this.isLoading,
      printDevices: printDevices ?? this.printDevices,
      selectedPrinter: selectedPrinter ?? this.selectedPrinter,
      paperType: paperType ?? this.paperType,
    );
  }
}
