import 'package:flutter/material.dart';

import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/constants/const.dart';

class BuildStatusCard extends StatelessWidget {
  const BuildStatusCard({super.key,
    required this.icon,
    required this.value,
    required this.label,
    this.pending= false,
  });

  final String value;
  final IconData icon;
  final String label;
  final bool pending;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFd0eacb),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: pending? Colors.red.shade300: mainColor,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: height * 0.08,
            width: width * 0.15,
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12),topLeft: Radius.circular(12)),
            ),
            child: Center(
              child: Icon(
                icon,
                color: Colors.green.shade600,
                size: 35,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
