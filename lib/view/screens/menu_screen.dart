import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:icon_infoware/controller/progress_screen_controller/bank_fetching_controller.dart';
import 'package:icon_infoware/core/constants/app_constance.dart';
import 'package:icon_infoware/core/themes/colors.dart';
import 'package:icon_infoware/models/banking_fetching/banking_fetching_response_model.dart';
import 'package:icon_infoware/view/screens/spot_billing_test_add_screen/widget/drop_down_schemeID.dart';
import 'package:icon_infoware/view/widgets/common_touch_point_dropdown.dart';

class MenuScreen extends ConsumerWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bankingstate = ref.watch(bankFetchingProvider);
    final bankingController = ref.read(bankFetchingProvider.notifier);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.appPrimaryColor,
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
                backgroundColor: AppColors.appPrimaryColor,
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
                    decoration: const BoxDecoration(
                      color: AppColors.appPrimaryColor,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(40),
                      ),
                    ),
                    child: SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.white,
                            child: Text(
                              "S",
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: AppColors.appPrimaryColor,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Sumesh K.",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            "Sample Collector - Bengaluru",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                StatItem(label: "Today", value: "24"),
                                // Note: Use a SizedBox with height for VerticalDivider in a Row
                                SizedBox(
                                  height: 20,
                                  child: VerticalDivider(color: Colors.white24),
                                ),
                                StatItem(label: "Month", value: "312"),
                                SizedBox(
                                  height: 20,
                                  child: VerticalDivider(color: Colors.white24),
                                ),
                                StatItem(label: "Rating", value: "4.9"),
                              ],
                            ),
                          ),
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

                      buildSettingsItem(
                        const Icon(
                          Icons.sync,
                          size: 20,
                          color: AppColors.appPrimaryColor,
                        ),
                        "Test Sync",
                      ),

                      buildSettingsItem(
                        const Icon(
                          Icons.receipt_long_outlined,
                          size: 20,
                          color: AppColors.appPrimaryColor,
                        ),
                        "Invoice Sync",
                      ),

                      buildSettingsItem(
                        const Icon(
                          Icons.calendar_month_outlined,
                          size: 20,
                          color: AppColors.appPrimaryColor,
                        ),
                        "Booking Sync",
                      ),

                      buildSettingsItem(
                        const Icon(
                          Icons.manage_history_outlined,
                          size: 20,
                          color: AppColors.appPrimaryColor,
                        ),
                        "Log Modify Sync",
                      ),

                      buildSettingsItem(
                        const Icon(
                          Icons.payments_outlined,
                          size: 20,
                          color: AppColors.appPrimaryColor,
                        ),
                        "Cash Closing",
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
                        const Icon(
                          Icons.receipt_long_outlined,
                          size: 20,
                          color: AppColors.appPrimaryColor,
                        ),
                        "All Invoices",
                      ),

                      buildSettingsItem(
                        const Icon(
                          Icons.print_outlined,
                          size: 20,
                          color: AppColors.appPrimaryColor,
                        ),
                        "Switch Printer",
                      ),

                      buildSettingsItem(
                        const Icon(
                          Icons.description_outlined,
                          size: 20,
                          color: AppColors.appPrimaryColor,
                        ),
                        "Paper Size",
                      ),

                      buildSettingsItem(
                        const Icon(
                          Icons.message_outlined,
                          size: 20,
                          color: AppColors.appPrimaryColor,
                        ),
                        "Seasonal Message",
                      ),

                      buildSettingsItem(
                        const Icon(
                          Icons.payments_outlined,
                          size: 20,
                          color: AppColors.appPrimaryColor,
                        ),
                        "Service Charge",
                      ),
                      buildSettingsItem(
                        FaIcon(
                          FontAwesomeIcons.whatsapp,
                          color: AppColors.appPrimaryColor,
                        ),
                        "Set Whatsapp Content",
                      ),
                      buildSettingsItem(
                        const Icon(
                          Icons.mark_email_read_outlined,
                          size: 20,
                          color: AppColors.appPrimaryColor,
                        ),
                        "Email Content",
                      ),

                      buildSettingsItem(
                        const Icon(
                          Icons.receipt_outlined,
                          size: 20,
                          color: AppColors.appPrimaryColor,
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
                                    ),
                                  ),
                                )
                              : Icon(
                                  Icons.payments_outlined,
                                  size: 20,
                                  color: AppColors.appPrimaryColor,
                                ),
                          "Change UPI ID",
                        ),
                      ),

                      buildSettingsItem(
                        Icon(
                          Icons.account_balance_outlined,
                          size: 20,
                          color: AppColors.appPrimaryColor,
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
                        const Icon(
                          Icons.support_agent_outlined,
                          size: 20,
                          color: AppColors.appPrimaryColor,
                        ),
                        "Help and Support",
                      ),

                      buildSettingsItem(
                        const Icon(
                          Icons.description_outlined,
                          size: 20,
                          color: AppColors.appPrimaryColor,
                        ),
                        "Terms and Conditions",
                      ),

                      buildSettingsItem(
                        const Icon(
                          Icons.privacy_tip_outlined,
                          size: 20,
                          color: AppColors.appPrimaryColor,
                        ),
                        "Privacy Policy",
                      ),
                      SizedBox(height: 20),
                      buildSettingsItem(
                        const Icon(
                          Icons.logout_outlined,
                          size: 20,
                          color: AppColors.appPrimaryColor,
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

//header
Widget buildProfileHeader() {
  return Container(
    padding: const EdgeInsets.fromLTRB(20, 60, 20, 30),
    decoration: const BoxDecoration(
      color: Color(0xFF0E8B5C),
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
    ),
    child: Column(
      children: [
        const CircleAvatar(
          radius: 40,
          backgroundColor: Colors.white,
          child: Text(
            "S",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0E8B5C),
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          "Sumesh K.",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          "Sample Collector - Bengaluru",
          style: TextStyle(color: Colors.white70, fontSize: 14),
        ),
        const SizedBox(height: 30),
        // Stats Row
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              StatItem(label: "Today", value: "24"),
              VerticalDivider(color: Colors.white24, thickness: 1),
              StatItem(label: "This month", value: "312"),
              VerticalDivider(color: Colors.white24, thickness: 1),
              StatItem(label: "Rating", value: "4.9"),
            ],
          ),
        ),
      ],
    ),
  );
}

class StatItem extends StatelessWidget {
  final String label, value;
  const StatItem({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }
}

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
