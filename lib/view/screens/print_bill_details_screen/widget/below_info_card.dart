import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:icon_infoware/core/constants/app_constants.dart';
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
          'User: ${AppConstants.userName.isNotEmpty ? AppConstants.userName[0].toUpperCase() + AppConstants.userName.substring(1) : ''}',
          style: const TextStyle(fontSize: 20),
        ),

        Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            //  shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade400, width: 2),
            color: Colors.white,
          ),
          child: QrImageView(
            data: AppConstants.qrUrl,
            version: QrVersions.auto,
            size: 120,
          ),
        ),

        const Text(
          'Thank you',
          style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20),
        ),

        const SizedBox(height: 4),

        Text(
          AppConstants.tagLine,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),

        const SizedBox(height: 15),

        Container(height: 15, color: darkBlue),
      ],
    );
  }
}
