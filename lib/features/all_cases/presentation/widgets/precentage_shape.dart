import 'dart:ffi';

import 'package:find_me_app/core/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

// class BalanceIndicator extends StatelessWidget {
//   final double similarityScore;
//   final double radius;
//   final String? desText;
//   final String available;

//   BalanceIndicator({
//     required this.similarityScore,
//     required this.radius,
//     this.desText,
//     required this.available,
//   });
//   @override
//   Widget build(BuildContext context) {
//     return CircularPercentIndicator(
//       radius: radius,
//       lineWidth: 5,
//       percent: (similarityScore * 100).round() / 100.0,
//       animation: true,
//       circularStrokeCap: CircularStrokeCap.round,
//       progressColor: Colors.lightBlueAccent,
//       backgroundColor: Colors.grey.shade800,
//       center: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.visibility, color: Colors.grey.shade300),
//           const SizedBox(height: 5),
//           Text(
//             desText ?? "",
//             style: TextStyle(
//               fontSize: 14,
//               color: Colors.black,
//             ),
//           ),
//           const SizedBox(height: 5),
//           Text(
//             "$similarityScore",
//             style: const TextStyle(
//               fontSize: 20,
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// double Total = 7000;
class BalanceIndicator extends StatelessWidget {
  final double similarityScore; // بين 0.0 و 1.0
  final double radius;
  final String? desText;
  final String available;

  const BalanceIndicator({
    super.key,
    required this.similarityScore,
    required this.radius,
    this.desText,
    required this.available,
  });

  @override
  Widget build(BuildContext context) {
    final percent = similarityScore.clamp(0.0, 1.0);
    final displayPercent = (percent * 100).round();

    return CircularPercentIndicator(
      radius: radius,
      lineWidth: 4,
      percent: percent,
      animation: true,
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: AppColors.mainColor,
      backgroundColor: Colors.grey.shade300,
      center: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$displayPercent%",
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Text(
            "match",
            style: TextStyle(fontSize: 9, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
