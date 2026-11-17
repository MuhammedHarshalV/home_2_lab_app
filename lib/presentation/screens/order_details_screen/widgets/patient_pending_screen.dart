import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icon_infoware/controller/payment_controller/payment_controller.dart';
import 'package:icon_infoware/models/patient_bill_syncing_model/patient_bill_syncing_model.dart';

import 'package:icon_infoware/presentation/screens/order_details_screen/widgets/patient_completed_card.dart';



class PatientPendingScreen extends ConsumerWidget {
  final List<PatientHiveModel> details;

  const PatientPendingScreen({
    super.key,
    required this.details,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paymentState = ref.watch(paymentScreenProvider);
    final paymentController = ref.read(paymentScreenProvider.notifier);

    // Initialize when patient count changes
    if (paymentState.isCompleteList.length != details.length) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        paymentController.initializePatientList(details);
      });
    }

    return details.isEmpty
        ? const Center(
            child: Text('No Pending Orders found.'),
          )
        : ListView.separated(
            itemBuilder: (context, index) {
              return PatientCompletedCard(
                isDate: true,
                isPending: true,
                patient: details[index],
                index: details[index].indexClick ?? 0,
                isSelected: index < paymentState.isCompleteList.length
                    ? paymentState.isCompleteList[index]
                    : false,
                onCheckboxChanged: (value) {
                  paymentController.updatePatientSelection(
                    index,
                    details[index],
                    value,
                  );
                },
              );
            },
            separatorBuilder: (context, index) =>
                const SizedBox(height: 10),
            itemCount: details.length,
          );
  }
}