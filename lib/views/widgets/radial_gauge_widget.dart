// lib/views/widgets/radial_gauge_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class RadialGaugeWidget extends StatelessWidget {
  final int personCount;

  const RadialGaugeWidget({super.key, required this.personCount});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 800.w,
      height: 1400.h,
      child: Card(
        child: SfRadialGauge(
          axes: [
            RadialAxis(
              minimum: 0,
              maximum: 4,
              ranges: [
                GaugeRange(
                  startValue: 0,
                  endValue: 1,
                  color: Colors.green,
                  startWidth: 20,
                  endWidth: 20,
                ),
                GaugeRange(
                  startValue: 1,
                  endValue: 2,
                  color: Colors.yellow,
                  startWidth: 20,
                  endWidth: 20,
                ),
                GaugeRange(
                  startValue: 2,
                  endValue: 3,
                  color: Colors.orange,
                  startWidth: 20,
                  endWidth: 20,
                ),
                GaugeRange(
                  startValue: 3,
                  endValue: 4,
                  color: Colors.red,
                  startWidth: 20,
                  endWidth: 20,
                ),
              ],
              pointers: [
                NeedlePointer(
                  value: personCount.toDouble(),
                  enableAnimation: true,
                ),
              ],
              annotations: [
                GaugeAnnotation(
                  positionFactor: 0.5,
                  angle: 90,
                  widget: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        countPerson(personCount),
                        style: TextStyle(
                          fontSize: 40.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String countPerson(int personCount) {
    if (personCount == 0) {
      return 'ガラ空き';
    } else if (personCount >= 1 && personCount < 2) {
      return '空いている';
    } else if (personCount >= 2 && personCount < 3) {
      return '普通';
    } else if (personCount >= 3 && personCount < 4) {
      return '少し混んでいる';
    } else if (personCount >= 4 && personCount < 5) {
      return '混んでいる';
    } else if (personCount >= 5) {
      return 'パーティー会場';
    } else {
      return '不明';
    }
  }
}
