import 'package:flutter/material.dart';
import 'package:icon_infoware/models/help_support_response/help_support_response_model.dart';

class InformationCard extends StatelessWidget {
  final Information information;
  final int count;

  const InformationCard({
    super.key,
    required this.information,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if ((information.type ?? '').isNotEmpty)
          Text(
            "$count. ${information.type ?? ''}",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        if ((information.message ?? '').isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 4),
            child: Text(information.message!),
          ),
      ],
    );
  }
}
