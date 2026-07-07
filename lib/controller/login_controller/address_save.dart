import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';

class AddressStorage {
  static const String boxName = 'addressBox';

  static Future<void> saveAddress({
    required String name,
    required String address,
    required String webUrl,
    required String phoneNumber,
    required String devCode,
    required String tagLine,
    required String qrUrl,
  }) async {
    final box = await Hive.openBox(boxName);

    await box.put('name', name);
    await box.put('address', address);
    await box.put('webUrl', webUrl);
    await box.put('phoneNumber', phoneNumber);
    await box.put('devCode', devCode);
    await box.put('tagLine', tagLine);
    await box.put('qrUrl', qrUrl);
    log(box.toMap().entries.map((e) => '${e.key}: ${e.value}').join('\n'));
  }
}
