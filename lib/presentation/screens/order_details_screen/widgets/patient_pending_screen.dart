import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icon_infoware/models/patient_bill_syncing_model/patient_bill_syncing_model.dart';

import 'package:icon_infoware/presentation/screens/order_details_screen/widgets/patient_completed_card.dart';

class PatientPendingScreen extends ConsumerWidget {
  final List<PatientHiveModel> details;

  const PatientPendingScreen({super.key, required this.details});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return details.isEmpty
        ? Center(child: Text('No Pending Orders found.'))
        : ListView.separated(
            itemBuilder: (context, index) {
              return PatientCompletedCard(
                isDate: true,
                patient: details[index],
                index: details[index].indexClick ?? 0,
              );
            },
            separatorBuilder: (context, index) => SizedBox(height: 10),
            itemCount: details.length,
          );
  }
}
