// lib/views/widgets/lab_status_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LocationTitleCard extends StatelessWidget {
  final String timestamp;

  const LocationTitleCard({super.key, required this.timestamp});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1000.h,
      width: 800.w,
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
