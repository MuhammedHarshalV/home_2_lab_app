import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icon_infoware/core/themes/colors.dart';
import 'package:icon_infoware/view/screens/oder_details_screen.dart';

class NewOrderDetailsScreen extends ConsumerWidget {
  const NewOrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        PatientOrderCard(
          name: "Aarav Mehta",
          testType: "CBC + Vitamin D",
          time: "10:30 AM",
          orderId: "#001",
          initials: "AM",
        ),
        PatientOrderCard(
          name: "Sneha Kapoor",
          testType: "Lipid Profile",
          time: "11:00 AM",
          orderId: "#002",
          initials: "SK",
        ),
        PatientOrderCard(
          name: "Rohit Verma",
          testType: "HbA1c",
          time: "11:45 AM",
          orderId: "#003",
          initials: "RV",
        ),
        PatientOrderCard(
          name: "Rohit Verma",
          testType: "HbA1c",
          time: "11:45 AM",
          orderId: "#003",
          initials: "RV",
        ),
        PatientOrderCard(
          name: "Rohit Verma",
          testType: "HbA1c",
          time: "11:45 AM",
          orderId: "#003",
          initials: "RV",
        ),
        PatientOrderCard(
          name: "Rohit Verma",
          testType: "HbA1c",
          time: "11:45 AM",
          orderId: "#003",
          initials: "RV",
        ),
      ],
    );
  }
}

class PatientOrderCard extends StatelessWidget {
  final String name;
  final String testType;
  final String time;
  final String orderId;
  final String initials;

  const PatientOrderCard({
    super.key,
    required this.name,
    required this.testType,
    required this.time,
    required this.orderId,
    required this.initials,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.appWhite,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.appPrimaryColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Initials Circle
          CircleAvatar(
            radius: 28,
            backgroundColor: const Color(0xFFFFEBEE), // Soft red background
            child: Text(
              initials,
              style: const TextStyle(
                color: Color(0xFFE53935), // Primary red
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Details Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      orderId,
                      style: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  testType,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 16,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          "Today  $time",
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    // New Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFEBEE),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        "New",
                        style: TextStyle(
                          color: Color(0xFFE53935),
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Icon(Icons.chevron_right, color: Colors.grey.shade300),
        ],
      ),
    );
  }
}
