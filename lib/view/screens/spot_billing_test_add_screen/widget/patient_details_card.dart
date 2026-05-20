import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icon_infoware/core/themes/colors.dart';

class PatientDetailsCard extends ConsumerWidget {
  const PatientDetailsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                      onTap: () {},
                      child: Icon(
                        true
                            ? Icons.check_box_outlined
                            : Icons.check_box_outline_blank,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                      color: AppColors.appPrimaryColorLight,
                      borderRadius: BorderRadius.circular(10),
                    ),

                    child: Center(
                      child: TextField(
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
