import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:icon_infoware/controller/patient_billing/patient_billing_controller.dart';
import 'package:icon_infoware/core/constants/app_constance.dart';
import 'package:icon_infoware/core/themes/colors.dart';
import 'package:intl/intl.dart';

class LabInfoCard extends ConsumerWidget {
  const LabInfoCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final spotbillingState = ref.watch(patientBillingProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        children: [
          _buildInfoRow('LAB NO', ': ${AppConstants.devCode}', null),
          _buildInfoRow(
            'DATE',
            ': ${DateFormat('MMM d, yyyy').format(DateTime.now())}',
            null,
          ),
          _buildInfoRow(
            'TIME',
            ': ${DateFormat('hh:mm a').format(DateTime.now())}',
            null,
          ),
          Divider(color: Colors.grey.shade400, thickness: 1.5, height: 20),
          _buildInfoRow(
            'NAME',
            ': ${spotbillingState.patientNameController.text}',
            Colors.green,
          ),
          _buildInfoRow(
            'AGE/SEX',
            ': ${spotbillingState.ageController.text} Years/${spotbillingState.genderController.text}',
            Colors.green,
          ),
          _buildInfoRow(
            'PHONE',
            ': ${spotbillingState.patientPhoneController.text}',
            Colors.green,
          ),
          _buildInfoRow(
            'EMAIL',
            ': ${spotbillingState.patientEmailController.text}',
            Colors.green,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String title, String value, Color? color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              title,
              style: TextStyle(
                color: color != null ? Colors.green : AppColors.appBlack,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: AppColors.appBlack, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
