import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:icon_infoware/controller/color_controller/color_controller.dart';
import 'package:icon_infoware/controller/home_screen_controller/home_screen_controller.dart';
import 'package:icon_infoware/controller/order_details_screen_controller/order_details_screen_controller.dart';

import 'package:icon_infoware/core/constants/app_constants.dart';

import 'package:icon_infoware/core/themes/colors.dart';
import 'package:icon_infoware/view/screens/home_screen/widget/patient_details_list_shimmer.dart';
import 'package:icon_infoware/view/screens/oder_details_screen.dart';
import 'package:icon_infoware/view/screens/home_screen/widget/patient_details_card.dart';
import 'package:icon_infoware/view/screens/home_screen/widget/active_section_card.dart';
import 'package:icon_infoware/view/widgets/new_orders_card.dart';

import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeScreenProvider);
    final homeController = ref.read(homeScreenProvider.notifier);
    final colorState = ref.watch(colorProvider);
    final orderDetailScreenController = ref.read(
      orderDetailsScreenProvider.notifier,
    );
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
                    File(AppConstants.base64Image),
                  ),
                ),
              ],
            ),

            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: RefreshIndicator(
              color: colorState.primaryColor, // spinner color
              backgroundColor: colorState.secondaryColor, // circle background
              strokeWidth: 2,
              onRefresh: () async {
                await homeController.getPatientBookingDetails(null);
              },
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  spacing: 10,
                  children: [
                    SizedBox(height: .1),
                    ActiveSessionCard(),

                    Row(
                      spacing: 10,
                      children: [
                        homeState.isLoading == true
                            ? PatientDetailsListShimmerRow()
                            : Expanded(
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  onTap: () {
                                    orderDetailScreenController.changeTab(0);
                                    PersistentNavBarNavigator.pushNewScreen(
                                      context,
                                      screen: const OderDetailsScreen(),
                                      withNavBar:
                                          false, // THIS HIDES BOTTOM NAV
                                      pageTransitionAnimation:
                                          PageTransitionAnimation.cupertino,
                                    );
                                  },
                                  child: NewOrdersStatCard(
                                    icon: Icons.add_box_outlined,
                                    category: 'New Orders',
                                    count: homeState.upcomingBookingList.length
                                        .toString(),
                                    belowCategory: 'Patients',
                                  ),
                                ),
                              ),
                        homeState.isLoading == true
                            ? PatientDetailsListShimmerRow()
                            : Expanded(
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  onTap: () {
                                    orderDetailScreenController.changeTab(1);
                                    PersistentNavBarNavigator.pushNewScreen(
                                      context,
                                      screen: const OderDetailsScreen(),
                                      withNavBar:
                                          false, //  THIS HIDES BOTTOM NAV
                                      pageTransitionAnimation:
                                          PageTransitionAnimation.cupertino,
                                    );
                                  },

                                  child: NewOrdersStatCard(
                                    icon: Icons.assignment_ind_outlined,
                                    category: 'Assigned to me',
                                    count: homeState.patientBookingList.length
                                        .toString(),
                                    belowCategory: 'Patients',
                                  ),
                                ),
                              ),
                      ],
                    ),
                    Row(
                      spacing: 10,
                      children: [
                        homeState.isLoading == true
                            ? PatientDetailsListShimmerRow()
                            : Expanded(
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  onTap: () {
                                    orderDetailScreenController.changeTab(2);
                                    PersistentNavBarNavigator.pushNewScreen(
                                      context,
                                      screen: const OderDetailsScreen(),
                                      withNavBar:
                                          false, //  THIS HIDES BOTTOM NAV
                                      pageTransitionAnimation:
                                          PageTransitionAnimation.cupertino,
                                    );
                                  },

                                  child: NewOrdersStatCard(
                                    icon: Icons.check_circle_outline,
                                    category: 'Completed',
                                    count: homeState
                                        .patientBookingListCompleted
                                        .length
                                        .toString(),
                                    belowCategory: 'Samples',
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                        homeState.isLoading == true
                            ? PatientDetailsListShimmerRow()
                            : Expanded(
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  onTap: () {
                                    orderDetailScreenController.changeTab(3);
                                    PersistentNavBarNavigator.pushNewScreen(
                                      context,
                                      screen: const OderDetailsScreen(),
                                      withNavBar:
                                          false, //  THIS HIDES BOTTOM NAV
                                      pageTransitionAnimation:
                                          PageTransitionAnimation.cupertino,
                                    );
                                  },

                                  child: NewOrdersStatCard(
                                    icon: Icons.receipt_long_outlined,
                                    category: 'Pending Invoice',
                                    count: homeState
                                        .patientBookingListPending
                                        .length
                                        .toString(),
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
                    homeState.isLoading == true
                        ? PatientDetailsListShimmer()
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: homeState.patientBookingList.length,
                            itemBuilder: (context, index) {
                              final patient =
                                  homeState.patientBookingList[index];

                              return PatientContactCard(
                                patient: patient,
                                index: patient.indexClick ?? 0,
                              );
                            },
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 10),
                          ),
                    // PatientContactCard(
                    //   address: "kakkanad,Ernakulam Phone 6767565647",
                    // ),
                    // PatientContactCard(
                    //   address: "vyttila,Ernakulam Phone 6767565647",
                    // ),
                    // PatientContactCard(address: "kakkanad,Ernakulam"),
                    // PatientContactCard(
                    //   address: "kakkanad,Ernakulam Phone 6767565647",
                    // ),
                    // PatientContactCard(
                    //   address: "kakkanad,Ernakulam Phone 6767565647",
                    // ),
                    SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
