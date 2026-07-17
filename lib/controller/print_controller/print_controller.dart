import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart';
import 'package:image/image.dart' as img;
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import 'package:screenshot/screenshot.dart';

import 'print_state.dart';

class PrintController extends StateNotifier<PrintState> {
  PrintController() : super(const PrintState());

  Future<void> searchPrinters() async {
    try {
      state = state.copyWith(isLoading: true);

      final devices = await PrintBluetoothThermal.pairedBluetooths;

      state = state.copyWith(isLoading: false, printDevices: devices);
    } catch (e) {
      log(e.toString());

      // state = state.copyWith(isLoading: false);
    }
  }

  void updateState({bool? isLoading, List<BluetoothInfo>? item}) {
    state = state.copyWith(isLoading: isLoading, printDevices: item);
  }

  void selectPrinter(BluetoothInfo printer) {
    state = state.copyWith(selectedPrinter: printer);
  }

  void changePaper(PaperType type) {
    state = state.copyWith(paperType: type);
  }

  PaperSize get paperSize {
    switch (state.paperType) {
      case PaperType.mm58:
        return PaperSize.mm58;

      case PaperType.mm72:
        return PaperSize.mm80;

      case PaperType.mm80:
        return PaperSize.mm80;
    }
  }

  Future<void> printWidget(ScreenshotController controller) async {
    final printer = state.selectedPrinter;

    if (printer == null) {
      log("No printer selected");
      return;
    }

    bool connected = await PrintBluetoothThermal.connectionStatus;
    state = state.copyWith(isLoading: true);

    if (!connected) {
      connected = await PrintBluetoothThermal.connect(
        macPrinterAddress: printer.macAdress,
      );
      state = state.copyWith(isLoading: false);
      log(state.paperType.toString());
    }

    if (!connected) {
      log("Connection failed");
      state = state.copyWith(isLoading: false);
      log(state.paperType.toString());

      return;
    }

    final image = await controller.capture(pixelRatio: 6);

    if (image == null) return;

    img.Image? original = img.decodeImage(image);

    if (original == null) return;
    original = img.grayscale(original);
    original = img.contrast(original, contrast: 200);

    if (state.paperType == PaperType.mm58) {
      original = img.copyResize(
        original,
        width: 384,
        interpolation: img.Interpolation.nearest,
      );
    } else if (state.paperType == PaperType.mm72) {
      original = img.copyResize(
        original,
        width: 512,
        interpolation: img.Interpolation.nearest,
      );
    } else {
      original = img.copyResize(
        original,
        width: 576,
        interpolation: img.Interpolation.nearest,
      );
    }

    final profile = await CapabilityProfile.load();

    final generator = Generator(paperSize, profile);

    List<int> bytes = [];

    bytes += generator.imageRaster(original, align: PosAlign.center);

    bytes += generator.feed(1);

    bytes += generator.cut();

    await PrintBluetoothThermal.writeBytes(bytes);
  }
}

final printProvider = StateNotifierProvider<PrintController, PrintState>((ref) {
  return PrintController();
});
