import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:icon_infoware/controller/add_test_screen_controller/add_test_screen_controller.dart';
import 'package:icon_infoware/controller/color_controller/color_controller.dart';
import 'package:icon_infoware/controller/color_controller/color_state.dart';
import 'package:icon_infoware/controller/home_screen_controller/home_screen_controller.dart';
import 'package:icon_infoware/controller/patient_billing/patient_billing_controller.dart';
import 'package:icon_infoware/controller/bank_fetching_controller/bank_fetching_controller.dart';
import 'package:icon_infoware/controller/print_controller/print_controller.dart';
import 'package:icon_infoware/controller/print_controller/print_state.dart';
import 'package:icon_infoware/core/constants/app_constants.dart';
import 'package:icon_infoware/core/errors/api_errors/api_errors.dart';
import 'package:icon_infoware/core/routes/app_route_names.dart';
import 'package:icon_infoware/core/themes/colors.dart';
import 'package:icon_infoware/models/banking_fetching/banking_fetching_response_model.dart';
import 'package:icon_infoware/models/patient_bill_syncing_model/patient_bill_syncing_model.dart';
import 'package:icon_infoware/view/screens/menu_screen/widget/email_content_popup.dart';
import 'package:icon_infoware/view/screens/menu_screen/widget/whatsapp_content_popup.dart';

import 'package:icon_infoware/view/widgets/common_touch_point_dropdown.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

class MenuScreen extends ConsumerWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bankingstate = ref.watch(bankFetchingProvider);
    final patientstate = ref.watch(patientBillingProvider);
    final addTeststate = ref.watch(addTestScreenProvider);
    final homeState = ref.watch(homeScreenProvider);
    final colorState = ref.watch(colorProvider);
    final printState = ref.watch(printProvider);

    final bankingController = ref.read(bankFetchingProvider.notifier);
    final patientController = ref.read(patientBillingProvider.notifier);
    final addTestController = ref.read(addTestScreenProvider.notifier);
    final colorController = ref.read(colorProvider.notifier);
    final homeController = ref.read(homeScreenProvider.notifier);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: colorState.primaryColor,
        statusBarIconBrightness: Brightness.dark, // Android icons
        statusBarBrightness: Brightness.light,
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xFFF8FAFC),

          body: CustomScrollView(
            slivers: [
              ///  Collapsing AppBar
              SliverAppBar(
                expandedHeight: 280,
                pinned: true,
                backgroundColor: colorState.primaryColor,
                elevation: 0,
                forceElevated: false,
                // 1. This is how you get the curved bottom on a SliverAppBar
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(20),
                  ),
                ),

                // 2. Use FlexibleSpaceBar's title for the "fade-in" effect
                // instead of the SliverAppBar.title property.
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  centerTitle: true,
                  titlePadding: const EdgeInsets.only(
                    bottom: 16,
                  ), // Adjust position
                  title: LayoutBuilder(
                    builder: (context, constraints) {
                      // Only show text when the bar is nearly collapsed
                      var top = constraints.biggest.height;
                      return Opacity(
                        opacity: top < 120 ? 1.0 : 0.0,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Image.file(
                            width: MediaQuery.of(context).size.width / 3,
                            fit: BoxFit.fill,
                            File(AppConstants.base64Image),
                          ),
                        ),
                      );
                    },
                  ),
                  background: Container(
                    // Keep your background decoration for when it is expanded
                    decoration: BoxDecoration(
                      color: colorState.primaryColor,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(40),
                      ),
                    ),
                    child: SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.white,
                            child: Text(
                              AppConstants.userName.isNotEmpty
                                  ? AppConstants.userName[0]
                                  : "",
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: colorState.primaryColor,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            AppConstants.userName.isNotEmpty
                                ? AppConstants.userName[0].toUpperCase() +
                                      AppConstants.userName.substring(1)
                                : '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            AppConstants.name,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Container(
                          //   margin: const EdgeInsets.symmetric(horizontal: 20),
                          //   padding: const EdgeInsets.symmetric(vertical: 12),
                          //   decoration: BoxDecoration(
                          //     color: Colors.white.withOpacity(0.1),
                          //     borderRadius: BorderRadius.circular(20),
                          //   ),
                          //   child: const Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //     children: [
                          //       StatItem(label: "Today", value: "24"),
                          //       // Note: Use a SizedBox with height for VerticalDivider in a Row
                          //       SizedBox(
                          //         height: 20,
                          //         child: VerticalDivider(color: Colors.white24),
                          //       ),
                          //       StatItem(label: "Month", value: "312"),
                          //       SizedBox(
                          //         height: 20,
                          //         child: VerticalDivider(color: Colors.white24),
                          //       ),
                          //       StatItem(label: "Rating", value: "4.9"),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      onTap: () {},
                      child: CircleAvatar(
                        backgroundColor: AppColors.appWhite.withOpacity(0.2),
                        child: Icon(
                          Icons.exit_to_app,
                          color: AppColors.appWhite,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              /// Content
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "GENERAL SETTINGS",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 16),

                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        onTap: () async {
                          await addTestController.getTestMasterLists(
                            null,
                            true,
                            context,
                          );
                        },
                        child: buildSettingsItem(
                          addTeststate.isTestSync == true
                              ? SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 1,
                                      color: colorState.primaryColor,
                                    ),
                                  ),
                                )
                              : Icon(
                                  Icons.sync,
                                  size: 20,
                                  color: colorState.primaryColor,
                                ),
                          "Test Sync",
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        onTap: () async {
                          await patientController.doneBySearch(
                            searchText: '',
                            apiCall: true,
                            context: context,
                          );
                          addTestController.getspecialSchemeAccounts();
                          await addTestController.specialRatesFetch(
                            apiCall: false,
                            context: null,
                          );
                        },
                        child: buildSettingsItem(
                          patientstate.isLoading == true
                              ? SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 1,
                                      color: colorState.primaryColor,
                                    ),
                                  ),
                                )
                              : Icon(
                                  Icons.sync,
                                  size: 20,
                                  color: colorState.primaryColor,
                                ),
                          "Account Heads Sync",
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        onTap: () async {
                          await addTestController.specialRatesFetch(
                            apiCall: true,
                            context: context,
                          );
                          addTestController.getspecialSchemeAccounts();
                        },
                        child: buildSettingsItem(
                          addTeststate.isSpecialLoading == true
                              ? SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 1,
                                      color: colorState.primaryColor,
                                    ),
                                  ),
                                )
                              : Icon(
                                  Icons.sync,
                                  size: 20,
                                  color: colorState.primaryColor,
                                ),
                          "Special Rates Sync",
                        ),
                      ),

                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        onTap: () async {
                          final List<PatientHiveModel> patients = [];
                          for (final patient in homeState.allBookingDetails) {
                            if (patient.isCompleted == 'Yes' &&
                                patient.isSync != 'Yes') {
                              patients.add(patient);
                            }
                          }

                          if (patients.isEmpty) {
                            AppMessage.show(
                              context,
                              'No completed patients available for syncing.',
                            );
                            return;
                          }

                          final bool isSync = await addTestController
                              .patientBillSyncingApi(
                                patient: patients,
                                context: context,
                                sync: null,
                              );
                          if (isSync == true) {
                            for (final patient in patients) {
                              await homeController.updatePatient(
                                index: patient.indexClick ?? 0,
                                isSync: "Yes",
                              );
                            }
                            AppMessage.show(
                              context,
                              'Patient records synced successfully.',
                            );
                          }
                        },
                        child: buildSettingsItem(
                          addTeststate.isSyncLoading == true
                              ? SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 1,
                                      color: colorState.primaryColor,
                                    ),
                                  ),
                                )
                              : Icon(
                                  Icons.receipt_long_outlined,
                                  size: 20,
                                  color: colorState.primaryColor,
                                ),
                          "Invoice Sync",
                        ),
                      ),

                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        onTap: () {},
                        child: buildSettingsItem(
                          Icon(
                            Icons.calendar_month_outlined,
                            size: 20,
                            color: colorState.primaryColor,
                          ),
                          "Booking Sync",
                        ),
                      ),

                      buildSettingsItem(
                        Icon(
                          Icons.manage_history_outlined,
                          size: 20,
                          color: colorState.primaryColor,
                        ),
                        "Log Modify Sync",
                      ),

                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        onTap: () {
                          context.pushNamed(
                            AppRouteNames.printCashCloserScreenroute.name,
                          );
                        },
                        child: buildSettingsItem(
                          Icon(
                            Icons.payments_outlined,
                            size: 20,
                            color: colorState.primaryColor,
                          ),
                          "Cash Closing",
                        ),
                      ),

                      const SizedBox(height: 24),

                      const Text(
                        "APP SETTINGS",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 16),

                      buildSettingsItem(
                        Icon(
                          Icons.receipt_long_outlined,
                          size: 20,
                          color: colorState.primaryColor,
                        ),
                        "All Invoices",
                      ),

                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        onTapDown: (details) async {
                          final List<BluetoothInfo> listResult =
                              await PrintBluetoothThermal.pairedBluetooths;
                          ref
                              .read(printProvider.notifier)
                              .updateState(item: listResult);
                          log(listResult.toString());
                          if (printState.printDevices.isNotEmpty) {
                            await commonTouchPointDropdown<BluetoothInfo>(
                              context: context,

                              tapPosition: details.globalPosition,
                              items: printState.printDevices,
                              itemText: (item) => item.name.isNotEmpty
                                  ? item.name
                                  : "Unknown Device",
                              onSelected: (item) async {
                                ref
                                    .read(printProvider.notifier)
                                    .selectPrinter(item);
                                // context.pop();
                              },
                            );
                          }
                        },
                        child: buildSettingsItem(
                          Icon(
                            Icons.print_outlined,
                            size: 20,
                            color: colorState.primaryColor,
                          ),
                          "Switch Printer",
                        ),
                      ),

                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        onTapDown: (details) async {
                          List<PaperType> item = [
                            PaperType.mm58,
                            PaperType.mm72,
                            PaperType.mm80,
                          ];
                          await commonTouchPointDropdown<PaperType>(
                            context: context,

                            tapPosition: details.globalPosition,
                            items: item,
                            itemText: (item) => item.toString(),

                            onSelected: (item) async {
                              ref
                                  .read(printProvider.notifier)
                                  .changePaper(item);
                              // context.pop();
                            },
                          );
                        },
                        child: buildSettingsItem(
                          Icon(
                            Icons.description_outlined,
                            size: 20,
                            color: colorState.primaryColor,
                          ),
                          "Paper Size",
                        ),
                      ),

                      buildSettingsItem(
                        Icon(
                          Icons.message_outlined,
                          size: 20,
                          color: colorState.primaryColor,
                        ),
                        "Seasonal Message",
                      ),

                      buildSettingsItem(
                        Icon(
                          Icons.payments_outlined,
                          size: 20,
                          color: colorState.primaryColor,
                        ),
                        "Service Charge",
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => WhatsappContentPopup(),
                          );
                        },
                        child: buildSettingsItem(
                          FaIcon(
                            FontAwesomeIcons.whatsapp,
                            color: colorState.primaryColor,
                          ),
                          "Set Whatsapp Content",
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => EmailContentPopup(),
                          );
                        },
                        child: buildSettingsItem(
                          Icon(
                            Icons.mark_email_read_outlined,
                            size: 20,
                            color: colorState.primaryColor,
                          ),
                          "Email Content",
                        ),
                      ),

                      buildSettingsItem(
                        Icon(
                          Icons.receipt_outlined,
                          size: 20,
                          color: colorState.primaryColor,
                        ),
                        "Bill Title",
                      ),

                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        onTapDown: (details) async {
                          await bankingController.bankFetchingApi(context);
                          if (bankingstate.bankFetching.isNotEmpty) {
                            await commonTouchPointDropdown<BankList>(
                              context: context,

                              tapPosition: details.globalPosition,
                              items: bankingstate.bankFetching,
                              itemText: (item) => item.name ?? '',
                              onSelected: (item) async {
                                log(item.upiId);
                                await bankingController.storeUpiId(
                                  upiId: item.upiId,
                                );
                              },
                            );
                          }
                        },
                        child: buildSettingsItem(
                          bankingstate.isLoading == true
                              ? SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 1,
                                      color: colorState.primaryColor,
                                    ),
                                  ),
                                )
                              : Icon(
                                  Icons.payments_outlined,
                                  size: 20,
                                  color: colorState.primaryColor,
                                ),
                          "Change UPI ID",
                        ),
                      ),

                      buildSettingsItem(
                        Icon(
                          Icons.account_balance_outlined,
                          size: 20,
                          color: colorState.primaryColor,
                        ),
                        "Switch Bank",
                      ),

                      const SizedBox(height: 24),
                      const Text(
                        "ABOUT",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 16),

                      buildSettingsItem(
                        Icon(
                          Icons.support_agent_outlined,
                          size: 20,
                          color: colorState.primaryColor,
                        ),
                        "Help and Support",
                      ),

                      buildSettingsItem(
                        Icon(
                          Icons.description_outlined,
                          size: 20,
                          color: colorState.primaryColor,
                        ),
                        "Terms and Conditions",
                      ),

                      buildSettingsItem(
                        Icon(
                          Icons.privacy_tip_outlined,
                          size: 20,
                          color: colorState.primaryColor,
                        ),
                        "Privacy Policy",
                      ),
                      SizedBox(height: 20),
                      const Text(
                        "COLOR SETTING",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 16),
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        onTap: () {
                          Color selectedColor = colorState.primaryColor;
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: AppColors.appWhite,
                                title: Center(
                                  child: Text(
                                    "Pick Primary Color",
                                    style: TextStyle(
                                      color: AppColors.appBlack,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                content: SingleChildScrollView(
                                  child: ColorPicker(
                                    pickerColor: selectedColor,
                                    onColorChanged: (Color color) {
                                      selectedColor = color;
                                    },
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      colorController.defaultColor(
                                        primaryColor: const Color.fromARGB(
                                          255,
                                          21,
                                          130,
                                          24,
                                        ),
                                      );
                                      context.pop();
                                    },
                                    child: const Text(
                                      "Restore Default",
                                      style: TextStyle(
                                        color: AppColors.appBlack,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: colorState.primaryColor,
                                    ),
                                    onPressed: () {
                                      colorController.updateState(
                                        primaryColor: selectedColor,
                                      );
                                      context.pop();
                                    },
                                    child: const Text(
                                      "Done",
                                      style: TextStyle(
                                        color: AppColors.appWhite,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: buildSettingsItem(
                          Icon(
                            Icons.calendar_month_outlined,
                            size: 20,
                            color: colorState.primaryColor,
                          ),
                          "Primary Color",
                        ),
                      ),
                      SizedBox(height: 5),
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        onTap: () {
                          Color selectedColor = colorState.secondaryColor;
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: AppColors.appWhite,
                                title: Center(
                                  child: Text(
                                    "Pick Secondary Color",
                                    style: TextStyle(
                                      color: AppColors.appBlack,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                content: SingleChildScrollView(
                                  child: ColorPicker(
                                    pickerColor: selectedColor,
                                    onColorChanged: (Color color) {
                                      selectedColor = color;
                                    },
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      colorController.defaultColor(
                                        secondaryColor: const Color.fromARGB(
                                          255,
                                          216,
                                          250,
                                          217,
                                        ),
                                      );
                                      context.pop();
                                    },
                                    child: const Text(
                                      "Restore Default",
                                      style: TextStyle(
                                        color: AppColors.appBlack,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: colorState.primaryColor,
                                    ),
                                    onPressed: () {
                                      colorController.updateState(
                                        secondaryColor: selectedColor,
                                      );
                                      context.pop();
                                    },
                                    child: const Text(
                                      "Done",
                                      style: TextStyle(
                                        color: AppColors.appWhite,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: buildSettingsItem(
                          Icon(
                            Icons.calendar_month_outlined,
                            size: 20,
                            color: colorState.primaryColor,
                          ),
                          "Secondary Color",
                        ),
                      ),
                      SizedBox(height: 16),
                      buildSettingsItem(
                        Icon(
                          Icons.logout_outlined,
                          size: 20,
                          color: colorState.primaryColor,
                        ),
                        "Logout",
                      ),
                      const SizedBox(height: 70),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class StatItem extends StatelessWidget {
//   final String label, value;
//   const StatItem({super.key, required this.label, required this.value});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text(
//           value,
//           style: const TextStyle(
//             color: Colors.white,
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         Text(
//           label,
//           style: const TextStyle(color: Colors.white70, fontSize: 12),
//         ),
//       ],
//     );
//   }
// }

//
Widget buildSettingsItem(Widget icon, String title) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      color: AppColors.appWhite,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.grey.shade100),
    ),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.appLightGreen,
            borderRadius: BorderRadius.circular(10),
          ),
          child: icon,
        ),
        const SizedBox(width: 16),
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const Spacer(),
        Icon(Icons.chevron_right, color: Colors.grey.shade400),
      ],
    ),
  );
}
