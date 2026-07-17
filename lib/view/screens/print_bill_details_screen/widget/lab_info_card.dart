import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icon_infoware/core/constants/app_constants.dart';

import 'package:icon_infoware/core/themes/colors.dart';
import 'package:intl/intl.dart';

class LabInfoCard extends ConsumerWidget {
  final bool isCloser;
  const LabInfoCard({super.key, required this.isCloser});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          if (isCloser == false)
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
            width: 120,
            child: Text(
              title,
              style: TextStyle(
                color: color != null ? Colors.green : AppColors.appBlack,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: AppColors.appBlack,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
