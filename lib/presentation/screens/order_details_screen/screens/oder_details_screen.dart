import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:icon_infoware/controller/bottom_nav_screen/bottom_nav_controller.dart';
import 'package:icon_infoware/controller/color_controller/color_controller.dart';
import 'package:icon_infoware/controller/home_screen_controller/home_screen_controller.dart';
import 'package:icon_infoware/controller/order_details_screen_controller/order_details_screen_controller.dart';
import 'package:icon_infoware/controller/patient_billing/patient_billing_controller.dart';
import 'package:icon_infoware/controller/timer_controller/timer_controller.dart';

import 'package:icon_infoware/core/constants/app_constants.dart';
import 'package:icon_infoware/core/errors/api_errors/api_errors.dart';
import 'package:icon_infoware/core/routes/app_route_names.dart';
import 'package:icon_infoware/core/themes/colors.dart';

import 'package:icon_infoware/presentation/screens/order_details_screen/widgets/assigned_order_screen.dart';
import 'package:icon_infoware/presentation/screens/order_details_screen/widgets/completed_patient_screen.dart';
import 'package:icon_infoware/presentation/screens/order_details_screen/widgets/new_order_screen.dart';
import 'package:icon_infoware/presentation/screens/order_details_screen/widgets/patient_pending_screen.dart';

class OderDetailsScreen extends ConsumerWidget {
  const OderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(orderDetailsScreenProvider);
    final controller = ref.read(orderDetailsScreenProvider.notifier);
    final homeState = ref.watch(homeScreenProvider);
    final spotBillingController = ref.read(patientBillingProvider.notifier);
    final spotBillingState = ref.watch(patientBillingProvider);
    final colorState = ref.watch(colorProvider);
    final timerState = ref.watch(customTimerProvider);
    final tabControllerState = ref.watch(tabControllerProvider);
    final bottomNavState = ref.watch(bottomNavProvider);
    return DefaultTabController(
      initialIndex: state.selectedTabIndex,
      length: 4,
      child: Builder(
        builder: (context) {
          final tabController = DefaultTabController.of(context);

          tabController.addListener(() {
            if (!tabController.indexIsChanging) {
              controller.changeTab(tabController.index);
            }
          });
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
                  toolbarHeight: 100,
                  automaticallyImplyLeading: false,
                  backgroundColor: AppColors.appWhite,
                  elevation: 0,

                  leading: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () => Navigator.pop(context),
                      child: CircleAvatar(
                        backgroundColor: colorState.primaryColor.withValues(
                          alpha: 0.2,
                        ),
                        child: Icon(
                          Icons.arrow_back,
                          color: colorState.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: AppConstants.base64Image.isEmpty
                            ? null
                            : Image.file(
                                width: MediaQuery.of(context).size.width / 1.5,
                                fit: BoxFit.fill,
                                File(AppConstants.base64Image),
                              ),
                      ),
                    ],
                  ),

                  // actions: [
                  //   // TimerCard(timerState: timerState, timerController: timerController),
                  //   // const SizedBox(width: 5),

                  // ],
                  bottom: TabBar(
                    indicatorSize: TabBarIndicatorSize.label,
                    controller: DefaultTabController.of(context),
                    indicatorColor: colorState.primaryColor,
                    indicatorWeight: 6,
                    labelColor: colorState.primaryColor,
                    unselectedLabelColor: AppColors.appBlack,
                    labelStyle: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                    labelPadding: EdgeInsets.symmetric(horizontal: 8),
                    tabs: const [
                      Tab(
                        icon: Icon(Icons.local_shipping_outlined, size: 22),
                        text: "New orders",
                      ),
                      Tab(
                        icon: Icon(Icons.person_search_outlined, size: 22),
                        text: "Assigned to me",
                      ),
                      Tab(
                        icon: Icon(Icons.inventory_2_outlined, size: 22),
                        text: "Completed",
                      ),
                      Tab(
                        icon: Icon(Icons.receipt_long_outlined, size: 22),
                        text: "Pending",
                      ),
                    ],
                  ),
                ),

                body: Padding(
                  padding: const EdgeInsets.all(10),
                  child: TabBarView(
                    children: [
                      NewOrderScreen(details: homeState.upcomingBookingList),
                      AssignedOrdersScreen(
                        details: homeState.patientBookingList,
                      ),
                      CompletedPatientScreen(
                        details: homeState.patientBookingListCompleted,
                      ),
                      PatientPendingScreen(
                        details: homeState.patientBookingListPending,
                      ),
                    ],
                  ),
                ),

                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    if (timerState.isRunning == false) {
                      AppMessage.show(
                        context,
                        "Please press the Start button first.",
                      );

                      // Stay on the current tab
                      tabControllerState.jumpToTab(bottomNavState.currentIndex);
                      return;
                    }
                    spotBillingState.patientDetailsController.clear();
                    spotBillingState.patientNameController.clear();
                    spotBillingState.patientPhoneController.clear();
                    spotBillingState.patientEmailController.clear();
                    spotBillingState.patientDateOfBirthController.clear();
                    spotBillingState.ageController.clear();
                    spotBillingState.abhaIdController.clear();
                    spotBillingState.noteController.clear();
                    spotBillingState.genderController.clear();
                    spotBillingState.addressController.clear();
                    spotBillingState.referredByController.clear();
                    spotBillingState.assignedByController.clear();
                    spotBillingState.doneByController.text =
                        AppConstants.userName.isNotEmpty
                        ? AppConstants.userName[0].toUpperCase() +
                              AppConstants.userName.substring(1)
                        : '';
                    spotBillingState.patientEmailController.clear();
                    spotBillingState.passPortNumberController.clear();
                    spotBillingState.patientDetailsController.clear();
                    spotBillingState.patientSearchController.clear();

                    spotBillingController.updateState(
                      ageByYear: 'Year',
                      isUrgent: false,
                    );
                    context.pushNamed(AppRouteNames.spotBillingScreen.name);
                  },
                  backgroundColor: colorState.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Icon(Icons.add, color: Colors.white, size: 35),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
