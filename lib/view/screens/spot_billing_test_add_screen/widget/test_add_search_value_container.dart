import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icon_infoware/core/themes/colors.dart';

class TestAddSearchValueContainer extends ConsumerWidget {
  final TextEditingController textController;
  const TestAddSearchValueContainer({super.key, required this.textController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,

      padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
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
                  onChanged: (value) async {},
                  decoration: const InputDecoration(
                    hintText: "Select value",
                    border: InputBorder.none,
                  ),
                ),
              ),

              // if (spotBillingState.isTextClear == true)
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                focusColor: Colors.transparent,
                onTap: () {
                  // spotBillingState.patientSearchController.clear();
                  // spotBillingController.updateState(
                  //   isTextClear: false,

                  //   // patientSearchController: TextEditingController(text: ''),
                  //   searchPatientList: [],
                  // );
                },
                child: Icon(Icons.close),
              ),
              SizedBox(width: 5),

              /// SEARCH BUTTON
              GestureDetector(
                onTap: () async {
                  // spotBillingController.updateState(searchPatientList: []);
                  // await spotBillingController.searchPatient(
                  //   context: context,
                  //   body: textController.text.toString(),
                  // );
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  // height: 50,
                  // width: 50,
                  decoration: BoxDecoration(
                    color: AppColors.appPrimaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.arrow_drop_down,
                      color: AppColors.appWhite,
                    ),
                  ),
                  // : Icon(Icons.search, color: AppColors.appWhite),
                ),
              ),
            ],
          ),
          // if (spotBillingState.searchPatientList.isNotEmpty)
          SizedBox(height: 10),

          /// SEARCH LIST
          // if (spotBillingState.searchPatientList.isNotEmpty)
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 238, 240, 238),
              border: Border.all(color: AppColors.appGrey, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: 10,
              itemBuilder: (context, index) {
                return InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "patient.patNa",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            //Spacer(),
                            Icon(Icons.check_box_outline_blank),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // if (spotBillingState.searchPatientList.isNotEmpty)
        ],
      ),
    );
  }
}
