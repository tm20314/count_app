import 'package:flutter/material.dart';

class CurrentCountWidget extends StatelessWidget {
  final int personCount;

  const CurrentCountWidget({super.key, required this.personCount});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: 340,
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
                const SizedBox(height: 10),
                Text(
                  '現在のおおよその人数',
                  style: TextStyle(fontSize: 25, color: Colors.grey[600]),
                ),
                Text(
                  '$personCount人',
                  style: const TextStyle(
                    fontSize: 78,
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
