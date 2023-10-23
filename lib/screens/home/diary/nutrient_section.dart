import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../widgets/datepicker.dart';
import '../../../widgets/dropdown.dart';

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
            const SizedBox(
              height: 10.0,
            ),
            const DatePicker(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                const Divider(
                  color: Colors.grey, // Set the color of the line
                  height: 20, // Set the height (thickness) of the line
                  thickness: 2, // Set the thickness of the line
                ),
                const SizedBox(height: 5),
                CustomDropdown(
                  items: const ['All', 'Breakfast', 'Lunch', 'Dinner'],
                ),
                const SizedBox(height: 5),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "Total",
                        style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                PercentageProgressBar(label: 'Calories', percent: 50, goal: 2500, gained: 1250),
                PercentageProgressBar(label: 'Protein', percent: 30, goal: 100, gained: 30),
                PercentageProgressBar(label: 'Carbohydrates', percent: 60, goal: 100, gained: 60),
                PercentageProgressBar(label: 'Fiber', percent: 90, goal: 100, gained: 90),
                PercentageProgressBar(label: 'Sugar', percent: 90, goal: 100, gained: 90),
                PercentageProgressBar(label: 'Fat', percent: 90, goal: 100, gained: 90),
                PercentageProgressBar(label: 'Saturated Fat', percent: 90, goal: 100, gained: 90),
                PercentageProgressBar(label: 'Polyunsaturated Fat', percent: 90, goal: 100, gained: 90),
                PercentageProgressBar(label: 'Monounsaturated Fat', percent: 90, goal: 100, gained: 90),
                PercentageProgressBar(label: 'Trans Fat', percent: 90, goal: 100, gained: 90),
                PercentageProgressBar(label: 'Cholesterol', percent: 90, goal: 100, gained: 90),
                PercentageProgressBar(label: 'Sodium', percent: 90, goal: 100, gained: 90),
                PercentageProgressBar(label: 'Potassium', percent: 90, goal: 100, gained: 90),
                PercentageProgressBar(label: 'Vitamin A', percent: 90, goal: 100, gained: 90),
                PercentageProgressBar(label: 'Vitamin C', percent: 90, goal: 100, gained: 90),
                PercentageProgressBar(label: 'Calcium', percent: 90, goal: 100, gained: 90),
                PercentageProgressBar(label: 'Iron', percent: 90, goal: 100, gained: 90),
              ],
            )
          )
        ],
      ),
    ),
  );
  }
}

class PercentageProgressBar extends StatelessWidget {
  final String label;
  final int goal;
  final int gained;
  final int percent;

  PercentageProgressBar({super.key, required this.label, required this.percent, required this.goal, required this.gained});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(label),
                Text("${gained.toStringAsFixed(0)}/${goal.toStringAsFixed(0)}g")
              ],
            ),
        ),
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
