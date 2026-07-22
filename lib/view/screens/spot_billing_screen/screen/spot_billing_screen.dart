import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';
import 'package:icon_infoware/controller/add_test_screen_controller/add_test_screen_controller.dart';
import 'package:icon_infoware/controller/bottom_nav_screen/bottom_nav_controller.dart';
import 'package:icon_infoware/controller/color_controller/color_controller.dart';
import 'package:icon_infoware/controller/home_screen_controller/home_screen_controller.dart';
import 'package:icon_infoware/controller/patient_billing/patient_billing_controller.dart';
import 'package:icon_infoware/core/constants/app_constants.dart';
import 'package:icon_infoware/core/routes/app_route_names.dart';
import 'package:icon_infoware/core/themes/colors.dart';

import 'package:icon_infoware/models/patient_bill_syncing_model/patient_bill_syncing_model.dart';

import 'package:icon_infoware/view/screens/spot_billing_screen/widget/search_bar.dart';
import 'package:icon_infoware/view/widgets/common_tap_possition_dropdown.dart';

import 'package:icon_infoware/view/widgets/common_text_field.dart';
import 'package:icon_infoware/view/screens/spot_billing_screen/widget/date_of_birth_container.dart';
import 'package:icon_infoware/view/widgets/spot_billing_popup.dart';
import 'package:icon_infoware/view/widgets/top_texts.dart';

import 'package:icon_infoware/view/widgets/type_text_form_field.dart';
import 'package:intl/intl.dart';

class SpotBillingScreen extends ConsumerWidget {
  SpotBillingScreen({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final testMasterController = ref.read(addTestScreenProvider.notifier);
    final addTestState = ref.watch(addTestScreenProvider);
    final spotBillingState = ref.watch(patientBillingProvider);
    final spotBillingController = ref.read(patientBillingProvider.notifier);
    final bottomNavController = ref.read(bottomNavProvider.notifier);
    final colorState = ref.watch(colorProvider);
    log('initial');
    log(spotBillingState.searchPatientList.length.toString());
    final List<String> patientTitles = [
      "Mr.",
      "Mrs.",
      "Ms.",
      "Miss.",
      "Master.",
      "Baby.",
      "B/O.",
      "Per.",
      "Fr.",
      "Sist.",
      "Smt.",
      "Sri.",
      "C/O Hosp.",
      "Km.",
      "Justice.",
      "Adv.",
      "Rev.fa",
    ];

    return PopScope(
      canPop: false, // Prevents the default back button behavior
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        showDialog(context: context, builder: (context) => SpotBillingPopUp());
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColors.appWhite,
          // elevation: 0, // remove shadow
          // scrolledUnderElevation: 0, //IMPORTANT
          // surfaceTintColor: Colors.transparent,
          toolbarHeight: 100,
          leading: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              onTap: () {
                // showCancelWarningDialog(context);
                showDialog(
                  context: context,
                  builder: (context) => SpotBillingPopUp(),
                );
                // Navigator.pop(context);
              },
              child: CircleAvatar(
                backgroundColor: colorState.primaryColor.withOpacity(0.2),
                child: Icon(Icons.arrow_back, color: colorState.primaryColor),
              ),
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Image.file(
                  width: MediaQuery.of(context).size.width / 1.5,
                  fit: BoxFit.fill,
                  File(AppConstants.base64Image),
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              autovalidateMode: spotBillingState.isSubmitted
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TopText(
                    heading: 'Patient Search',
                    color: colorState.primaryColor,
                  ),
                  SizedBox(height: 8),

                  SearchBarContainer(
                    textController: spotBillingState.patientSearchController,
                  ),

                  SizedBox(height: 16),

                  TopText(
                    heading: 'Patient Details',
                    color: colorState.primaryColor,
                  ),
                  SizedBox(height: 8),
                  TypeTextFormField(
                    hintText:
                        spotBillingState.patientDetailsController.text.isEmpty
                        ? 'Prefix'
                        : spotBillingState.patientDetailsController.text,
                    textController: spotBillingState.patientDetailsController,
                    isSuffix: true,
                    isReadOnly: true,
                    dropDown: patientTitles,
                    onChanged: (p0) {
                      spotBillingState.patientDetailsController.text = p0;
                    },
                  ),
                  // ShowMenu(heading: 'Ms'),
                  // CommonTapPossitionDropdown(
                  //   heading:
                  //       spotBillingState.patientDetailsController.text.isEmpty
                  //       ? 'Prefix'
                  //       : spotBillingState.patientDetailsController.text,
                  //   items: List.generate(
                  //     patientTitles.length,
                  //     (index) => patientTitles[index],
                  //   ),
                  //   onSelected: (value) {
                  //     spotBillingState.patientDetailsController.text = value;
                  //   },
                  // ),
                  SizedBox(height: 8),

                  TopText(
                    heading: 'Patient Name *',
                    color: colorState.primaryColor,
                  ),
                  SizedBox(height: 7),
                  TypeTextFormField(
                    hintText: 'Patient Name',
                    textController: spotBillingState.patientNameController,
                    isPreffix: true,
                  ),

                  // SizedBox(height: 8.h),
                  CommonTextField(
                    label: 'Phone',
                    hint: 'Phone Number',
                    icon: Icons.phone,
                    isNumberInput: true,
                    controller: spotBillingState.patientPhoneController,
                  ),
                  SizedBox(height: 20),

                  //SizedBox(height: 8),
                  CommonTextField(
                    label: 'Email',
                    hint: 'Email',
                    icon: Icons.email,
                    controller: spotBillingState.patientEmailController,
                  ),
                  SizedBox(height: 20),

                  // SizedBox(height: 8.h),
                  DateOfBirthContainer(
                    hintText: 'Date of Birth',
                    textController:
                        spotBillingState.patientDateOfBirthController,
                    ageSetting: () {
                      if (spotBillingState
                          .patientDateOfBirthController
                          .text
                          .isEmpty) {
                        return;
                      }

                      final dob = DateFormat('dd-MM-yyyy').parse(
                        spotBillingState.patientDateOfBirthController.text,
                      );

                      final age = spotBillingController.calculateAge(dob);

                      spotBillingState.ageController.text = age.toString();
                      log(dob.year.toString());
                    },
                  ),
                  SizedBox(height: 8),

                  Row(
                    children: [
                      Expanded(
                        child: TypeTextFormField(
                          hintText: 'Age *',
                          isNumberInput: true,
                          textController: spotBillingState.ageController,
                          //isReadOnly: true,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: CommonTapPossitionDropdown(
                          heading: spotBillingState.ageByYear,
                          items: ['Year', 'Month', 'Week', 'Day'],
                          onSelected: (p0) {
                            spotBillingController.updateState(ageByYear: p0);
                            log(p0);
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),

                  TypeTextFormField(
                    hintText: 'Gender *',
                    textController: spotBillingState.genderController,
                    isSuffix: true,
                    isReadOnly: true,
                    dropDown: ['Men', 'Female', 'Other'],
                    onChanged: (p0) {
                      spotBillingState.genderController.text = p0;
                    },
                  ),
                  SizedBox(height: 8),

                  CommonTextField(
                    label: 'Address',
                    hint: 'Address',
                    icon: Icons.home,
                    controller: spotBillingState.addressController,
                  ),
                  SizedBox(height: 8),
                  TopText(heading: 'Done by *', color: colorState.primaryColor),
                  SizedBox(height: 8),

                  Focus(
                    onFocusChange: (hasFocus) {
                      if (!hasFocus) {
                        spotBillingController.updateState(isDoneByApi: false);
                      }
                    },
                    child: TypeTextFormField(
                      hintText: 'Done by *',
                      textController: spotBillingState.doneByController,
                      onChanged: (value) {
                        spotBillingController.updateState(isDoneByApi: true);
                        if (spotBillingState.isDoneByApi && value.isEmpty) {
                          List<String> newSearchList = [];

                          for (var item
                              in spotBillingState.doneByAccountListApi) {
                            newSearchList.add(item.name ?? '');
                          }
                          spotBillingController.updateState(
                            doneByAccountListSearch: newSearchList,
                          );
                        } else {
                          spotBillingController.doneBySearch(
                            context: null,
                            searchText: value,
                            apiCall: false,
                          );
                        }
                        // spotBillingController.doneBySearch(
                        //   searchText: value,
                        //   context: context,
                        // );
                      },
                    ),
                  ),
                  if ((spotBillingState.doneByAccountListSearch.isNotEmpty ||
                          spotBillingState.isDoneByApi == true) &&
                      spotBillingState.doneByController.text !=
                          (AppConstants.userName.isNotEmpty
                              ? AppConstants.userName[0].toUpperCase() +
                                    AppConstants.userName.substring(1)
                              : ''))
                    Container(
                      height: 70,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 238, 240, 238),
                        border: Border.all(color: AppColors.appGrey, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: spotBillingState.doneByAccountListSearch.isEmpty
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Item not found.',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            )
                          : ListView.separated(
                              padding: const EdgeInsets.all(8),
                              itemCount: spotBillingState
                                  .doneByAccountListSearch
                                  .length,
                              itemBuilder: (context, index) {
                                final accountList = spotBillingState
                                    .doneByAccountListSearch[index];

                                return InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  onTap: () {
                                    spotBillingState.doneByController.text =
                                        accountList;

                                    spotBillingController.updateState(
                                      doneByAccountListSearch: [],
                                      isDoneByApi: false,
                                    );
                                  },
                                  child: Text(
                                    accountList,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 10),
                            ),
                    ),
                  SizedBox(height: 18),

                  CommonTapPossitionDropdown(
                    heading: spotBillingState.referredByController.text.isEmpty
                        ? 'Referred by'
                        : spotBillingState.referredByController.text,
                    items: ['Manager', 'HR', 'Team Lead', 'Senior Developer'],
                    onSelected: (value) {
                      spotBillingState.referredByController.text = value;
                      spotBillingController.updateState();
                    },
                  ),
                  SizedBox(height: 18),

                  CommonTapPossitionDropdown(
                    heading: spotBillingState.assignedByController.text.isEmpty
                        ? 'Assigned to.'
                        : spotBillingState.assignedByController.text,
                    items: ['Icon Infoware', 'Dummy'],
                    onSelected: (value) {
                      spotBillingState.assignedByController.text = value;
                      spotBillingController.updateState();
                    },
                  ),
                  SizedBox(height: 18),

                  Row(
                    children: [
                      // Container(
                      //   height: 20,
                      //   width: 20,
                      //   decoration: BoxDecoration(color:colorState.primaryColorLight),
                      //   child: Center(child: Icon(Icons.che),),
                      // ),
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        onTap: () {
                          spotBillingController.updateState(
                            isAdditional: !spotBillingState.isAdditional,
                          );
                        },
                        child: Icon(
                          spotBillingState.isAdditional
                              ? Icons.check_box_outlined
                              : Icons.check_box_outline_blank,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text('Add additional info.'),
                    ],
                  ),
                  SizedBox(height: 8),
                  if (spotBillingState.isAdditional == true)
                    ListView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        CommonTextField(
                          hint: 'ABHA ID',
                          icon: Icons.insert_drive_file_outlined,
                          controller: spotBillingState.abhaIdController,
                        ),
                        CommonTextField(
                          hint: 'Passport Number',
                          icon: Icons.password_sharp,
                          controller: spotBillingState.passPortNumberController,
                        ),
                        CommonTextField(
                          hint: 'Out Doctor',
                          icon: Icons.person_add_alt_outlined,
                          controller: spotBillingState.outDoctorController,
                        ),
                        CommonTextField(
                          hint: 'Note',
                          icon: Icons.note_alt_outlined,
                          controller: spotBillingState.noteController,
                        ),
                      ],
                    ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        onTap: () {
                          spotBillingController.updateState(
                            isUrgent: !spotBillingState.isUrgent,
                          );
                          log(spotBillingState.isUrgent.toString());
                        },
                        child: Icon(
                          spotBillingState.isUrgent == true
                              ? Icons.check_box_outlined
                              : Icons.check_box_outline_blank,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text('Urgent Report.'),
                    ],
                  ),
                  SizedBox(height: 18),

                  // PROCEED BUTTON
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    onTap: () async {
                      spotBillingController.updateState(isSubmitted: true);
                      if (formKey.currentState!.validate()) {
                        // testMasterController.testMasterCalling();
                        // testMasterController.specialRatesFetch();
                        testMasterController.getSpecialSchemeList();
                        context.pushReplacementNamed(
                          AppRouteNames.spotBillingTestAddScreen.name,
                        );
                        testMasterController.getTestMasterLists(
                          null,
                          false,
                          null,
                        );
                        String currentDate = DateFormat(
                          'yyyy-MM-dd',
                        ).format(DateTime.now());
                        final patient = PatientHiveModel(
                          patGender: spotBillingState.genderController.text,
                          patAge: int.parse(
                            spotBillingState.ageController.text,
                          ),
                          patAgehead: spotBillingState.ageByYear,
                          patAddress: spotBillingState.addressController.text,

                          currentDatetime: currentDate,
                          bookTime: null,
                          invNo: '',
                          patPhno: spotBillingState.patientPhoneController.text,

                          patEmail:
                              spotBillingState.patientEmailController.text,
                          bookMapUrl: null,

                          flag: "0",
                          remarks: null,
                          smplMode: 'Random',
                          isCompleted: 'No',
                          isSync: 'No',
                          patId: 0,
                          patName: spotBillingState.patientNameController.text,
                          patMobno: '',
                          urgent: spotBillingState.isUrgent == false ? 0 : 1,
                          abhaId: spotBillingState.abhaIdController.text,
                          note: spotBillingState.noteController.text,
                          outDr: spotBillingState.outDoctorController.text,
                          passport:
                              spotBillingState.passPortNumberController.text,
                          discAmt: num.tryParse(
                            addTestState.discountAmountController.text,
                          ),
                          servChrge: num.tryParse(
                            addTestState.servicesnargeController.text,
                          ),
                        );
                        ref.read(addTestScreenProvider.notifier).clearState();
                        await ref
                            .read(homeScreenProvider.notifier)
                            .savePatient(patient);
                        log(patient.toMap().toString());
                        bottomNavController.setIndex(0);
                        log(patient.discAmt.toString());
                        log(patient.servChrge.toString());
                      } else {
                        log("Show errors ");
                      }
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: colorState.primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'Proceed',
                          style: TextStyle(
                            color: AppColors.appWhite,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 70),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
