import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:icon_infoware/controller/add_test_screen_controller/add_test_screen_controller.dart';
import 'package:icon_infoware/controller/home_screen_controller/home_screen_controller.dart';
import 'package:icon_infoware/controller/patient_billing/patient_billing_controller.dart';
import 'package:icon_infoware/core/errors/api_errors/api_errors.dart';
import 'package:icon_infoware/core/routes/app_route_names.dart';
import 'package:icon_infoware/core/themes/colors.dart';
import 'package:icon_infoware/models/spot_billing/done_by_search_response_model.dart';
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

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.appPrimaryColor),
        // Soft gradient background matching the image
        gradient: const LinearGradient(
          colors: [
            AppColors.appPrimaryColorLight,
            Color.fromARGB(255, 255, 255, 255),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
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
                      color: AppColors.appPrimaryColorLight,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.phone_outlined,
                        color: const Color(0xFF1A2B4C),
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // --- Details Section ---
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

            GestureDetector(
              onTap: addTestState.isSync != 'Yes'
                  ? () {
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
                    }
                  : () {
                      AppMessage.show(context, 'Bill is already synced.');
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
            Divider(
              color: Colors.black.withOpacity(0.06),
              thickness: 1.5,
              height: 1,
            ),
            const SizedBox(height: 5),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                      onTap: addTestState.isSync != 'Yes'
                          ? () {
                              if (addTestState.isCorporateBilling == true) {
                                log("corparate already clicked");
                                addTestController.updatestate(
                                  schemeIDSelected: 0,
                                );
                                addTestState.specialSchemeController.clear();
                                // addTestController.updateSpecialSchemePrice();
                              }
                              //  else {
                              //   log(
                              //     "Special scheme ID selected ${addTestState.schemeIDSelected.toString()}",
                              //   );
                              //   addTestController.updatestate(
                              //     schemeIDSelected: addTestState.schemeIDSelected,
                              //   );
                              //   addTestController.updateSpecialSchemePrice();
                              // }
                              addTestController.updatestate(
                                isCorporateBilling:
                                    !addTestState.isCorporateBilling,
                              );
                            }
                          : () {
                              AppMessage.show(
                                context,
                                'Bill is already synced.',
                              );
                            },
                      child: Icon(
                        addTestState.isCorporateBilling
                            ? Icons.check_box_outlined
                            : Icons.check_box_outline_blank,
                      ),
                    ),
                  ],
                ),
                addTestState.isCorporateBilling == true
                    ? Expanded(
                        child: Container(
                          height: 30,
                          margin: const EdgeInsets.only(left: 8),
                          decoration: BoxDecoration(
                            color: AppColors.appPrimaryColorLight,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return TapRegion(
                                onTapOutside: (_) {
                                  Future.delayed(Duration(seconds: 1));
                                  FocusManager.instance.primaryFocus?.unfocus();
                                },
                                child: DropdownMenu<AccountsList>(
                                  controller:
                                      addTestState.specialSchemeController,
                                  width: constraints.maxWidth,
                                  menuHeight:
                                      MediaQuery.of(context).size.height / 3,
                                  menuStyle: MenuStyle(
                                    backgroundColor: WidgetStatePropertyAll(
                                      const Color.fromARGB(
                                        255,
                                        230,
                                        227,
                                        227,
                                      ), // dropdown background
                                    ),
                                    surfaceTintColor: WidgetStatePropertyAll(
                                      Colors.transparent,
                                    ),
                                    shadowColor: WidgetStatePropertyAll(
                                      Colors.transparent,
                                    ),
                                  ),
                                  enableFilter: true,
                                  requestFocusOnTap: true,
                                  trailingIcon: const Icon(
                                    Icons.arrow_drop_down,
                                  ),
                                  selectedTrailingIcon: const Icon(
                                    Icons.arrow_drop_up,
                                  ),
                                  inputDecorationTheme:
                                      const InputDecorationTheme(
                                        isDense: true,
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 0,
                                        ),
                                        constraints: BoxConstraints(
                                          maxHeight: 30,
                                          minHeight: 30,
                                        ),
                                        hintStyle: TextStyle(fontSize: 12),
                                      ),
                                  hintText: 'Special Scheme',
                                  textStyle: const TextStyle(fontSize: 12),
                                  dropdownMenuEntries:
                                      addTestState.specialSchemeList.isEmpty
                                      ? [
                                          DropdownMenuEntry<AccountsList>(
                                            value: AccountsList(
                                              key: 0,
                                              name: "Items Not Found.",
                                              type: "",
                                              schemeId: 0,
                                            ),
                                            label: "Items Not Found.",
                                            enabled: false,
                                            style: ButtonStyle(
                                              padding: WidgetStatePropertyAll(
                                                const EdgeInsets.symmetric(
                                                  horizontal: 8,
                                                  vertical: 0,
                                                ),
                                              ),
                                              backgroundColor:
                                                  WidgetStateProperty.resolveWith((
                                                    states,
                                                  ) {
                                                    return Colors
                                                        .transparent; // remove hover color
                                                  }),
                                              overlayColor:
                                                  WidgetStateProperty.resolveWith((
                                                    states,
                                                  ) {
                                                    return Colors
                                                        .transparent; // remove ripple/hover effect
                                                  }),
                                              textStyle: WidgetStatePropertyAll(
                                                TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.bold,
                                                ), // item text size
                                              ),
                                            ),
                                          ),
                                        ]
                                      : addTestState.specialSchemeList
                                            .map(
                                              (
                                                item,
                                              ) => DropdownMenuEntry<AccountsList>(
                                                value: item,
                                                label: item.name ?? '',
                                                style: ButtonStyle(
                                                  padding: WidgetStatePropertyAll(
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 0,
                                                    ),
                                                  ),
                                                  backgroundColor:
                                                      WidgetStateProperty.resolveWith((
                                                        states,
                                                      ) {
                                                        return Colors
                                                            .transparent; // remove hover color
                                                      }),
                                                  overlayColor:
                                                      WidgetStateProperty.resolveWith((
                                                        states,
                                                      ) {
                                                        return Colors
                                                            .transparent; // remove ripple/hover effect
                                                      }),
                                                  textStyle:
                                                      WidgetStatePropertyAll(
                                                        TextStyle(
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ), // item text size
                                                      ),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                  onSelected: (value) {
                                    log(value!.name.toString());
                                    final selectedSchemeId =
                                        value.schemeId ?? 0;
                                    addTestController.updatestate(
                                      schemeIDSelected: selectedSchemeId,
                                    );
                                    // addTestController
                                    //     .updateSpecialSchemePrice();
                                    log(value.schemeId.toString());
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    : SizedBox(height: 30),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
