import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CurrentCountWidget extends StatelessWidget {
  final int personCount;

  const CurrentCountWidget({super.key, required this.personCount});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1000.h,
      width: 500.w,
      child: Card(
        child: Center(
          // Cardの中の要素を中央に配置
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // 縦方向の中央揃え
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.person,
                  size: 100,
                ),
                SizedBox(height: 10.h),
                Text(
                  '現在のおおよその人数',
                  style: TextStyle(fontSize: 25.sp, color: Colors.grey[600]),
                ),
                Text(
                  '$personCount人',
                  style: TextStyle(
                    fontSize: 78.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
