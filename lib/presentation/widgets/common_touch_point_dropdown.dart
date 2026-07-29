import 'package:flutter/material.dart';

import 'package:icon_infoware/core/themes/colors.dart';

Future<void> commonTouchPointDropdown<T>({
  required BuildContext context,

  required Offset tapPosition,
  required List<dynamic> items,
  required String Function(dynamic item) itemText,
  required Function(dynamic value) onSelected,
}) async {
  final screenSize = MediaQuery.of(context).size;

  final selected = await showMenu<T>(
    context: context,
    color: AppColors.appWhite,
    constraints: BoxConstraints(maxHeight: screenSize.height / 2),
    position: RelativeRect.fromLTRB(
      tapPosition.dx,
      tapPosition.dy,
      screenSize.width,
      screenSize.height - tapPosition.dy,
    ),
    items: items.map((item) {
      return PopupMenuItem<T>(value: item, child: Text(itemText(item)));
    }).toList(),
  );

  if (selected != null) {
    onSelected(selected);
  }
}
