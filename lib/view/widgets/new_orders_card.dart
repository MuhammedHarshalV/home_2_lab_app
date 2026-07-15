import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:icon_infoware/core/themes/colors.dart';
// Import your provider file here

class NewOrdersStatCard extends ConsumerWidget {
  final IconData icon;
  final String category;
  final String count;
  final String belowCategory;
  final Color color;
  const NewOrdersStatCard({
    super.key,
    required this.icon,
    required this.category,
    required this.count,
    required this.belowCategory,
    this.color = AppColors.appRed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watching the state to get the patient count or search status
    // final billingState = ref.watch(patientBillingProvider);

    return Container(
      // width: 160, // Fixed width to match the grid look
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              SizedBox(width: 5),
              // Flexible must be here (direct child of Row)
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: color.withOpacity(.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    category,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis, // prevents overflow
                    style: TextStyle(
                      color: color,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          //const SizedBox(height: 10),
          // Large Count Text
          Row(
            children: [
              Text(
                count, // You can replace this with billingState.someCount
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Spacer(),
              Text(
                belowCategory,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              //Spacer(),
              Icon(Icons.arrow_outward_rounded, color: color),
            ],
          ),
          const SizedBox(height: 4),
          // Label Text
          // Row(
          //   children: [
          //     Text(
          //       belowCategory,
          //       style: TextStyle(
          //         color: Colors.grey.shade600,
          //         fontSize: 14,
          //         fontWeight: FontWeight.w500,
          //       ),
          //     ),
          //     Spacer(),
          //     Icon(Icons.arrow_outward_rounded, color:colorState.primaryColor),
          //   ],
          // ),
        ],
      ),
    );
  }
}
