import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icon_infoware/controller/add_test_screen_controller/add_test_screen_controller.dart';
import 'package:icon_infoware/controller/color_controller/color_controller.dart';
import 'package:icon_infoware/controller/patient_billing/patient_billing_controller.dart';
import 'package:icon_infoware/core/themes/colors.dart';

class SearchBarContainer extends ConsumerWidget {
  final TextEditingController textController;

  const SearchBarContainer({super.key, required this.textController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final spotBillingState = ref.watch(patientBillingProvider);
    final colorState = ref.watch(colorProvider);

    final spotBillingController = ref.read(patientBillingProvider.notifier);
    final addTestScreenState = ref.watch(addTestScreenProvider);

    return Container(
      width: double.infinity,

      padding: EdgeInsets.only(left: 5),
      decoration: BoxDecoration(
        color: colorState.secondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              /// TEXTFIELD
              Expanded(
                child: TextField(
                  // onTapOutside: (_) {
                  //   FocusManager.instance.primaryFocus?.unfocus();
                  // },
                  controller: textController,
                  keyboardType: TextInputType.text,
                  onChanged: (value) async {
                    if (value.length < 2) {
                      spotBillingController.updateState(searchPatientList: []);
                      if (value.isEmpty) {
                        spotBillingController.updateState(isTextClear: false);
                      }
                    } else if (value.length > 1) {
                      spotBillingController.updateState(isTextClear: true);
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: "Search Patients",
                    border: InputBorder.none,
                  ),
                ),
              ),

              if (spotBillingState.isTextClear == true)
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  onTap: () {
                    spotBillingState.patientSearchController.clear();
                    spotBillingController.updateState(
                      isTextClear: false,

                      // patientSearchController: TextEditingController(text: ''),
                      searchPatientList: [],
                    );
                  },
                  child: Icon(Icons.close),
                ),
              SizedBox(width: 5),

              /// SEARCH BUTTON
              GestureDetector(
                onTap: () async {
                  spotBillingController.updateState(searchPatientList: []);
                  if (textController.text.length > 2) {
                    await spotBillingController.searchPatient(
                      context: context,
                      body: textController.text.toString(),
                    );
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  // height: 50,
                  // width: 50,
                  decoration: BoxDecoration(
                    color: colorState.primaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: spotBillingState.isLoading == true
                      ? Center(
                          child: SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                              color: AppColors.appWhite,
                            ),
                          ),
                        )
                      : Icon(Icons.search, color: AppColors.appWhite),
                ),
              ),
            ],
          ),
          if (spotBillingState.searchPatientList.isNotEmpty)
            SizedBox(height: 10),
          // if (spotBillingState.searchPatientList.isEmpty &&
          //     // spotBillingState.isLoading == false &&
          //     spotBillingState.patientSearchController.text.isNotEmpty)
          //   SizedBox(height: 30, child: Center(child: Text('No data found.'))),

          /// SEARCH LIST
          if (spotBillingState.searchPatientList.isNotEmpty)
            Container(
              height: 400,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 238, 240, 238),
                border: Border.all(color: AppColors.appGrey, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: spotBillingState.isLoading == true
                  ? SizedBox(
                      height: 30,
                      child: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: .5,
                          color: AppColors.appBlack,
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: spotBillingState.searchPatientList.length,
                      itemBuilder: (context, index) {
                        final patient =
                            spotBillingState.searchPatientList[index];

                        return InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          onTap: () {
                            spotBillingState.patientSearchController.text =
                                patient.patName ?? '';
                            spotBillingState.patientNameController.text =
                                patient.patName ?? '';
                            spotBillingState.patientDetailsController.text =
                                patient.namePrefix ?? '';
                            spotBillingState.patientPhoneController.text =
                                patient.patPhno ?? '';
                            spotBillingState.patientEmailController.text =
                                patient.patEmail ?? '';
                            spotBillingState.ageController.text =
                                patient.patAge != null
                                ? patient.patAge.toString()
                                : '';
                            if (patient.discAmt != null) {
                              addTestScreenState.discountAmountController.text =
                                  patient.discAmt.toString();
                            }
                            if (patient.scharge != null) {
                              addTestScreenState.servicesnargeController.text =
                                  patient.scharge.toString();
                            }

                            spotBillingState.genderController.text =
                                patient.patGender ?? '';
                            spotBillingState.addressController.text =
                                patient.patAddress ?? '';
                            spotBillingState.passPortNumberController.text =
                                patient.passport ?? '';

                            spotBillingController.updateState(
                              searchPatientList: [],
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  patient.patName ?? '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                                Text(
                                  "Phone : ${patient.patPhno ?? ''}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          if (spotBillingState.searchPatientList.isNotEmpty)
            SizedBox(height: 5),
        ],
      ),
    );
  }
}
