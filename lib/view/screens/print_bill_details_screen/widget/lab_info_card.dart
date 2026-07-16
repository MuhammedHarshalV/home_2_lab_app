import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:icon_infoware/core/themes/colors.dart';
import 'package:intl/intl.dart';

class LabInfoCard extends ConsumerWidget {
  const LabInfoCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        children: [
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
