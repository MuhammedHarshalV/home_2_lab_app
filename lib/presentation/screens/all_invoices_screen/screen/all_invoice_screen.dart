import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icon_infoware/controller/color_controller/color_controller.dart';
import 'package:icon_infoware/core/constants/app_constants.dart';
import 'package:icon_infoware/core/themes/colors.dart';
import 'package:icon_infoware/models/patient_bill_syncing_model/patient_bill_syncing_model.dart';

import 'package:icon_infoware/presentation/screens/order_details_screen/widgets/patient_completed_card.dart';

class AllInvoiceScreen extends ConsumerWidget {
  final List<PatientHiveModel> details;

  const AllInvoiceScreen({super.key, required this.details});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorState = ref.watch(colorProvider);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: AppColors.appWhite,
        statusBarIconBrightness: Brightness.light, // icons = white
        statusBarBrightness: Brightness.dark, // for iOS
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.appWhite,
          appBar: AppBar(
            toolbarHeight: 100,
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.appWhite,
            elevation: 0,

            leading: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () => Navigator.pop(context),
                child: CircleAvatar(
                  backgroundColor: colorState.primaryColor.withValues(
                    alpha: 0.2,
                  ),
                  child: Icon(Icons.arrow_back, color: colorState.primaryColor),
                ),
              ),
            ),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: AppConstants.base64Image.isEmpty
                      ? null
                      : Image.file(
                          width: MediaQuery.of(context).size.width / 1.5,
                          fit: BoxFit.fill,
                          File(AppConstants.base64Image),
                        ),
                ),
              ],
            ),
          ),
          body: details.isEmpty
              ? Center(child: Text('No invoices available.'))
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return PatientCompletedCard(
                        patient: details[index],
                        index: details[index].indexClick ?? 0,
                        isInvoice: true,
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 10),
                    itemCount: details.length,
                  ),
                ),
        ),
      ),
    );
  }
}
