import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart';
import 'package:icon_infoware/core/errors/api_errors/api_errors.dart';
import 'package:image/image.dart' as img;
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import 'package:screenshot/screenshot.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'print_state.dart';

class PrintController extends StateNotifier<PrintState> {
  PrintController() : super(const PrintState()) {
    initialCall();
  }

  Future<void> initialCall() async {
    final prefs = await SharedPreferences.getInstance();

    final value = prefs.getString('saved_bluetooth_printer');

    if (value == null || value.isEmpty) {
      return;
    }

    final Map<String, dynamic> data = jsonDecode(value);
    BluetoothInfo get = BluetoothInfo(
      name: data['name'] ?? '',
      macAdress: data['macAdress'] ?? '',
    );
    state = state.copyWith(selectedPrinter: get);
    log('initial get name${get.name} mac address ${get.macAdress}');
    final paper = prefs.getString('papper_type');
    if (paper == null || paper.isEmpty) {
      return;
    } else if (paper == '58') {
      state = state.copyWith(paperType: PaperType.mm58);
    } else if (paper == '72') {
      state = state.copyWith(paperType: PaperType.mm72);
    } else if (paper == '80') {
      state = state.copyWith(paperType: PaperType.mm80);
    }
    log('initial paper $paper');
  }

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
    state = state.copyWith(
      isLoading: isLoading,
      printDevices: item ?? state.printDevices,
    );
  }

  Future<void> selectPrinter(BluetoothInfo printer) async {
    state = state.copyWith(selectedPrinter: printer);

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      'saved_bluetooth_printer',
      jsonEncode({'name': printer.name, 'macAdress': printer.macAdress}),
    );
    log('name ${printer.name} mac address ${printer.macAdress}');
  }

  Future<void> changePaper(PaperType type) async {
    state = state.copyWith(paperType: type);
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      'papper_type',
      type == PaperType.mm58
          ? "58"
          : type == PaperType.mm72
          ? "72"
          : '80',
    );
    log('papertype $type');
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

  Future<void> printWidget(
    ScreenshotController controller,
    BuildContext context,
  ) async {
    try {
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
        AppMessage.show(
          context,
          'Please turn on Bluetooth to connect to the printer.',
        );

        state = state.copyWith(isLoading: false);
        log(state.paperType.toString());

        return;
      }

      final image = await controller.capture(pixelRatio: 3);

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
    } catch (e) {
      log(e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}

final printProvider = StateNotifierProvider<PrintController, PrintState>((ref) {
  return PrintController();
});
