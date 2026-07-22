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
              color: Colors.black,
              colorBlendMode: BlendMode.srcIn,
            ),
          ),

          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(color: AppColors.darkBlue),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  AppConstants.billTitle.isEmpty
                      ? 'LAB TO HOME'
                      : AppConstants.billTitle,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.appWhite,
                    fontFamily: 'Serif',
                    letterSpacing: 0,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            AppConstants.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 5),
          Text(
            AppConstants.address,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              height: 1.4,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            AppConstants.phoneNumber,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              height: 1.4,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Web: ${AppConstants.webUrl}',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.primaryBlue,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
