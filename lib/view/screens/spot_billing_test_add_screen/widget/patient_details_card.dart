import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icon_infoware/controller/add_test_screen_controller/add_test_screen_controller.dart';
import 'package:icon_infoware/core/themes/colors.dart';
import 'package:icon_infoware/models/spot_billing/done_by_search_response_model.dart';
import 'package:icon_infoware/view/widgets/common_tap_possition_dropDown.dart';

class PatientDetailsCard extends ConsumerWidget {
  const PatientDetailsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addTestController = ref.read(addTestScreenProvider.notifier);
    final addTestState = ref.watch(addTestScreenProvider);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.appPrimaryColor),
        // Soft gradient background matching the image
        gradient: const LinearGradient(
          colors: [
            AppColors.appPrimaryColorLight,
            Color.fromARGB(255, 255, 255, 255),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Top Row: Name and Icons ---
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Expanded(
                  child: Text(
                    'Mr. MUHAMMED HARSHAL',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1A2B4C), // Dark navy text
                      letterSpacing: 0.2,
                    ),
                  ),
                ),

                InkWell(
                  onTap: () {},
                  child: Icon(
                    Icons.phone_outlined,
                    color: const Color(0xFF1A2B4C),
                    size: 20,
                  ),
                ),
              ],
            ),

            // --- Details Section ---
            Row(
              children: [
                Text(
                  'Gender:',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF37474F), // Dark grey-blue
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  ' Male',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF37474F), // Dark grey-blue
                  ),
                ),
                Text('  |  '),
                Text(
                  'Age:',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF37474F), // Dark grey-blue
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  ' 20',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF37474F), // Dark grey-blue
                  ),
                ),
              ],
            ),

            /// const SizedBox(height: 4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Location:',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF37474F),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: Text(
                    ' Kochi Location (Kerala)hjgdkdjsaf sajfahsjh jkhjghsaj',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF37474F), // Dark grey-blue
                    ),
                  ),
                ),
              ],
            ),

            GestureDetector(
              onTap: () {
                // Handle edit profile action
              },
              child: const Text(
                'Edit Patient Info',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.blueAccent,
                ),
              ),
            ),

            // --- Divider ---
            Divider(
              color: Colors.black.withOpacity(0.06),
              thickness: 1.5,
              height: 1,
            ),
            const SizedBox(height: 5),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'Corporate billing:',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A2B4C),
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      onTap: () {
                        addTestController.updatestate(
                          isCorporateBilling: !addTestState.isCorporateBilling,
                        );
                      },
                      child: Icon(
                        addTestState.isCorporateBilling
                            ? Icons.check_box_outlined
                            : Icons.check_box_outline_blank,
                      ),
                    ),
                  ],
                ),
                addTestState.isCorporateBilling == true
                    ? Expanded(
                        child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                            color: AppColors.appPrimaryColorLight,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: DropdownMenu<AccountsList>(
                            width: MediaQuery.of(context).size.width / 2,
                            menuHeight: MediaQuery.of(context).size.height / 3,
                            menuStyle: MenuStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                const Color.fromARGB(
                                  255,
                                  230,
                                  227,
                                  227,
                                ), // dropdown background
                              ),
                              surfaceTintColor: WidgetStatePropertyAll(
                                Colors.transparent,
                              ),
                              shadowColor: WidgetStatePropertyAll(
                                Colors.transparent,
                              ),
                            ),

                            enableFilter: true,
                            requestFocusOnTap: true,
                            trailingIcon: SizedBox.shrink(),
                            selectedTrailingIcon: SizedBox.shrink(),
                            inputDecorationTheme: InputDecorationTheme(
                              isDense: true,
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                left: 5,
                                bottom: 25,
                              ),
                              hintStyle: TextStyle(fontSize: 12),
                            ),

                            hintText: 'Special Scheme',

                            textStyle: const TextStyle(fontSize: 12),

                            dropdownMenuEntries:
                                addTestState.specialSchemeList.isEmpty
                                ? [
                                    DropdownMenuEntry<AccountsList>(
                                      value: AccountsList(
                                        key: 0,
                                        name: "",
                                        type: "",
                                        schemeId: 0,
                                      ),
                                      label: "Items Not Found.",
                                      enabled: false,
                                      style: ButtonStyle(
                                        padding: WidgetStatePropertyAll(
                                          const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 0,
                                          ),
                                        ),
                                        backgroundColor:
                                            WidgetStateProperty.resolveWith((
                                              states,
                                            ) {
                                              return Colors
                                                  .transparent; // remove hover color
                                            }),

                                        overlayColor:
                                            WidgetStateProperty.resolveWith((
                                              states,
                                            ) {
                                              return Colors
                                                  .transparent; // remove ripple/hover effect
                                            }),
                                        textStyle: WidgetStatePropertyAll(
                                          TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                          ), // item text size
                                        ),
                                      ),
                                    ),
                                  ]
                                : addTestState.specialSchemeList
                                      .map(
                                        (
                                          item,
                                        ) => DropdownMenuEntry<AccountsList>(
                                          value: item,
                                          label: item.name ?? '',
                                          style: ButtonStyle(
                                            padding: WidgetStatePropertyAll(
                                              const EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 0,
                                              ),
                                            ),
                                            backgroundColor:
                                                WidgetStateProperty.resolveWith((
                                                  states,
                                                ) {
                                                  return Colors
                                                      .transparent; // remove hover color
                                                }),

                                            overlayColor:
                                                WidgetStateProperty.resolveWith((
                                                  states,
                                                ) {
                                                  return Colors
                                                      .transparent; // remove ripple/hover effect
                                                }),
                                            textStyle: WidgetStatePropertyAll(
                                              TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold,
                                              ), // item text size
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),

                            onSelected: (value) {
                              //  print(value);
                              log(value!.name.toString());
                              addTestController.updatestate(
                                schemeIDSelected: value.schemeId,
                              );
                              log(value.schemeId.toString());

                              // Riverpod update example
                              // addTestController.updateState(
                              //    selectedScheme: value
                              // );
                            },
                          ),
                        ),
                      )
                    // DropdownMenu<String>(
                    //     menuHeight: MediaQuery.of(context).size.height / 3,
                    //     enableFilter: true, // Key property for search
                    //     requestFocusOnTap: true,
                    //     //  label: const Text('Select Country'),
                    //     dropdownMenuEntries: <String>['USA', 'UK', 'Canada']
                    //         .map(
                    //           (label) =>
                    //               DropdownMenuEntry(value: label, label: label),
                    //         )
                    //         .toList(),
                    //     onSelected: (value) => print('Selected: $value'),
                    //   )
                    // SpecialSchemeDropDown(
                    //     items: corporateList,
                    //     onSelected: (p0) {},
                    //   )
                    // Expanded(
                    //     child: Container(
                    //       height: 30,
                    //       decoration: BoxDecoration(
                    //         color: AppColors.appPrimaryColorLight,
                    //         borderRadius: BorderRadius.circular(10),
                    //       ),
                    //       child: Center(
                    //         child: TextField(
                    //           onChanged: (value) {
                    //             CommonTapPossitionDropdown(
                    //               heading: '',
                    //               items: corporateList,
                    //               onSelected: (p0) {},
                    //             );
                    //           },
                    //           style: TextStyle(
                    //             fontSize: 12,
                    //             height: 1, // important
                    //           ),
                    //           textAlignVertical: TextAlignVertical.center,
                    //           decoration: InputDecoration(
                    //             isDense: true,
                    //             border: InputBorder.none,
                    //             hintText: 'Special Scheme',
                    //             hintStyle: TextStyle(fontSize: 12),
                    //             contentPadding: EdgeInsets.symmetric(
                    //               horizontal: 5,
                    //               vertical: 0,
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   )
                    : SizedBox(height: 30),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SpecialSchemeDropDown extends StatelessWidget {
  final List<String> items;
  final Function(String) onSelected;

  const SpecialSchemeDropDown({
    super.key,

    required this.items,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        onTapDown: (details) {
          _showMore(context, details.globalPosition);
        },
        child: Container(
          height: 30,
          decoration: BoxDecoration(
            color: AppColors.appPrimaryColorLight,
            borderRadius: BorderRadius.circular(10),
          ),

          child: Center(
            child: TextField(
              onChanged: (value) {},
              style: TextStyle(
                fontSize: 12,
                height: 1, // important
              ),
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: 'Special Scheme',
                hintStyle: TextStyle(fontSize: 12),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showMore(BuildContext context, Offset tapPosition) async {
    final screenSize = MediaQuery.of(context).size;

    final selected = await showMenu<String>(
      context: context,
      color: AppColors.appWhite,
      constraints: BoxConstraints(
        minWidth: screenSize.width / 2,
        maxHeight: screenSize.height / 3,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      position: RelativeRect.fromLTRB(
        tapPosition.dx + 50, // move 50px to right
        tapPosition.dy + 10, // 10px below
        0,
        screenSize.height - (tapPosition.dy + 10),
      ),
      items: items
          .map(
            (item) => PopupMenuItem<String>(
              value: item,
              child: Align(alignment: Alignment.centerLeft, child: Text(item)),
            ),
          )
          .toList(),
    );

    if (selected != null) {
      onSelected(selected); // callback
    }
  }
}
