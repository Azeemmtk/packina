import 'package:flutter/material.dart';

class AvailableRoomWidget extends StatelessWidget {
  final String type;
  final int count;
  final double rate;

  const AvailableRoomWidget({
    super.key,
    required this.type,
    required this.count,
    required this.rate,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          type,
          style: const TextStyle(fontSize: 17),
        ),
        Text(
          'Available: $count',
          style: const TextStyle(fontSize: 17),
        ),
        Text(
          '₹: ${rate.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 17),
        ),
      ],
    );
  }
}