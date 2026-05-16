import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icon_infoware/core/themes/colors.dart';
import 'package:icon_infoware/models/spot_billing/search_patient_response_model.dart';

class TypeContainer extends StatelessWidget {
  final String hintText;
  final TextEditingController textController;
  final bool isNumbers;
  final VoidCallback? onSearchTap;
  final List<String> items;
  const TypeContainer({
    super.key,
    required this.hintText,
    required this.textController,
    this.isNumbers = false,
    this.onSearchTap,
    this.items = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.appPrimaryColorLight,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              /// 🔹 TEXT FIELD
              Expanded(
                child: TextField(
                  // onChanged:(textController) {
                    
                  // },
                  controller: textController,
                  keyboardType: isNumbers
                      ? TextInputType.number
                      : TextInputType.text,
                  inputFormatters: isNumbers
                      ? [FilteringTextInputFormatter.digitsOnly]
                      : null,
                  decoration: const InputDecoration(
                    hintText: "Search Patients",
                    border: InputBorder.none,
                  ),
                ),
              ),

              /// 🔹 SEARCH ICON
              GestureDetector(
                onTap: onSearchTap,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.appPrimaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.search, color: AppColors.appWhite),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showMore(BuildContext context, Offset tapPosition) async {
    final screenSize = MediaQuery.of(context).size;

    final selected = await showMenu<String>(
      context: context,
      color: AppColors.appWhite,
      constraints: BoxConstraints(
        minWidth: screenSize.width,
        maxHeight: screenSize.height / 2,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      position: RelativeRect.fromLTRB(
        0, // full width
        tapPosition.dy,
        0,
        screenSize.height - tapPosition.dy,
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

    // if (selected != null) {
    //   onSelected(selected); // callback
    // }
  }
}
