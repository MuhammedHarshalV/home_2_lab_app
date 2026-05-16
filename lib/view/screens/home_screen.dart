import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icon_infoware/controller/timer_controller/timer_controller.dart';
import 'package:icon_infoware/controller/timer_controller/timer_state.dart';
import 'package:icon_infoware/core/api_constants/base64_image.dart';
import 'package:icon_infoware/core/themes/colors.dart';
import 'package:icon_infoware/view/screens/oder_details_screen.dart';
import 'package:icon_infoware/view/widgets/active_schedule_card.dart';
import 'package:icon_infoware/view/widgets/active_section_card.dart';
import 'package:icon_infoware/view/widgets/new_orders_card.dart';
import 'package:icon_infoware/view/widgets/timer_card.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerState = ref.watch(customTimerProvider);
    final timerController = ref.read(customTimerProvider.notifier);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: AppColors.appWhite,
        statusBarIconBrightness: Brightness.light, // icons = white
        statusBarBrightness: Brightness.dark, // for iOS
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xFFF8FAFC),
          appBar: AppBar(
            backgroundColor: AppColors.appWhite,
            toolbarHeight: 100,
            automaticallyImplyLeading: false,

            title: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Image.file(
                    width: MediaQuery.of(context).size.width / 1.5,
                    fit: BoxFit.fill,
                    File(Base64Image.base64Image),
                  ),
                ),
              ],
            ),

            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: Column(
                spacing: 10,
                children: [
                  SizedBox(height: .1),
                  ActiveSessionCard(),

                  Row(
                    spacing: 10,
                    children: [
                      Expanded(
                        child: InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          onTap: () => PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: const OrderDashboardScreen(initialIndex: 0),
                            withNavBar: false, // 🔥 THIS HIDES BOTTOM NAV
                            pageTransitionAnimation:
                                PageTransitionAnimation.cupertino,
                          ),
                          child: NewOrdersStatCard(
                            icon: Icons.add_box_outlined,
                            category: 'New Orders',
                            count: '000',
                            belowCategory: 'Patients',
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          onTap: () => PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: const OrderDashboardScreen(initialIndex: 1),
                            withNavBar: false, // 🔥 THIS HIDES BOTTOM NAV
                            pageTransitionAnimation:
                                PageTransitionAnimation.cupertino,
                          ),
                          child: NewOrdersStatCard(
                            icon: Icons.assignment_ind_outlined,
                            category: 'Assigned to me',
                            count: '12',
                            belowCategory: 'Patients',
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: 10,
                    children: [
                      Expanded(
                        child: InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          onTap: () => PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: const OrderDashboardScreen(initialIndex: 2),
                            withNavBar: false, // 🔥 THIS HIDES BOTTOM NAV
                            pageTransitionAnimation:
                                PageTransitionAnimation.cupertino,
                          ),
                          child: NewOrdersStatCard(
                            icon: Icons.check_circle_outline,
                            category: 'Completed',
                            count: '00',
                            belowCategory: 'Samples',
                            color: Colors.green,
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          onTap: () => PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: const OrderDashboardScreen(initialIndex: 3),
                            withNavBar: false, // 🔥 THIS HIDES BOTTOM NAV
                            pageTransitionAnimation:
                                PageTransitionAnimation.cupertino,
                          ),
                          child: NewOrdersStatCard(
                            icon: Icons.receipt_long_outlined,
                            category: 'Pending Invoice',
                            count: '12',
                            belowCategory: 'Invoices',
                            color: AppColors.appYellow,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        'Active Schedule',
                        style: TextStyle(
                          color: AppColors.appBlack,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Spacer(),
                      Text(
                        'View All',
                        style: TextStyle(color: AppColors.appGrey),
                      ),
                    ],
                  ),
                  PatientContactCard(
                    address: "kakkanad,Ernakulam Phone 6767565647",
                  ),
                  PatientContactCard(
                    address: "vyttila,Ernakulam Phone 6767565647",
                  ),
                  PatientContactCard(address: "kakkanad,Ernakulam"),
                  PatientContactCard(
                    address: "kakkanad,Ernakulam Phone 6767565647",
                  ),
                  PatientContactCard(
                    address: "kakkanad,Ernakulam Phone 6767565647",
                  ),
                  SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
