import 'package:flutter/material.dart';
import 'package:icon_infoware/core/themes/colors.dart';
import 'package:shimmer/shimmer.dart';

class PatientDetailsListShimmer extends StatelessWidget {
  final int itemCount;

  const PatientDetailsListShimmer({super.key, this.itemCount = 15});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Shimmer.fromColors(
            baseColor: AppColors.appWhite,
            highlightColor: const Color.fromARGB(255, 187, 245, 189),
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.appPrimaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        );
      },
    );
  }
}

class PatientDetailsListShimmerRow extends StatelessWidget {
  const PatientDetailsListShimmerRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Shimmer.fromColors(
        baseColor: AppColors.appWhite,
        highlightColor: const Color.fromARGB(255, 187, 245, 189),
        child: Container(
          height: 95,
          decoration: BoxDecoration(
            color: AppColors.appPrimaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
