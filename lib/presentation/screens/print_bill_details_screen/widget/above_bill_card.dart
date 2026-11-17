import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icon_infoware/core/constants/app_constants.dart';
import 'package:icon_infoware/core/themes/colors.dart';

class AboveBillCard extends ConsumerWidget {
  const AboveBillCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Center(
          child: AppConstants.base64BwImage.isEmpty
              ? null
              : Image.file(
                  File(AppConstants.base64BwImage),
                  width: MediaQuery.of(context).size.width / 1.5,

                  fit: BoxFit.fill,
                  // color: Colors.black,
                  // colorBlendMode: BlendMode.srcIn,
                ),
        ),

        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: AppColors.appBlack, width: 2),
              bottom: BorderSide(color: AppColors.appBlack, width: 2),
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                AppConstants.billTitle.isEmpty
                    ? 'LAB TO HOME'
                    : AppConstants.billTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.appBlack,
                  fontFamily: 'Serif',
                  letterSpacing: 0,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        if (AppConstants.name.isNotEmpty)
          Text(
            AppConstants.name,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        if (AppConstants.address.isNotEmpty) SizedBox(height: 5),
        if (AppConstants.address.isNotEmpty)
          Text(
            AppConstants.address,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              height: 1.4,
              fontWeight: FontWeight.w500,
            ),
          ),
        if (AppConstants.phoneNumber.isNotEmpty) SizedBox(height: 5),
        if (AppConstants.phoneNumber.isNotEmpty)
          Text(
            AppConstants.phoneNumber,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              height: 1.4,
              fontWeight: FontWeight.w500,
            ),
          ),
        if (AppConstants.webUrl.isNotEmpty) SizedBox(height: 5),
        if (AppConstants.webUrl.isNotEmpty)
          Text(
            AppConstants.webUrl,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.primaryBlue,
              fontWeight: FontWeight.w500,
            ),
          ),
      ],
    );
  }
}
