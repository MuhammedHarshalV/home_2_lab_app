//

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:icon_infoware/controller/add_test_screen_controller/add_test_screen_controller.dart';
import 'package:icon_infoware/controller/patient_billing/patient_billing_controller.dart';

import 'package:icon_infoware/core/routes/app_route_names.dart';
import 'package:icon_infoware/core/themes/colors.dart';

import 'package:icon_infoware/models/patient_bill_syncing_model/patient_bill_syncing_model.dart';
import 'package:intl/intl.dart';

class PatientCompletedCard extends ConsumerWidget {
  final PatientHiveModel patient;

  final int index;
  final bool isDate;
  const PatientCompletedCard({
    super.key,
    required this.patient,
    required this.index,
    this.isDate = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patientBillingDetailsState = ref.watch(patientBillingProvider);
    final patientBillingController = ref.read(patientBillingProvider.notifier);
   
    final testAddController = ref.read(addTestScreenProvider.notifier);
    final testAddState = ref.watch(addTestScreenProvider);

    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      onTap: () {
        patientBillingDetailsState.patientDetailsController.text =
            patient.namePrefix ?? '';
        patientBillingDetailsState.patientNameController.text =
            patient.patName ?? '';
        patientBillingDetailsState.patientPhoneController.text =
            patient.patPhno ?? '';
        patientBillingDetailsState.patientEmailController.text =
            patient.patEmail ?? '';
        patientBillingDetailsState.patientDateOfBirthController.text = '';
        patientBillingDetailsState.ageController.text = patient.patAge
            .toString();
        patientBillingDetailsState.abhaIdController.text = '';
        patientBillingDetailsState.noteController.text = '';
        patientBillingDetailsState.genderController.text =
            patient.patGender ?? '';
        patientBillingDetailsState.addressController.text =
            patient.patAddress ?? '';
        patientBillingDetailsState.referredByController.text = '';
        patientBillingDetailsState.assignedByController.text = '';

        patientBillingController.updateState(
          ageByYear: patient.patAgehead ?? '',
          isUrgent: false,
        );

        testAddState.discountAmountController.text = patient.discAmt.toString();
        testAddState.discountPercentageController.text =
            ((patient.discAmt! / patient.grossAmt!) * 100).toString();
        testAddState.servicesnargeController.text = patient.servChrge
            .toString();
        testAddState.upiRefferenceIdController.text =
            patient.upiReferenceId ?? ''.toString();
        testAddController.updatestate(
          isSync: patient.isSync ?? 'No',
          balanceAmount: patient.balance ?? 0,
          amountPaid: patient.paidAmt ?? 0,
          netAmount: patient.netAmt ?? 0,
          grosAmount: patient.grossAmt ?? 0,
          primaryPaid: patient.primaryPaid ?? 0,
          secondaryPaid: patient.secondaryPaid ?? 0,
          secondaryType: patient.secondaryType ?? '',
          primaryType: patient.primaryType ?? '',
        );

        patientBillingController.updateState(
          ageByYear: patient.patAgehead ?? '',
          isUrgent: false,
        );
        if (testAddState.testMasterListSelectedNewPrice.isNotEmpty) {
          testAddState.testMasterListSelectedNewPrice.clear();
        }
        log(patient.toMap().toString());
        testAddController.getTestMasterLists(patient);
        context.pushNamed(
          AppRouteNames.spotBillingTestAddScreen.name,
          extra: {'index': index},
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.appWhite,
          border: Border(
            left: BorderSide(color: AppColors.appYellow, width: 6),
            top: BorderSide(color: AppColors.appYellow, width: 1),
            bottom: BorderSide(color: AppColors.appYellow, width: 1),
            right: BorderSide(color: AppColors.appYellow, width: 1),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        // margin: const EdgeInsets.all(20),
        // height: 140, // Adjust based on your content
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      patient.patName ?? '',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color:
                          (patient.bookMapUrl?.trim().isEmpty ?? false) ||
                              patient.bookMapUrl == null
                          ? const Color.fromARGB(255, 169, 216, 255)
                          : Colors.blue,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Icon(
                        Icons.phone_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  // SizedBox(width: 60),
                ],
              ),
              Text(
                "(${patient.patGender.toString()} ${patient.patAge})",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              if (patient.bookTime?.trim().isNotEmpty ?? false)
                Text(
                  'Visit time : ${patient.bookTime ?? ''}',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 129, 128, 128),
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              // const Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                      patient.patAddress ?? '',
                      style: TextStyle(
                        color: AppColors.appBlack,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: patient.smplMode! == 'Home'
                          ? Colors.green
                          : patient.smplMode! == 'Random'
                          ? Colors.blue
                          : Colors.red,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      patient.smplMode ?? '',
                      style: TextStyle(
                        color: AppColors.appWhite,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  //  const SizedBox(width: 60), // Space for the floating button
                ],
              ),
              if (patient.balance != 0)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(.7),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Balance :${patient.balance}',
                        style: TextStyle(
                          color: AppColors.appWhite,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              //  Spacer(),
              if (isDate == true &&
                  patient.timeToSave != null &&
                  patient.timeToSave!.trim().isNotEmpty)
                Text(
                  patient.timeToSave ?? '',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              if (isDate == true &&
                  patient.dateToSave != null &&
                  patient.dateToSave!.trim().isNotEmpty)
                Text(
                  DateFormat(
                    'dd-MMM-yyyy',
                  ).format(DateTime.parse(patient.dateToSave ?? '')),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
