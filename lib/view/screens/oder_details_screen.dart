import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icon_infoware/controller/timer_controller/timer_controller.dart';
import 'package:icon_infoware/core/api_constants/base64_image.dart';
import 'package:icon_infoware/core/themes/colors.dart';
import 'package:icon_infoware/view/screens/new_order_details_screen.dart';
import 'package:icon_infoware/view/screens/spot_billing_screen/screen/spot_billing_screen.dart';

class OrderDashboardScreen extends ConsumerStatefulWidget {
  final int initialIndex;

  const OrderDashboardScreen({super.key, this.initialIndex = 0});

  @override
  ConsumerState<OrderDashboardScreen> createState() =>
      _OrderDashboardScreenState();
}

class _OrderDashboardScreenState extends ConsumerState<OrderDashboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    int safeIndex = widget.initialIndex;
    if (safeIndex < 0 || safeIndex >= 4) {
      safeIndex = 0;
    }
    _tabController = TabController(
      length: 4,
      vsync: this,
      initialIndex: safeIndex,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final timerState = ref.watch(customTimerProvider);
    final timerController = ref.read(customTimerProvider.notifier);

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
                File(Base64Image.base64Image),
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
          controller: _tabController,
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

      body: TabBarView(
        controller: _tabController,
        children: [
          NewOrderDetailsScreen(),
          Center(child: Text("Assigned Orders")),
          Center(child: Text("Completed Orders")),
          Center(child: Text("Pending Invoices")),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SpotBillingScreen()),
          );
        },
        backgroundColor: AppColors.appPrimaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: const Icon(Icons.add, color: Colors.white, size: 35),
      ),
    );
  }
}
