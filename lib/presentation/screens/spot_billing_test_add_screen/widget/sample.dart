import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:icon_infoware/controller/add_test_screen_controller/add_test_screen_controller.dart';
import 'package:icon_infoware/controller/color_controller/color_controller.dart';
import 'package:icon_infoware/controller/home_screen_controller/home_screen_controller.dart';
import 'package:icon_infoware/core/themes/colors.dart';
import 'package:icon_infoware/models/spot_billing/test_add_selection.dart';

// ============================================================
// DATA MODEL
// ============================================================

class LabTest {
  final String id;
  final String name;
  final String? tag;
  final String specimen;
  final Color specimenColor;
  final String? details;
  final double price;
  final double? oldPrice;

  bool isSelected;

  LabTest({
    required this.id,
    required this.name,
    this.tag,
    required this.specimen,
    required this.specimenColor,
    this.details,
    required this.price,
    this.oldPrice,
    this.isSelected = false,
  });
}

class AddNewTestSheet extends ConsumerWidget {
  final int index;
  const AddNewTestSheet({super.key, required this.index});

  static const Color textDark = Color(0xFF0F172A);
  static const Color textMuted = Color(0xFF64748B);
  static const Color borderColor = Color(0xFFE2E8F0);

  static void show(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useSafeArea: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: AddNewTestSheet(index: index),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final testAddState = ref.watch(addTestScreenProvider);

    final testAddController = ref.read(addTestScreenProvider.notifier);

    final textController = testAddState.searchController;

    final tests = testAddState.testMasterListSeeing;
    final colorState = ref.watch(colorProvider);

    final selectedCount = tests
        .where((test) => test.testSelected == true)
        .length;

    final totalAdditional = tests
        .where((test) => test.testSelected == true)
        .fold<double>(0, (sum, test) => sum + (test.testRate ?? 0));

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) return;
        final updatedPatient = ref
            .read(homeScreenProvider)
            .allBookingDetails
            .firstWhere((e) => e.indexClick == index);
        testAddState.searchController.clear();
        await testAddController.getTestsFromHive(updatedPatient);
      },
      child: DraggableScrollableSheet(
        initialChildSize: 0.75,
        minChildSize: 0.60,
        maxChildSize: 0.80,
        expand: false,
        builder: (context, scrollController) {
          return Material(
            color: Colors.transparent,
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: AppColors.appWhite,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                children: [
                  // ============================
                  // HANDLE
                  // ============================
                  const SizedBox(height: 12),

                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFFCBD5E1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ============================
                  // HEADER
                  // ============================
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Add New Test',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: AppColors.appBlack,
                            ),
                          ),
                        ),

                        Material(
                          color: const Color(0xFFF1F5F9),
                          shape: const CircleBorder(),
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            customBorder: const CircleBorder(),
                            child: const Padding(
                              padding: EdgeInsets.all(8),
                              child: Icon(
                                Icons.close,
                                size: 18,
                                color: textDark,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),
                  if (testAddState.testMasterListSelected.isNotEmpty)
                    SizedBox(
                      height: 32,
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        scrollDirection: Axis.horizontal,
                        itemCount: testAddState.testMasterListSelected.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 8),
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.only(
                              left: 16,
                              top: 6,
                              bottom: 6,
                            ),
                            decoration: BoxDecoration(
                              color: colorState.primaryColor,

                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  testAddState
                                          .testMasterListSelected[index]
                                          .testName ??
                                      '',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  onTap: () {
                                    testAddController.removeTestsToTemperary(
                                      test: testAddState
                                          .testMasterListSelected[index],
                                    );
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: AppColors.appWhite,
                                    child: Center(
                                      child: Icon(Icons.close, size: 15),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  if (testAddState.testMasterListSelected.isNotEmpty)
                    const SizedBox(height: 10),
                  // ============================
                  // SEARCH
                  // ============================
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.borderColor),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 12),

                          const Icon(Icons.search, size: 20, color: textMuted),

                          const SizedBox(width: 8),

                          Expanded(
                            child: TextField(
                              controller: textController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                hintText: 'Search by test name...',
                                hintStyle: TextStyle(
                                  fontSize: 13,
                                  color: textMuted,
                                ),
                                border: InputBorder.none,
                              ),
                              onChanged: (value) {
                                if (value.isEmpty) {
                                  final newSearchList =
                                      testAddState.testMasterList;

                                  final List<TestMasterSelected> selectedList =
                                      newSearchList.map((item) {
                                        final isSelected = testAddState
                                            .testMasterListSelected
                                            .any(
                                              (selected) =>
                                                  selected.testName ==
                                                  item.testName,
                                            );

                                        return TestMasterSelected(
                                          testKey: item.testKey,
                                          testRate: item.testRate,
                                          testShortCode: item.testShortCode,
                                          testName: item.testName,
                                          testSelected: isSelected,
                                        );
                                      }).toList();

                                  testAddController.searchTestMaster(
                                    selectedList,
                                  );
                                }

                                final search = value.toLowerCase();

                                final newSearchList = testAddState
                                    .testMasterList
                                    .where(
                                      (item) => (item.testName ?? '')
                                          .toLowerCase()
                                          .contains(search),
                                    )
                                    .toList();
                                final List<TestMasterSelected> selectedList =
                                    newSearchList.map((item) {
                                      final isSelected = testAddState
                                          .testMasterListSelected
                                          .any(
                                            (selected) =>
                                                selected.testName ==
                                                item.testName,
                                          );

                                      return TestMasterSelected(
                                        testKey: item.testKey,
                                        testRate: item.testRate,
                                        testShortCode: item.testShortCode,
                                        testName: item.testName,
                                        testSelected: isSelected,
                                      );
                                    }).toList();

                                testAddController.searchTestMaster(
                                  selectedList,
                                );

                                log("Found : ${newSearchList.length}");
                              },
                            ),
                          ),

                          InkWell(
                            onTap: () {
                              textController.clear();
                              final newSearchList = testAddState.testMasterList;
                              final List<TestMasterSelected> selectedList =
                                  newSearchList.map((item) {
                                    final isSelected = testAddState
                                        .testMasterListSelected
                                        .any(
                                          (selected) =>
                                              selected.testName ==
                                              item.testName,
                                        );
                                    return TestMasterSelected(
                                      testKey: item.testKey,
                                      testRate: item.testRate,
                                      testShortCode: item.testShortCode,
                                      testName: item.testName,
                                      testSelected: isSelected,
                                    );
                                  }).toList();

                              testAddController.searchTestMaster(selectedList);

                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(10),
                              child: Icon(
                                Icons.close,
                                size: 18,
                                color: textMuted,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ============================
                  // TEST LIST
                  // ============================
                  testAddState.testMasterListSeeing.isEmpty
                      ? Center(child: Text('No Test\'s found.'))
                      : Expanded(
                          child: ListView.separated(
                            controller: scrollController,
                            keyboardDismissBehavior:
                                ScrollViewKeyboardDismissBehavior.onDrag,
                            padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                            itemCount: tests.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final test = tests[index];

                              return _buildTestCard(
                                primaryColor: colorState.primaryColor,
                                test: test,
                                onTap: () {
                                  if (testAddState
                                          .testMasterListSeeing[index]
                                          .testSelected ==
                                      false) {
                                    testAddController.addTestsToTemperary(
                                      test: testAddState
                                          .testMasterListSeeing[index],
                                    );
                                  } else {
                                    testAddController.removeTestsToTemperary(
                                      test: testAddState
                                          .testMasterListSeeing[index],
                                    );
                                  }
                                },
                              );
                            },
                          ),
                        ),

                  // ============================
                  // BOTTOM BAR
                  // ============================
                  _buildBottomBar(
                    context: context,
                    selectedCount: selectedCount,
                    totalAdditional: totalAdditional,
                    ref: ref,
                    index: index,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ============================================================
  // TOGGLE TEST
  // ============================================================

  // ============================================================
  // TEST CARD
  // ============================================================

  Widget _buildTestCard({
    required TestMasterSelected test,
    required VoidCallback onTap,
    required Color primaryColor,
  }) {
    final bool selected = test.testSelected;

    final double price = (test.testRate ?? 0).toDouble();

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected ? primaryColor : borderColor,
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CHECKBOX
              Container(
                margin: const EdgeInsets.only(top: 2, right: 12),
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: selected ? primaryColor : Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: selected ? primaryColor : const Color(0xFFCBD5E1),
                  ),
                ),
                child: selected
                    ? const Icon(Icons.check, size: 14, color: Colors.white)
                    : null,
              ),

              // TEST DETAILS
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      test.testName ?? '',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: textDark,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // PRICE
              Text(
                '₹ ${price.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: textDark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // BOTTOM BAR
  // ============================================================

  //bottom bar
  Widget _buildBottomBar({
    required BuildContext context,
    required WidgetRef ref,
    required int selectedCount,
    required double totalAdditional,
    required int index,
  }) {
    // Get current states/controllers
    final colorState = ref.watch(colorProvider);

    final testMasterState = ref.watch(addTestScreenProvider);

    final testMasterController = ref.read(addTestScreenProvider.notifier);

    final homeController = ref.read(homeScreenProvider.notifier);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.borderColor)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ============================================
          // SELECTED COUNT + TOTAL
          // ============================================
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  //  color: colorState.secondaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$selectedCount Selected',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: colorState.primaryColor,
                  ),
                ),
              ),

              const Spacer(),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Est. Additional',
                    style: TextStyle(
                      fontSize: 10,
                      color: const Color.fromARGB(255, 65, 63, 63),
                    ),
                  ),

                  const SizedBox(height: 2),

                  Text(
                    '₹ ${totalAdditional.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: AppColors.appBlack,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),

          // ============================================
          // BUTTONS
          // ============================================
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () async {
                    context.pop();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: colorState.secondaryColor.withValues(
                      alpha: 0.5,
                    ),
                    foregroundColor: colorState.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    final uniqueIds = <dynamic>{};

                    final testList = testMasterState.testMasterListSelected
                        .where((e) => uniqueIds.add(e.testKey))
                        .map((e) => {'TestId': e.testKey})
                        .toList();
                    log(
                      'selected lists : ${testList.toString()} \n length : ${testList.length}',
                    );

                    testMasterController.updatestate(
                      testMasterListSelectedNewPrice:
                          testMasterState.testMasterListSelected,
                    );

                    await testMasterController.updateNetBalanceAmounts();
                    final testMasterState1 = ref.watch(addTestScreenProvider);
                    await homeController.updatePatient(
                      index: index,
                      testlists: testList,
                      discAmt:
                          num.tryParse(
                            testMasterState1.discountAmountController.text,
                          ) ??
                          0,
                      balance: testMasterState1.balanceAmount,
                      netAmt: testMasterState1.netAmount,
                      paidAmt: testMasterState1.amountPaid,
                      grossAmt: testMasterState1.totalPrice,
                      servChrge:
                          num.tryParse(
                            testMasterState1.servicesnargeController.text,
                          ) ??
                          0,
                      flag: '0',
                    );

                    if (context.mounted) {
                      context.pop();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorState.primaryColor,
                    foregroundColor: AppColors.appWhite,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Add Test",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
