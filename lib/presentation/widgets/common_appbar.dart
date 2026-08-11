import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:icon_infoware/controller/color_controller/color_controller.dart';
import 'package:icon_infoware/core/constants/app_constants.dart';

class CommonAppbar extends ConsumerWidget implements PreferredSizeWidget {
  final String? title;
  final bool showBackButton;
  final VoidCallback? onBack;
  final double height;
  final bool shape;

  const CommonAppbar({
    super.key,
    this.title,
    this.shape = false,
    this.showBackButton = true,
    this.onBack,
    this.height = 100,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorState = ref.watch(colorProvider);
    return AppBar(
      toolbarHeight: height,
      automaticallyImplyLeading: false,
      backgroundColor: colorState.appbarColor,
      elevation: 0,
      scrolledUnderElevation: 0,

      leading: showBackButton
          ? Padding(
              padding: const EdgeInsets.only(left: 10),
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: onBack ?? () => context.pop(),
                child: CircleAvatar(
                  backgroundColor: colorState.primaryColor.withValues(
                    alpha: 0.2,
                  ),
                  child: Icon(Icons.arrow_back, color: colorState.primaryColor),
                ),
              ),
            )
          : null,

      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 0.0),
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
      shape: shape == true
          ? const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
            )
          : null,
      centerTitle: true,
    );
  }
}
