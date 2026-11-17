import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icon_infoware/core/constants/app_constants.dart';
import 'package:icon_infoware/core/themes/colors.dart';
import 'package:intl/intl.dart';

class HitechDemoLabInfoCard extends ConsumerWidget {
  final bool isCloser;

  final String name;
  final String refBy;
  final String phone;
  final String email;

  const HitechDemoLabInfoCard({
    super.key,
    required this.isCloser,
    this.name = 'SREELATHA A NAIR 53Y/F',
    this.refBy = 'Dr.GANGADHARAN V P',
    this.phone = '7510201584',
    this.email = 'NIL',
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          //  top: BorderSide(color: AppColors.appBlack, width: 2),
          bottom: BorderSide(color: AppColors.appBlack, width: 2),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Column(
        children: [
          if (!isCloser)
            _buildInfoRow('LAB NO', AppConstants.devCode, isBold: true),

          _buildInfoRow(
            'DATE',
            DateFormat('dd-MMMM-yyyy').format(DateTime.now()),
          ),

          _buildInfoRow('TIME', DateFormat('hh:mma').format(DateTime.now())),

          _buildInfoRow('NAME', name, isBold: true),

          _buildInfoRow('REF.BY', refBy),

          _buildInfoRow('PHONE', phone),

          _buildInfoRow('EMAIL', email),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String title, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              title,
              style: TextStyle(
                color: AppColors.appBlack,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          const SizedBox(
            width: 18,
            child: Text(
              ':',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),

          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: AppColors.appBlack,
                fontSize: 17,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
