import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CaloriePieChart extends StatelessWidget {
  final double totalCalories;
  final double consumedCalories;

  const CaloriePieChart({Key? key, required this.totalCalories, required this.consumedCalories})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(
              color: Colors.cyan,
              value: consumedCalories,
              title: "${consumedCalories.toStringAsFixed(0)}",
            ),
            PieChartSectionData(
              color: Colors.grey[400],
              value: (totalCalories - consumedCalories),
              title: "${(totalCalories - consumedCalories).toStringAsFixed(0)}",
            ),
          ],
        ),
      swapAnimationCurve: Curves.easeInOutQuint,
      swapAnimationDuration: const Duration(milliseconds: 2000),
    );
  }
}
