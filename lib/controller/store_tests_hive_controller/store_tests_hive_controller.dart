import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:icon_infoware/controller/store_tests_hive_controller/store_tests_hive_state.dart';
import 'package:icon_infoware/models/spot_billing/test_add_selection.dart';

class StoreTestsHiveController extends StateNotifier<StoreTestsHiveState> {
  StoreTestsHiveController() : super(StoreTestsHiveState());
  void readStoredTestsFromHive() {}

  //read tests from hive
  Future<void> getTestsFromHive() async {
    final box = await Hive.openBox('test_box');

    List<TestMasterSelected> readedTests = box.values.map((item) {
      return TestMasterSelected(
        testKey: item['testKey'],
        testRate: item['testRate'],
        testShortCode: item['testShortCode'],
        testName: item['testName'],
        testSelected: item['testSelected'] ?? false,
      );
    }).toList();
  }

  // Add a test to Hive
  Future<void> addTestToHive({required List<TestMasterSelected> test}) async {
    final box = await Hive.openBox('test_box');

    for (final e in test) {
      await box.add({
        'testKey': e.testKey,
        'testRate': e.testRate,
        'testShortCode': e.testShortCode,
        'testName': e.testName,
        'testSelected': e.testSelected,
      });
    }
    log('saved to hive : $test');
  }

  // Remove a test from Hive
  Future<void> removeTestFromHive({required TestMasterSelected test}) async {
    final box = await Hive.openBox('test_box');

    for (final key in box.keys) {
      final item = box.get(key);

      if (item['testKey'] == test.testKey &&
          item['testName'] == test.testName) {
        await box.delete(key);
        break;
      }
    }
  }

  // Clear all tests from Hive
  Future<void> clearTestHive() async {
    final box = await Hive.openBox('test_box');
    await box.clear();
  }
}

final storeTestsHiveProvider =
    StateNotifierProvider<StoreTestsHiveController, StoreTestsHiveState>((ref) {
      return StoreTestsHiveController();
    });
