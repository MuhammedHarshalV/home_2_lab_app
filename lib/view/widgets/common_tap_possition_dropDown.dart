import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icon_infoware/controller/color_controller/color_controller.dart';
import 'package:icon_infoware/core/themes/colors.dart';

class CommonTapPossitionDropdown extends ConsumerWidget {
  final String heading;
  final List<String> items;
  final Function(String) onSelected;

  const CommonTapPossitionDropdown({
    super.key,
    required this.heading,
    required this.items,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorState = ref.watch(colorProvider);

    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      onTapDown: (details) {
        _showMore(context, details.globalPosition);
      },
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: colorState.secondaryColor,
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(heading, style: TextStyle(color: AppColors.appBlack)),
            ),
            const Spacer(),
            Icon(Icons.arrow_drop_down, color: AppColors.appBlack),
          ],
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
        minWidth: screenSize.width / 7.5,
        maxHeight: screenSize.height / 2,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      position: RelativeRect.fromLTRB(
        screenSize.width, // left
        tapPosition.dy, // top
        screenSize.width, // right
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

    if (selected != null) {
      onSelected(selected); // callback
    }
  }
}
