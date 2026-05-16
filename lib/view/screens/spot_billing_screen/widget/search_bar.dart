import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icon_infoware/controller/patient_billing/patient_billing_controller.dart';
import 'package:icon_infoware/core/themes/colors.dart';

class SearchBarContainer extends ConsumerWidget {
  final TextEditingController textController;

  final List<String> items;

  const SearchBarContainer({
    super.key,
    required this.textController,

    this.items = const [],
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final spotBillingState = ref.watch(patientBillingProvider);

    final spotBillingController = ref.read(patientBillingProvider.notifier);

    return Container(
      width: double.infinity,

      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.appPrimaryColorLight,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              /// TEXTFIELD
              Expanded(
                child: TextField(
                  controller: textController,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    if (value.length < 2) {
                      spotBillingController.updateState(searchPatientList: []);
                    } else if (value.length > 1) {
                      spotBillingController.updateState(isTextClear: true);
                    } else {
                      spotBillingController.updateState(isTextClear: false);
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
                    spotBillingController.updateState(
                      isTextClear: false,
                      patientSearchController: TextEditingController(text: ''),
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
                  await spotBillingController.searchPatient(
                    context: context,
                    body: textController.text.toString(),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: AppColors.appPrimaryColor,
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
                  ? Center(
                      child: CircularProgressIndicator(
                        color: AppColors.appBlack,
                      ),
                    )
                  : SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 8,
                          children: List.generate(
                            spotBillingState.searchPatientList.length,
                            (index) => InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              onTap: () {
                                spotBillingController.updateState(
                                  patientSearchController:
                                      TextEditingController(
                                        text:
                                            spotBillingState
                                                .searchPatientList[index]
                                                .patName ??
                                            '',
                                      ),
                                );
                                spotBillingController.updateState(
                                  searchPatientList: [],
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    spotBillingState
                                            .searchPatientList[index]
                                            .patName ??
                                        '',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                  Text(
                                    "Phone : ${spotBillingState.searchPatientList[index].patPhno ?? ''}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
          if (spotBillingState.searchPatientList.isNotEmpty)
            SizedBox(height: 5),
        ],
      ),
    );
  }
}
