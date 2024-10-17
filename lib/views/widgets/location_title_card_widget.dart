// lib/views/widgets/lab_status_card.dart
import 'package:flutter/material.dart';

class LocationTitleCard extends StatelessWidget {
  final String timestamp;

  const LocationTitleCard({super.key, required this.timestamp});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      height: 400,
      child: Card(
        child: Stack(
          children: [
            const Center(
              child: Text(
                '研究室 混雑具合',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 50),
              ),
            ),
            Positioned(
              right: 10,
              bottom: 10,
              child: Text(
                timestamp,
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
