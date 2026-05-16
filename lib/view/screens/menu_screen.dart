import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icon_infoware/core/api_constants/base64_image.dart';
import 'package:icon_infoware/core/themes/colors.dart';

class MenuScreen extends ConsumerWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                            File(Base64Image.base64Image),
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

                      buildSettingsItem(Icons.sync, "Test Sync"),
                      buildSettingsItem(Icons.receipt_long, "Invoice Sync"),
                      buildSettingsItem(Icons.grid_view, "Booking Sync"),
                      buildSettingsItem(Icons.edit_note, "Log modify Sync"),
                      buildSettingsItem(Icons.payments, "Cash closing"),

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

                      buildSettingsItem(Icons.receipt_long, "All Invoices"),
                      buildSettingsItem(Icons.print_rounded, "Switch Printer"),
                      buildSettingsItem(Icons.grid_view, "Change Paper Size"),
                      buildSettingsItem(Icons.edit, "Seasonal Message"),
                      buildSettingsItem(Icons.money_sharp, "Service Charge"),
                      buildSettingsItem(Icons.wallet, "Set Whatsapp Content"),
                      buildSettingsItem(Icons.email, "Set Email Content"),
                      buildSettingsItem(Icons.tablet_mac, "Bill Title"),
                      buildSettingsItem(Icons.gpp_maybe, "Change UPI ID"),
                      buildSettingsItem(Icons.bakery_dining, "Switch Bank"),

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

                      buildSettingsItem(Icons.sync, "Help and Support"),
                      buildSettingsItem(
                        Icons.receipt_long,
                        "Terms and Conditions",
                      ),
                      buildSettingsItem(Icons.grid_view, "Privacy Policy"),

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
Widget buildSettingsItem(IconData icon, String title) {
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
          child: Icon(icon, color: AppColors.appPrimaryColor, size: 20),
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
