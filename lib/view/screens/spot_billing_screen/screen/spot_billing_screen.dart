import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icon_infoware/controller/bottom_nav_screen/bottom_nav_controller.dart';
import 'package:icon_infoware/controller/patient_billing/patient_billing_controller.dart';
import 'package:icon_infoware/core/api_constants/base64_image.dart';
import 'package:icon_infoware/core/themes/colors.dart';

import 'package:icon_infoware/view/screens/spot_billing_screen/widget/search_bar.dart';
import 'package:icon_infoware/view/widgets/common_text_field.dart';
import 'package:icon_infoware/view/widgets/date_of_birth_container.dart';
import 'package:icon_infoware/view/widgets/spot_billing_popup.dart';
import 'package:icon_infoware/view/widgets/top_texts.dart';

import 'package:icon_infoware/view/widgets/type_text_form_field.dart';
import 'package:intl/intl.dart';


class SpotBillingScreen extends ConsumerStatefulWidget {
  const SpotBillingScreen({super.key});

  @override
  ConsumerState<SpotBillingScreen> createState() => _SpotBillingScreenState();
}

class _SpotBillingScreenState extends ConsumerState<SpotBillingScreen> {
  // final _formKey = GlobalKey<FormState>();
  // final TextEditingController namecontroller = TextEditingController();
  // final TextEditingController agecontroller = TextEditingController();
  // final TextEditingController gendercontroller = TextEditingController();
  // final TextEditingController doneBycontroller = TextEditingController();
  // final TextEditingController freecontroller = TextEditingController();
  // final TextEditingController patientSearchcontroller = TextEditingController();
  // final TextEditingController patientNameController = TextEditingController();

  // //final TextEditingController freecontroller = TextEditingController();

  // final TextEditingController dateOfBirthcontroller = TextEditingController();

  // @override
  // void dispose() {
  //   namecontroller.dispose();
  //   agecontroller.dispose();
  //   gendercontroller.dispose();
  //   doneBycontroller.dispose();
  //   freecontroller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final spotBillingState = ref.watch(patientBillingProvider);
    final spotBillingController = ref.read(patientBillingProvider.notifier);
    final bottomNavController = ref.read(bottomNavProvider.notifier);
    log('initial');
    //log(spotBillingState.searchPatientList[0].toString());

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
                backgroundColor: AppColors.appPrimaryColor.withOpacity(0.2),
                child: Icon(Icons.arrow_back, color: AppColors.appPrimaryColor),
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
                  File(Base64Image.base64Image),
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: spotBillingState.formKey,
              autovalidateMode: spotBillingState.isSubmitted
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TopText(heading: 'Patient Search'),
                  SizedBox(height: 8),

                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: TypeContainer(
                  //         hintText: 'Search Patients',
                  //         textController: patientSearchcontroller,
                  //       ),
                  //     ),
                  //     SizedBox(width: 8),
                  //     Container(
                  //       decoration: BoxDecoration(
                  //         color: AppColors.appPrimaryColor,
                  //         borderRadius: BorderRadius.circular(10),
                  //       ),
                  //       padding: EdgeInsets.all(16),
                  //       child: Icon(Icons.search, color: AppColors.appWhite),
                  //     ),
                  //   ],
                  // ),
                  // TypeContainer(
                  //   items: List.generate(
                  //     spotBillingState.searchPatientList.length,
                  //     (index) =>
                  //         spotBillingState.searchPatientList[index].patName ??
                  //         '',
                  //   ),
                  //   hintText: 'Search Patients',
                  //   textController: patientSearchcontroller,
                  //   onSearchTap: () async {
                  //     log("Search clicked: ${patientSearchcontroller.text}");
                  //     if (patientSearchcontroller.text.length > 1) {
                  //       await spotBillingController.searchPatient(
                  //         context: context,
                  //         body: patientSearchcontroller.text,
                  //       );
                  //     }
                  //   },
                  // ),
                  SearchBarContainer(
                    textController: spotBillingState.patientSearchController,
                  ),

                  // SizedBox(height: 3),
                  // Container(
                  //   height: 400,
                  //   width: double.infinity,
                  //   decoration: BoxDecoration(
                  //     color: const Color.fromARGB(255, 238, 240, 238),
                  //     border: Border.all(color: AppColors.appGrey, width: 2),
                  //     borderRadius: BorderRadius.circular(10),
                  //   ),
                  //   child: SingleChildScrollView(
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         spacing: 2,
                  //         children: List.generate(
                  //           spotBillingState.searchPatientList.length,
                  //           (index) => Text(
                  //             spotBillingState
                  //                     .searchPatientList[index]
                  //                     .patName ??
                  //                 '',
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: 16),

                  TopText(heading: 'Patient Details'),
                  SizedBox(height: 8),
                  // ShowMenu(heading: 'Ms'),
                  ShowMenu(
                    heading:
                        spotBillingState.patientDetailsController.text.isEmpty
                        ? 'Patient Details'
                        : spotBillingState.patientDetailsController.text,
                    items: List.generate(
                      spotBillingState.searchPatientList.length,
                      (index) =>
                          spotBillingState.searchPatientList[index].patName ??
                          '',
                    ),
                    onSelected: (value) {
                      spotBillingController.updateState(
                        patientDetailsController: TextEditingController(
                          text: value,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 8),

                  TopText(heading: 'Patient Name *'),
                  SizedBox(height: 7),
                  TypeTextFormField(
                    hintText: 'Patient Name',
                    textController: spotBillingState.patientNameController,
                    isPreffix: true,
                  ),

                  // SizedBox(height: 8),
                  CommonTextField(
                    label: 'Phone',
                    hint: 'Phone Number',
                    icon: Icons.phone,
                  ),

                  //SizedBox(height: 8),
                  CommonTextField(
                    label: 'Email',
                    hint: 'Email',
                    icon: Icons.email,
                  ),

                  // SizedBox(height: 8),
                  DateOfBirthContainer(
                    hintText: 'Date of Birth',
                    textController: spotBillingState.patientDateOfBirthController,
                    ageSetting: () {
                      if (spotBillingState.patientDateOfBirthController.text.isEmpty) return;

                      final dob = DateFormat(
                        'dd-MM-yyyy',
                      ).parse(spotBillingState.patientDateOfBirthController.text);

                      final age = spotBillingController.calculateAge(dob);

               spotBillingController.updateState(age: age.toString())  ;    
                      log(dob.year.toString());

                      log(spotBillingState.age);
                    },
                  ),
                  SizedBox(height: 8),

                  Row(
                    children: [
                      Expanded(
                        child: TypeTextFormField(
                          hintText: 'Age *',
                          textController: spotBillingState.ageController,
                          isReadOnly: true,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ShowMenu(
                          heading: 'Years',
                          items: ['Year', 'Month', 'Week', 'Day'],
                          onSelected: (p0) {},
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
                    onChanged: (p0) {
                      spotBillingController.updateState(genderController: TextEditingController(text: p0));
                    },
                  ),
                  SizedBox(height: 8),

                  CommonTextField(
                    label: 'Address',
                    hint: 'Address',
                    icon: Icons.home,
                  ),
                  SizedBox(height: 8),

                  TypeTextFormField(
                    hintText: 'Done by *',
                    textController: spotBillingState.doneByController,
                  ),
                  SizedBox(height: 18),

                  ShowMenu(
                    heading: spotBillingState.assignedByController.text.isEmpty
                        ? 'Referred by'
                        : spotBillingState.assignedByController.text,
                    items: ['Manager', 'HR', 'Team Lead', 'Senior Developer'],
                    onSelected: (value) {
                      spotBillingController.updateState(assignedByController: TextEditingController(text: value));
                    },
                  ),
                  SizedBox(height: 18),

                  ShowMenu(
                    heading: spotBillingState.assignedByController.text.isEmpty
                        ? 'Assigned to.'
                        : spotBillingState.assignedByController.text,
                    items: ['Manager', 'HR', 'Team Lead', 'Senior Developer'],
                    onSelected: (value) {
                      spotBillingController.updateState(assignedByController: TextEditingController(text: value));
                    },
                  ),
                  SizedBox(height: 18),

                  Row(
                    children: [
                      // Container(
                      //   height: 20,
                      //   width: 20,
                      //   decoration: BoxDecoration(color: AppColors.appPrimaryColorLight),
                      //   child: Center(child: Icon(Icons.che),),
                      // ),
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        onTap: () {
                          spotBillingController.updateState(
                       isAdditional     :!spotBillingState.isAdditional,
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
                        ),
                        CommonTextField(
                          hint: 'Passport Number',
                          icon: Icons.password_sharp,
                        ),
                        CommonTextField(
                          hint: 'Out Doctor',
                          icon: Icons.person_add_alt_outlined,
                        ),
                        CommonTextField(
                          hint: 'Note',
                          icon: Icons.note_alt_outlined,
                        ),
                      ],
                    ),

                  Row(
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        onTap: () {
                          spotBillingController.updateState(isUrgent:
                            !spotBillingState.isUrgent,
                          );
                        },
                        child: Icon(
                          spotBillingState.isUrgent
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
                    onTap: () {
                      spotBillingController.updateState(isSubmitted: true);
                      if (spotBillingState. formKey.currentState!.validate()) {
                        // Only update state when form is valid
                      
                        log("Success ");
                        bottomNavController.setIndex(0);
                      } else {
                        log("Show errors ");
                      }
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.appPrimaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'Proceed',
                          style: TextStyle(color: AppColors.appWhite),
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

  void _showMore(BuildContext context, Offset tapPosition, List items) async {
    final screenSize = MediaQuery.of(context).size;

    final selected = await showMenu<String>(
      context: context,
      color: AppColors.appWhite,
      constraints: BoxConstraints(
        minWidth: screenSize.width,
        maxHeight: screenSize.height / 2,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      position: RelativeRect.fromLTRB(
        0, // full width
        tapPosition.dy,
        0,
        screenSize.height - tapPosition.dy,
      ),
      items: items
          .map(
            (item) => PopupMenuItem<String>(
              value: item,
              child: Align(alignment: Alignment.centerLeft, child: Text(item)),
            ),
          )
          .toList(),
    );

    // if (selected != null) {
    //   onSelected(selected); // callback
    // }
  }
}

class ShowMenu extends StatelessWidget {
  final String heading;
  final List<String> items;
  final Function(String) onSelected;

  const ShowMenu({
    super.key,
    required this.heading,
    required this.items,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      onTapDown: (details) {
        _showMore(context, details.globalPosition);
      },
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.appPrimaryColorLight,
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(heading, style: TextStyle(color: AppColors.appBlack)),
            ),
            const Spacer(),
            Icon(Icons.arrow_drop_down, color: AppColors.appBlack),
          ],
        ),
      ),
    );
  }

  void _showMore(BuildContext context, Offset tapPosition) async {
    final screenSize = MediaQuery.of(context).size;

    final selected = await showMenu<String>(
      context: context,
      color: AppColors.appWhite,
      constraints: BoxConstraints(
        minWidth: screenSize.width,
        maxHeight: screenSize.height / 2,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      position: RelativeRect.fromLTRB(
        0, // full width
        tapPosition.dy,
        0,
        screenSize.height - tapPosition.dy,
      ),
      items: items
          .map(
            (item) => PopupMenuItem<String>(
              value: item,
              child: Align(alignment: Alignment.centerLeft, child: Text(item)),
            ),
          )
          .toList(),
    );

    if (selected != null) {
      onSelected(selected); // callback
    }
  }
}
