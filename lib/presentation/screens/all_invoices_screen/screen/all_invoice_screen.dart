import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:icon_infoware/core/themes/colors.dart';
import 'package:icon_infoware/models/patient_bill_syncing_model/patient_bill_syncing_model.dart';

import 'package:icon_infoware/presentation/screens/order_details_screen/widgets/patient_completed_card.dart';
import 'package:icon_infoware/presentation/widgets/common_appbar.dart';

class AllInvoiceScreen extends ConsumerWidget {
  final List<PatientHiveModel> details;

  const AllInvoiceScreen({super.key, required this.details});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        // statusBarColor: AppColors.appWhite,
        statusBarIconBrightness: Brightness.light, // icons = white
        statusBarBrightness: Brightness.dark, // for iOS
      ),
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: AppColors.appWhite,
          appBar: CommonAppbar(),
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
