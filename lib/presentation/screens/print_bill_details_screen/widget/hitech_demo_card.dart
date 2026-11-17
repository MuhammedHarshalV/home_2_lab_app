import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icon_infoware/core/constants/app_constants.dart';
import 'package:icon_infoware/core/themes/colors.dart';

class HitechDemoCard extends ConsumerWidget {
  const HitechDemoCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Center(
          child: AppConstants.base64BwImage.isEmpty
              ? const SizedBox.shrink()
              : Image.file(
                  File(AppConstants.base64BwImage),
                  width: MediaQuery.of(context).size.width,
                  // height: 250, // Increase image height
                  fit: BoxFit.fitWidth,
                ),
        ),

        const SizedBox(height: 20),
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
                "CORPORATE LAB",
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

        Text(
          "NEAR INTERNATIONAL STADIUM METRO PILLAR NO:548 PALARIVATTOM,KOCHI-25",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),

        SizedBox(height: 5),

        Text(
          "PHONE: 0484 2 333 888",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            height: 1.4,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 7),

        Text(
          "enquire@hitechcochin.com",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: AppColors.primaryBlue,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 5),

        Text(
          "www.hitechdiagnosticcentre.com",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: AppColors.primaryBlue,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 5),
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
                "Time : 5 am to 10 pm | Open All days",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.appBlack,
                  fontFamily: 'Serif',
                  letterSpacing: 0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
