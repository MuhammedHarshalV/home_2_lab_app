import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:icon_infoware/core/constants/app_constance.dart';
import 'package:qr_flutter/qr_flutter.dart';

class BillFooterWidget extends ConsumerWidget {
  final Color darkBlue = const Color(0xFF163E61);

  final Widget? qrWidget;

  const BillFooterWidget({super.key, this.qrWidget});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Text(
          'User: ${AppConstance.userName.isNotEmpty ? AppConstance.userName[0].toUpperCase() + AppConstance.userName.substring(1) : ''}',
          style: const TextStyle(fontSize: 14),
        ),

        Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            //  shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade400, width: 2),
            color: Colors.white,
          ),
          child: QrImageView(
            data: AppConstance.qrUrl,
            version: QrVersions.auto,
            size: 120,
          ),
        ),

        const Text(
          'Thank you',
          style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
        ),

        const SizedBox(height: 4),

        Text(
          AppConstance.tagLine,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),

        const SizedBox(height: 15),

        Container(height: 15, color: darkBlue),
      ],
    );
  }
}
