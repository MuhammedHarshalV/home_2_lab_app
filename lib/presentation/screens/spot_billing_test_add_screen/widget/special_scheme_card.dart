import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icon_infoware/controller/add_test_screen_controller/add_test_screen_controller.dart';
import 'package:icon_infoware/controller/color_controller/color_controller.dart';
import 'package:icon_infoware/controller/home_screen_controller/home_screen_controller.dart';
import 'package:icon_infoware/core/themes/colors.dart';
import 'package:icon_infoware/models/spot_billing/done_by_search_response_model.dart';

class SpecialSchemeCard extends ConsumerWidget {
  final int? index;
  const SpecialSchemeCard({super.key, this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addTestState = ref.read(addTestScreenProvider);
    final addTestController = ref.read(addTestScreenProvider.notifier);
    final homeController = ref.read(homeScreenProvider.notifier);
    final homeState = ref.read(homeScreenProvider);
    final String specialSchemeName = index == null
        ? homeState.allBookingDetails.last.specialSchemeName ?? ''
        : homeState.allBookingDetails[index!].specialSchemeName ?? '';

    return DropdownButtonHideUnderline(
      child: DropdownButton2<AccountsList>(
        isExpanded: true,

        hint: Text(
          specialSchemeName.isEmpty
              ? 'Select Special Scheme'
              : specialSchemeName,

          style: TextStyle(fontSize: 14, color: AppColors.appBlack),
        ),

        items: addTestState.specialSchemeList.map((item) {
          return DropdownItem<AccountsList>(
            value: item,
            height: 40,
            child: Text(item.name ?? '', style: const TextStyle(fontSize: 14)),
          );
        }).toList(),

        onChanged: (value) async {
          if (value == null) return;

          // Selected value
          addTestState.specialSchemeController.text = value.name ?? '';

          final selectedSchemeId = value.schemeId ?? 0;

          final rateIdSelected = value.key ?? 0;

          if (selectedSchemeId == 0) {
            addTestController.updatestate(
              rateIDSelected: rateIdSelected,
              schemeIDSelected: 0,
            );
          } else {
            addTestController.updatestate(
              schemeIDSelected: selectedSchemeId,
              rateIDSelected: 0,
            );
          }
          // 3. Calculate new gross/net/balance
          await addTestController.updateNetBalanceAmounts();

          // 4. IMPORTANT: get the UPDATED state after calculation
          final updatedState = ref.read(addTestScreenProvider);

          // 5. Find which patient needs updating
          final patientIndex = index; // your existing index

          if (patientIndex == null) {
            // New/current patient
            final lastPatientIndex =
                homeState.allBookingDetails.last.indexClick ?? 0;

            await homeController.updatePatient(
              index: lastPatientIndex,

              rateIdSelected: selectedSchemeId == 0 ? rateIdSelected : 0,

              specialSchemeName: value.name ?? '',

              specialSchemeID: selectedSchemeId != 0 ? selectedSchemeId : 0,

              grossAmt: updatedState.totalPrice,
              netAmt: updatedState.netAmount,
              balance: updatedState.balanceAmount,
            );
          } else {
            // Existing patient
            await homeController.updatePatient(
              index: patientIndex,

              rateIdSelected: selectedSchemeId == 0 ? rateIdSelected : 0,

              specialSchemeName: value.name ?? '',

              specialSchemeID: selectedSchemeId != 0 ? selectedSchemeId : 0,

              grossAmt: updatedState.totalPrice,
              netAmt: updatedState.netAmount,
              balance: updatedState.balanceAmount,
            );
          }
        },

        buttonStyleData: ButtonStyleData(
          height: 45,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: ref.watch(colorProvider).primaryColor,
              width: 1.5,
            ),
          ),
        ),

        dropdownStyleData: DropdownStyleData(
          maxHeight: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.appWhite,
          ),
        ),

        dropdownSearchData: DropdownSearchData(
          // IMPORTANT: same controller as TextFormField
          searchController: addTestState.specialSchemeController,

          searchBarWidgetHeight: 50,

          searchBarWidget: Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
            child: TextFormField(
              controller: addTestState.specialSchemeController,

              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                hintText: 'Search special scheme...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: () {
                    addTestState.specialSchemeController.clear();
                  },
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppColors.appBlack),
                ),
              ),
            ),
          ),

          noResultsWidget: const Padding(
            padding: EdgeInsets.all(8),
            child: Text('No Special Scheme Found!'),
          ),

          searchMatchFn: (item, searchValue) {
            return (item.value?.name ?? '').toLowerCase().contains(
              searchValue.toLowerCase(),
            );
          },
        ),

        onMenuStateChange: (isOpen) {
          if (!isOpen) {
            //  addTestState.specialSchemeSearchController.clear();
          }
        },
      ),
    );
  }
}
