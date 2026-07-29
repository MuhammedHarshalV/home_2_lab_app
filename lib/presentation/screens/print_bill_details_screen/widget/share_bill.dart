import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class ScreenshotUtils {
  ScreenshotUtils._();

  static Future<void> shareBill({
    required ScreenshotController controller,
    String? description,
    String fileName = "bill.png",
  }) async {
    try {
      await WidgetsBinding.instance.endOfFrame;
      final image = await controller.capture(pixelRatio: 3);

      if (image == null) return;

      final directory = await getTemporaryDirectory();

      final file = File("${directory.path}/$fileName");

      await file.writeAsBytes(image);

      // ignore: deprecated_member_use
      await Share.shareXFiles([XFile(file.path)], text: description);
    } catch (e) {
      log(e.toString());
    }
  }
}
