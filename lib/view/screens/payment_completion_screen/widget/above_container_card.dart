import 'package:flutter/material.dart';

class AboveContainerCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const AboveContainerCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFF3B6D11), size: 22),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 10, color: Color(0xFF639922)),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xFF27500A),
            ),
          ),
        ],
      ),
    );
  }
}
