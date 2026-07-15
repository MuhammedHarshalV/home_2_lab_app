import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icon_infoware/controller/color_controller/color_controller.dart';
import 'package:icon_infoware/core/themes/colors.dart';
import 'package:shimmer/shimmer.dart';

class PatientDetailsListShimmer extends ConsumerWidget {
  final int itemCount;

  const PatientDetailsListShimmer({super.key, this.itemCount = 15});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorState = ref.watch(colorProvider);

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Shimmer.fromColors(
            baseColor: AppColors.appWhite,
            highlightColor: colorState.secondaryColor,
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                color: colorState.primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        );
      },
    );
  }
}

class PatientDetailsListShimmerRow extends ConsumerWidget {
  const PatientDetailsListShimmerRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorState = ref.watch(colorProvider);

    return Expanded(
      child: Shimmer.fromColors(
        baseColor: AppColors.appWhite,
        highlightColor: colorState.secondaryColor,
        child: Container(
          height: 95,
          decoration: BoxDecoration(
            color: colorState.primaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
