import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icon_infoware/models/patient_bill_syncing_model/patient_bill_syncing_model.dart';

import 'package:icon_infoware/view/screens/home_screen/widget/patient_details_card.dart';
import 'package:icon_infoware/view/screens/order_details_screen/widgets/patient_completed_card.dart';

class CompletedPatientScreen extends ConsumerWidget {
  final List<PatientHiveModel> details;

  const CompletedPatientScreen({super.key, required this.details});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return PatientCompletedCard(patient: details[index], index: index);
      },
      separatorBuilder: (context, index) => SizedBox(height: 10),
      itemCount: details.length,
    );
  }
}
