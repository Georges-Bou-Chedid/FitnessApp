import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class NutrientPage extends StatelessWidget {
  const NutrientPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.9),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PercentageProgressBar(label: 'Protein', percent: 30),
            PercentageProgressBar(label: 'Carbohydrates', percent: 60),
            PercentageProgressBar(label: 'Fiber', percent: 90),
            PercentageProgressBar(label: 'Sugar', percent: 90),
            PercentageProgressBar(label: 'Fat', percent: 90),
            PercentageProgressBar(label: 'Saturated Fat', percent: 90),
            PercentageProgressBar(label: 'Polyunsaturated Fat', percent: 90),
            PercentageProgressBar(label: 'Monounsaturated Fat', percent: 90),
            PercentageProgressBar(label: 'Trans Fat', percent: 90),
            PercentageProgressBar(label: 'Cholesterol', percent: 90),
            PercentageProgressBar(label: 'Sodium', percent: 90),
            PercentageProgressBar(label: 'Potassium', percent: 90),
            PercentageProgressBar(label: 'Vitamin A', percent: 90),
            PercentageProgressBar(label: 'Vitamin C', percent: 90),
            PercentageProgressBar(label: 'Calcium', percent: 90),
            PercentageProgressBar(label: 'Iron', percent: 90),
          ],
        ),
      ),
    );
  }
}

class PercentageProgressBar extends StatelessWidget {
  final String label;
  final int percent;

  PercentageProgressBar({required this.label, required this.percent});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label),
        const SizedBox(height: 5),
        LinearPercentIndicator(
          lineHeight: 15,
          percent: percent / 100,
          center: Text('$percent%'),
          progressColor: Colors.blue,
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
