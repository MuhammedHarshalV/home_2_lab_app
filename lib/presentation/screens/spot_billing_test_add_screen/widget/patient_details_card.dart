import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:icon_infoware/controller/add_test_screen_controller/add_test_screen_controller.dart';

import 'package:icon_infoware/controller/home_screen_controller/home_screen_controller.dart';
import 'package:icon_infoware/controller/patient_billing/patient_billing_controller.dart';
import 'package:icon_infoware/controller/timer_controller/timer_controller.dart';
import 'package:icon_infoware/core/errors/api_errors/api_errors.dart';
import 'package:icon_infoware/core/routes/app_route_names.dart';
import 'package:icon_infoware/core/themes/colors.dart';

import 'package:icon_infoware/presentation/screens/spot_billing_test_add_screen/widget/special_scheme_card.dart';
import 'package:url_launcher/url_launcher.dart';

class PatientDetailsCard extends ConsumerWidget {
  final int? index;
  const PatientDetailsCard({super.key, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addTestController = ref.read(addTestScreenProvider.notifier);
    final addTestState = ref.watch(addTestScreenProvider);
    final patientBillingDetailsState = ref.watch(patientBillingProvider);
    final homeState = ref.watch(homeScreenProvider);
    final homeController = ref.read(homeScreenProvider.notifier);

    final timerState = ref.watch(customTimerProvider);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderColor),

        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Top Row: Name and Icons ---
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    "${patientBillingDetailsState.patientDetailsController.text} ${patientBillingDetailsState.patientNameController.text}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1A2B4C), // Dark navy text
                      letterSpacing: 0.2,
                    ),
                  ),
                ),

                InkWell(
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    final Uri url = Uri(
                      scheme: 'tel',
                      path: patientBillingDetailsState
                          .patientPhoneController
                          .text,
                    );

                    if (await canLaunchUrl(url)) {
                      await launchUrl(url); // opens dialer safely
                    } else {
                      log('Could not launch dialer');
                    }
                  },
                  child: Container(
                    // margin: EdgeInsets.only(left: 8),
                    // padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      //    color: colorState.secondaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Icon(
                        Icons.phone_outlined,
                        color: const Color(0xFF1A2B4C),
                        size: 25,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    addTestController.updatestate(
                      isProfileShow: !addTestState.isProfileShow,
                    );
                  },
                  child: Icon(
                    addTestState.isProfileShow
                        ? Icons.arrow_drop_up
                        : Icons.arrow_drop_down_sharp,
                  ),
                ),
              ],
            ),

            // --- Details Section ---
            if (addTestState.isProfileShow)
              Row(
                children: [
                  Text(
                    'Gender:',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF37474F), // Dark grey-blue
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    ' ${patientBillingDetailsState.genderController.text}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF37474F), // Dark grey-blue
                    ),
                  ),
                  Text('  |  '),
                  Text(
                    'Age:',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF37474F), // Dark grey-blue
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    ' ${patientBillingDetailsState.ageController.text}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF37474F), // Dark grey-blue
                    ),
                  ),
                ],
              ),

            /// const SizedBox(height: 4),
            if (addTestState.isProfileShow)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Location:',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF37474F),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      ' ${patientBillingDetailsState.addressController.text}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF37474F), // Dark grey-blue
                      ),
                    ),
                  ),
                ],
              ),

            if (addTestState.isProfileShow)
              GestureDetector(
                onTap: () async {
                  if (timerState.isRunning == false &&
                      addTestState.isSync != 'Yes') {
                    AppMessage.show(
                      context,
                      "You must press the Start button first.",
                    );
                    return;
                  }
                  if (addTestState.isSync != 'Yes') {
                    if (index == null) {
                      int indexNot =
                          homeState.allBookingDetails.last.indexClick ?? 0;
                      context.pushNamed(
                        AppRouteNames.editSpotBillingScreen.name,
                        pathParameters: {'index': indexNot.toString()},
                      );
                    } else {
                      context.pushNamed(
                        AppRouteNames.editSpotBillingScreen.name,
                        pathParameters: {'index': index.toString()},
                      );
                    }
                  } else {
                    AppMessage.show(context, 'Bill is already synced.');
                  }
                },
                child: const Text(
                  'Edit Patient Info',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.blueAccent,
                  ),
                ),
              ),

            // --- Divider ---
            if (addTestState.isProfileShow)
              Divider(
                color: Colors.black.withValues(alpha: 0.06),
                thickness: 1.5,
                height: 1,
              ),
            if (addTestState.isProfileShow) const SizedBox(height: 5),

            if (addTestState.isProfileShow)
              Row(
                children: [
                  Text(
                    'Corporate billing:',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A2B4C),
                    ),
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    onTap: () async {
                      if (timerState.isRunning == false &&
                          addTestState.isSync != 'Yes') {
                        AppMessage.show(
                          context,
                          "You must press the Start button first.",
                        );
                        return;
                      }
                      if (addTestState.isSync != 'Yes') {
                        if (addTestState.isCorporateBilling == true) {
                          log("corparate already clicked");
                          addTestController.updatestate(
                            schemeIDSelected: 0,
                            rateIDSelected: 0,
                          );
                          if (index == null) {
                            int indexNot =
                                homeState.allBookingDetails.last.indexClick ??
                                0;
                            homeController.updatePatient(
                              index: indexNot,
                              rateIdSelected: 0,
                              specialSchemeName: '',
                              specialSchemeID: 0,
                            );
                          } else {
                            homeController.updatePatient(
                              index: index!,
                              rateIdSelected: 0,
                              specialSchemeName: '',
                              specialSchemeID: 0,
                            );
                          }
                          addTestController.updateNetBalanceAmounts();
                          addTestState.specialSchemeController.clear();
                          final testMasterState1 = ref.watch(
                            addTestScreenProvider,
                          );
                          await homeController.updatePatient(
                            index:
                                index ??
                                homeState.allBookingDetails.last.indexClick ??
                                0,

                            balance: testMasterState1.balanceAmount,
                            netAmt: testMasterState1.netAmount,

                            grossAmt: testMasterState1.totalPrice,
                          );
                          // addTestController.updateSpecialSchemePrice();
                        }

                        addTestController.updatestate(
                          isCorporateBilling: !addTestState.isCorporateBilling,
                        );
                        if (addTestState.specialSchemeList.isEmpty) {
                          addTestController.getspecialSchemeAccounts();
                        }
                      } else {
                        AppMessage.show(context, 'Bill is already synced.');
                      }
                    },
                    child: Icon(
                      addTestState.isCorporateBilling
                          ? Icons.check_box_outlined
                          : Icons.check_box_outline_blank,
                    ),
                  ),
                ],
              ),
            if (addTestState.isProfileShow) SizedBox(height: 5),
            if (addTestState.isProfileShow)
              addTestState.isCorporateBilling == true
                  ? SpecialSchemeCard(index: index)
                  // SizedBox()
                  : SizedBox(),
          ],
        ),
      ),
    );
  }
}
