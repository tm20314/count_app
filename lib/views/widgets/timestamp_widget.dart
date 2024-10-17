// lib/views/widgets/timestamp_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimestampWidget extends StatelessWidget {
  final String timestamp;

  const TimestampWidget({super.key, required this.timestamp});

  @override
  Widget build(BuildContext context) {
    return Text(
      'タイムスタンプ: $timestamp',
      style: TextStyle(fontSize: 16.sh, color: Colors.grey[600]),
      textAlign: TextAlign.center,
    );
  }
}
