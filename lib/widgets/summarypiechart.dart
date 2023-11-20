import 'package:fitnessapp/widgets/summarydatepicker.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SummaryPieChart extends StatelessWidget {
  const SummaryPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        title: const Text(
          "Calories Pie Chart",
          style: TextStyle(
            fontFamily: "Inter",
            fontSize: 15,
            fontWeight: FontWeight.w500
          ),
        ),
        content: SizedBox(
          width: 380,
          height: 360,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SummaryDatePicker(),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: 8,
                        height: 8,
                        color: Colors.yellow[800],
                      ),
                      const SizedBox(width: 3), // Add some spacing between the square and label
                      const Text(
                        'Breakfast',
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 13
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 8,
                        height: 8,
                        color: Colors.blue[900],
                      ),
                      const SizedBox(width: 3),
                      const Text(
                        'Lunch',
                        style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 13
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 8,
                        height: 8,
                        color: Colors.red[800],
                      ),
                      const SizedBox(width: 3),
                      const Text(
                        'Dinner',
                        style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 13
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 8,
                        height: 8,
                        color: Colors.brown[600],
                      ),
                      const SizedBox(width: 3),
                      const Text(
                        'Snacks',
                        style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 13
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 15.0,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle, // Makes the container circular
                        color: Colors.black, // Set the color to black
                      ),
                    ),
                    const SizedBox(width: 3),
                    const Text(
                      'Total (B + L + D + S) / Goal',
                      style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 13
                      ),
                    ),
                  ]
              ),
              AspectRatio(
                aspectRatio: 1.25, // Adjust the aspect ratio as needed
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Center(
                      child: RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: "117 / 2500\n",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                            TextSpan(
                              text: 'Kcal', // Replace with your variable
                              style: TextStyle(
                                color: Colors.white54,
                                fontFamily: "Inter",
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    PieChart(
                      PieChartData(
                          sections: [
                            PieChartSectionData(
                                color: Colors.yellow[800], // breakfast
                                value: 55,
                                title: "${55.toStringAsFixed(0)}\n(8%)",
                                titleStyle: const TextStyle(
                                    fontFamily: "Inter",
                                    fontSize: 13
                                ),
                                radius: 35
                            ),
                            PieChartSectionData(
                                color: Colors.blue[900], // lunch
                                value: 30,
                                title: "${30.toStringAsFixed(0)}\n(5%)",
                                titleStyle: const TextStyle(
                                    fontFamily: "Inter",
                                    fontSize: 13
                                ),
                                radius: 35
                            ),
                            PieChartSectionData(
                                color: Colors.red[800], // dinner
                                value: 22,
                                title: "${22.toStringAsFixed(0)}\n(3%)",
                                titleStyle: const TextStyle(
                                    fontFamily: "Inter",
                                    fontSize: 13
                                ),
                                radius: 35
                            ),
                            PieChartSectionData(
                                color: Colors.brown[600], // snacks
                                value: 10,
                                title: "${10.toStringAsFixed(0)}\n(2%)",
                                titleStyle: const TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: 13
                                ),
                                radius: 35
                            ),
                          ],
                          centerSpaceRadius: 55,
                          sectionsSpace: 1
                      ),
                      swapAnimationCurve: Curves.easeInOutQuint,
                      swapAnimationDuration: const Duration(milliseconds: 2000),
                    ),
                  ],
                ),
              ),
            ]
          )
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text(
            'Close',
            style: TextStyle(
              fontFamily: "Inter",
              color: Color(0xFF5AC8FA)
            ),
          ),
        ),
      ],
    );
  }
}