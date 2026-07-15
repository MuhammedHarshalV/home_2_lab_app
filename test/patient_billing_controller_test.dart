import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icon_infoware/controller/patient_billing/patient_billing_controller.dart';
import 'package:icon_infoware/core/constants/app_constants.dart';

void main() {
  group('PatientBillingController Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('Initial State is initialized correctly', () {
      final billingState = container.read(patientBillingProvider);

      expect(billingState.ageByYear, equals('Years'));
      expect(billingState.isSubmitted, isFalse);
      expect(billingState.isAdditional, isFalse);
      expect(billingState.isUrgent, isFalse);
      expect(
        billingState.doneByController.text,
        equals(
          AppConstants.userName.isNotEmpty
              ? AppConstants.userName[0].toUpperCase() +
                    AppConstants.userName.substring(1)
              : '',
        ),
      );
    });

    test('updateState correctly changes specific fields', () {
      final notifier = container.read(patientBillingProvider.notifier);

      notifier.updateState(
        ageByYear: 'Months',
        isSubmitted: true,
        isUrgent: true,
      );

      final state = container.read(patientBillingProvider);
      expect(state.ageByYear, equals('Months'));
      expect(state.isSubmitted, isTrue);
      expect(state.isUrgent, isTrue);
    });

    test('calculateAge calculates correct age in years for adult', () {
      final notifier = container.read(patientBillingProvider.notifier);

      final now = DateTime.now();
      // Clamp day to 28 to avoid leap-year day offset roll-overs on non-leap years
      final safeDay = now.day > 28 ? 28 : now.day;
      final birthDate = DateTime(now.year - 30, now.month, safeDay);

      final age = notifier.calculateAge(birthDate);
      final state = container.read(patientBillingProvider);

      expect(age, equals(30));
      expect(state.ageByYear, equals('Years'));
      expect(state.ageController.text, equals('30'));
    });

    test('calculateAge calculates correct age in months for an infant', () {
      final notifier = container.read(patientBillingProvider.notifier);

      final now = DateTime.now();
      // Clamp day to 28 to avoid calendar month length roll-overs (e.g. running on the 31st)
      final safeDay = now.day > 28 ? 28 : now.day;
      final birthDate = DateTime(now.year, now.month - 6, safeDay);

      final age = notifier.calculateAge(birthDate);
      final state = container.read(patientBillingProvider);

      expect(age, equals(6));
      expect(state.ageByYear, equals('Months'));
      expect(state.ageController.text, equals('6'));
    });
  });
}
