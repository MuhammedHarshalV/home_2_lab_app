import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icon_infoware/core/constants/app_constants.dart';
import 'package:icon_infoware/core/themes/colors.dart';

class AboveBillCard extends ConsumerWidget {
  const AboveBillCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Center(
            child: Image.file(
              File(AppConstants.base64Image),
              width: MediaQuery.of(context).size.width / 1.5,

              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'LAB TO HOME',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryBlue,
              fontFamily: 'Serif',
              letterSpacing: 0,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            AppConstants.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 5),
          Text(
            AppConstants.address,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              height: 1.4,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            AppConstants.phoneNumber,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              height: 1.4,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Web: ${AppConstants.webUrl}',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.primaryBlue,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
