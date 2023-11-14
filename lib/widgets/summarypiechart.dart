import 'package:fitnessapp/widgets/summarydatepicker.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SummaryPieChart extends StatelessWidget {
  const SummaryPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor:  Colors.grey[300]!,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        title: const Text(
          "Calories Pie Chart",
          style: TextStyle(
            fontFamily: "Inter",
            fontSize: 17,
            fontWeight: FontWeight.w600
          ),
        ),
        content: SizedBox(
          width: 380,
          height: 400,
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
                          fontSize: 12.8,
                          color: Colors.black
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
                            fontSize: 12.8,
                            color: Colors.black
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
                            fontSize: 12.8,
                            color: Colors.black
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
                            fontSize: 12.8,
                            color: Colors.black
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
                          fontSize: 12.8,
                          color: Colors.black
                      ),
                    ),
                  ]
              ),
              const SizedBox(
                height: 15.0,
              ),
              AspectRatio(
                aspectRatio: 1.1, // Adjust the aspect ratio as needed
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Text(
                      '117/2500',
                      style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    PieChart(
                      PieChartData(
                          sections: [
                            PieChartSectionData(
                                color: Colors.yellow[800], // breakfast
                                value: 55,
                                title: 55.toStringAsFixed(0)
                            ),
                            PieChartSectionData(
                                color: Colors.blue[900], // lunch
                                value: 30,
                                title: 30.toStringAsFixed(0)
                            ),
                            PieChartSectionData(
                                color: Colors.red[800], // dinner
                                value: 22,
                                title: 22.toStringAsFixed(0)
                            ),
                            PieChartSectionData(
                                color: Colors.brown[600], // snacks
                                value: 10,
                                title: 10.toStringAsFixed(0)
                            ),
                          ],
                          centerSpaceRadius: 40,
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
          child: Text(
            'Close',
            style: TextStyle(
              fontFamily: "Inter",
              color: Colors.blue[800], // Set your desired text color
            ),
          ),
        ),
      ],
    );
  }
}