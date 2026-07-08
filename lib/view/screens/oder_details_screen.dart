import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:icon_infoware/controller/home_screen_controller/home_screen_controller.dart';
import 'package:icon_infoware/controller/order_details_screen_controller/order_details_screen_controller.dart';
import 'package:icon_infoware/controller/patient_billing/patient_billing_controller.dart';

import 'package:icon_infoware/core/constants/app_constance.dart';
import 'package:icon_infoware/core/routes/app_route_names.dart';
import 'package:icon_infoware/core/themes/colors.dart';
import 'package:icon_infoware/view/screens/assigned_order_screen.dart';
import 'package:icon_infoware/view/screens/order_details_screen/screens/assigned_order_screen.dart';
import 'package:icon_infoware/view/screens/order_details_screen/screens/completed_patient_screen.dart';
import 'package:icon_infoware/view/screens/order_details_screen/screens/new_order_screen.dart';
import 'package:icon_infoware/view/screens/order_details_screen/screens/patient_pending_screen.dart';
import 'package:icon_infoware/view/screens/order_details_screen/widgets/patient_completed_card.dart';

class OderDetailsScreen extends ConsumerWidget {
  const OderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(orderDetailsScreenProvider);
    final controller = ref.read(orderDetailsScreenProvider.notifier);
    final homeState = ref.watch(homeScreenProvider);
    final spotBillingController = ref.read(patientBillingProvider.notifier);
    final spotBillingState = ref.watch(patientBillingProvider);

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
          return Scaffold(
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
                    backgroundColor: AppColors.appPrimaryColor.withOpacity(0.2),
                    child: const Icon(
                      Icons.arrow_back,
                      color: AppColors.appPrimaryColor,
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
                    child: Image.file(
                      width: MediaQuery.of(context).size.width / 1.5,
                      fit: BoxFit.fill,
                      File(AppConstance.base64Image),
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
                indicatorColor: AppColors.appPrimaryColor,
                indicatorWeight: 6,
                labelColor: AppColors.appPrimaryColor,
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
                  AssignedOrdersScreen(details: homeState.patientBookingList),
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
                spotBillingState.doneByController.text = 'Sumesh';
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
              backgroundColor: AppColors.appPrimaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Icon(Icons.add, color: Colors.white, size: 35),
            ),
          );
        },
      ),
    );
  }
}
