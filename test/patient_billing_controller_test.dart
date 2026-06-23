import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icon_infoware/controller/patient_billing/patient_billing_controller.dart';
import 'package:icon_infoware/controller/patient_billing/patient_billing_state.dart';

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
      expect(billingState.doneByController.text, equals('Sumesh'));
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
      // Use exact year calculation to avoid leap-year day offset mismatches
      final birthDate = DateTime(now.year - 30, now.month, now.day);
      
      final age = notifier.calculateAge(birthDate);
      final state = container.read(patientBillingProvider);

      expect(age, equals(30));
      expect(state.ageByYear, equals('Years'));
      expect(state.ageController.text, equals('30'));
    });

    test('calculateAge calculates correct age in months for an infant', () {
      final notifier = container.read(patientBillingProvider.notifier);
      
      final now = DateTime.now();
      // Use exact month calculation to avoid calendar month length offsets
      final birthDate = DateTime(now.year, now.month - 6, now.day);
      
      final age = notifier.calculateAge(birthDate);
      final state = container.read(patientBillingProvider);

      expect(age, equals(6));
      expect(state.ageByYear, equals('Months'));
      expect(state.ageController.text, equals('6'));
    });
  });
}
