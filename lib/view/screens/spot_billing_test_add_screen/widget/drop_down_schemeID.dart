import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icon_infoware/controller/add_test_screen_controller/add_test_screen_controller.dart';
import 'package:icon_infoware/core/themes/colors.dart';

Future<void> showCommonPopupDropdown({
  required BuildContext context,
  required WidgetRef ref,
  required Offset tapPosition,
  required Function(dynamic) onSelected,
}) async {
  final screenSize = MediaQuery.of(context).size;

  final state = ref.read(addTestScreenProvider);

  final selected = await showMenu<dynamic>(
    constraints: BoxConstraints(
      maxHeight: MediaQuery.of(context).size.height / 2,
    ),
    context: context,
    color: AppColors.appWhite,
    position: RelativeRect.fromLTRB(
      tapPosition.dx,
      tapPosition.dy,
      screenSize.width,
      screenSize.height - tapPosition.dy,
    ),
    items: state.specialSchemeList.map((item) {
      return PopupMenuItem(value: item, child: Text(item.name ?? ''));
    }).toList(),
  );

  if (selected != null) {
    onSelected(selected);
  }
}
