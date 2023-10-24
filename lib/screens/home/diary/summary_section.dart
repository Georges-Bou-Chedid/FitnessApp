import 'package:flutter/material.dart';
import '../../../widgets/datepicker.dart';
import '../../../widgets/summarypiechart.dart';

class SummaryPage extends StatelessWidget {
  const SummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.9),
      child: SingleChildScrollView(
        child: Column(
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
                const SizedBox(
                  height: 5.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          width: 10,
                          height: 10,
                          color: Colors.yellow[800],
                        ),
                        const SizedBox(width: 8), // Add some spacing between the square and label
                        const Text(
                          'Breakfast',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 10,
                          height: 10,
                          color: Colors.blue[900],
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Lunch',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 10,
                          height: 10,
                          color: Colors.red[800],
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Dinner',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 10,
                          height: 10,
                          color: Colors.brown[600],
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Snacks',
                          style: TextStyle(color: Colors.black),
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
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle, // Makes the container circular
                          color: Colors.black, // Set the color to black
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Total (Breakfast + Lunch + Dinner + Snacks) / Goal',
                        style: TextStyle(color: Colors.black),
                      ),
                    ]
                ),
                const SizedBox(
                  height: 30.0,
                ),





                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Calories'
                    ),
                    Text(
                      'Protein'
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                 const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 1.1, // Adjust the aspect ratio as needed
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Text(
                              '117/2500',
                              style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            SummaryPieChart()
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 1.1, // Adjust the aspect ratio as needed
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Text(
                              '117/150g',
                              style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            SummaryPieChart()
                          ],
                        ),
                      ),
                    ),
                  ],
                ),






                const SizedBox(
                  height: 10.0,
                ),
                const Divider(
                  color: Colors.grey, // Set the color of the line
                  height: 20, // Set the height (thickness) of the line
                  thickness: 2, // Set the thickness of the line
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        'Carbohydrates'
                    ),
                    Text(
                        'Fiber'
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 1.1, // Adjust the aspect ratio as needed
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Text(
                              '117/150g',
                              style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            SummaryPieChart()
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 1.1, // Adjust the aspect ratio as needed
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Text(
                              '117/150g',
                              style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            SummaryPieChart()
                          ],
                        ),
                      ),
                    ),
                  ],
                ),









                const SizedBox(
                  height: 10.0,
                ),
                const Divider(
                  color: Colors.grey, // Set the color of the line
                  height: 20, // Set the height (thickness) of the line
                  thickness: 2, // Set the thickness of the line
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        'Sugar'
                    ),
                    Text(
                        'Fat'
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 1.1, // Adjust the aspect ratio as needed
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Text(
                              '117/150g',
                              style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            SummaryPieChart()
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 1.1, // Adjust the aspect ratio as needed
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Text(
                              '117/150g',
                              style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            SummaryPieChart()
                          ],
                        ),
                      ),
                    ),
                  ],
                ),








                const SizedBox(
                  height: 10.0,
                ),
                const Divider(
                  color: Colors.grey, // Set the color of the line
                  height: 20, // Set the height (thickness) of the line
                  thickness: 2, // Set the thickness of the line
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        'Saturated Fat'
                    ),
                    Text(
                        'Polyunsaturated Fat'
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 1.1, // Adjust the aspect ratio as needed
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Text(
                              '117/150g',
                              style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            SummaryPieChart()
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 1.1, // Adjust the aspect ratio as needed
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Text(
                              '117/150g',
                              style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            SummaryPieChart()
                          ],
                        ),
                      ),
                    ),
                  ],
                ),







                const SizedBox(
                  height: 10.0,
                ),
                const Divider(
                  color: Colors.grey, // Set the color of the line
                  height: 20, // Set the height (thickness) of the line
                  thickness: 2, // Set the thickness of the line
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        'Monounsaturated Fat'
                    ),
                    Text(
                        'Trans Fat'
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 1.1, // Adjust the aspect ratio as needed
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Text(
                              '117/150g',
                              style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            SummaryPieChart()
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 1.1, // Adjust the aspect ratio as needed
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Text(
                              '117/150g',
                              style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            SummaryPieChart()
                          ],
                        ),
                      ),
                    ),
                  ],
                ),












                const SizedBox(
                  height: 10.0,
                ),
                const Divider(
                  color: Colors.grey, // Set the color of the line
                  height: 20, // Set the height (thickness) of the line
                  thickness: 2, // Set the thickness of the line
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        'Cholesterol'
                    ),
                    Text(
                        'Sodium'
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 1.1, // Adjust the aspect ratio as needed
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Text(
                              '117/150g',
                              style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            SummaryPieChart()
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 1.1, // Adjust the aspect ratio as needed
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Text(
                              '117/150g',
                              style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            SummaryPieChart()
                          ],
                        ),
                      ),
                    ),
                  ],
                ),





                const SizedBox(
                  height: 10.0,
                ),
                const Divider(
                  color: Colors.grey, // Set the color of the line
                  height: 20, // Set the height (thickness) of the line
                  thickness: 2, // Set the thickness of the line
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        'Potassium'
                    ),
                    Text(
                        'Vitamin A'
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 1.1, // Adjust the aspect ratio as needed
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Text(
                              '117/150g',
                              style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            SummaryPieChart()
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 1.1, // Adjust the aspect ratio as needed
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Text(
                              '117/150g',
                              style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            SummaryPieChart()
                          ],
                        ),
                      ),
                    ),
                  ],
                ),













                const SizedBox(
                  height: 10.0,
                ),
                const Divider(
                  color: Colors.grey, // Set the color of the line
                  height: 20, // Set the height (thickness) of the line
                  thickness: 2, // Set the thickness of the line
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        'Vitamin C'
                    ),
                    Text(
                        'Calcium'
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 1.1, // Adjust the aspect ratio as needed
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Text(
                              '117/150g',
                              style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            SummaryPieChart()
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 1.1, // Adjust the aspect ratio as needed
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Text(
                              '117/150g',
                              style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            SummaryPieChart()
                          ],
                        ),
                      ),
                    ),
                  ],
                ),













                  const SizedBox(
                    height: 10.0,
                  ),
                  const Divider(
                    color: Colors.grey, // Set the color of the line
                    height: 20, // Set the height (thickness) of the line
                    thickness: 2, // Set the thickness of the line
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          'Cholesterol'
                      ),
                      Text(
                          'Sodium'
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 1.1, // Adjust the aspect ratio as needed
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Text(
                                '117/150g',
                                style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              SummaryPieChart()
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 1.1, // Adjust the aspect ratio as needed
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Text(
                                '117/150g',
                                style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              SummaryPieChart()
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            )
          )
        ],
      ),
    ),
  );
  }
}
