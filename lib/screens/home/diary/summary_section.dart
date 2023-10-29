import 'package:flutter/material.dart';
import '../../../widgets/datepicker.dart';
import '../../../widgets/summarypiechart.dart';

class SummaryPage extends StatefulWidget {
  const SummaryPage({super.key});

  @override
  SummaryPageState createState() =>
      SummaryPageState();
}

class SummaryPageState extends State<SummaryPage> {
  List<Item> items = [
    Item('Calories', 'This is a description for Calories.'),
    Item('Protein', 'This is a description for Protein.'),
    Item('Carbohydrate', 'This is a description for Carbohydrate.'),
    Item('Fiber', 'This is a description for Fiber.'),
    Item('Sugar', 'This is a description for Sugar.'),
    Item('Fat', 'This is a description for Fat.'),
    Item('Saturated Fat', 'This is a description for Saturated Fat.'),
    Item('Polyunsaturated Fat', 'This is a description for Polyunsaturated Fat.'),
    Item('Monounsaturated Fat', 'This is a description for Monounsaturated Fat.'),
    Item('Trans Fat', 'This is a description for Trans Fat.'),
    Item('Cholesterol', 'This is a description for Cholesterol.'),
    Item('Sodium', 'This is a description for Sodium.'),
    Item('Potassium', 'This is a description for Potassium.'),
    Item('Vitamin A', 'This is a description for Vitamin A.'),
    Item('Vitamin C', 'This is a description for Vitamin C.'),
    Item('Calcium', 'This is a description for Calcium.'),
    Item('Iron', 'This is a description for Iron.')
  ];

  int selectedIndex = -1; // No dropdown expanded by default

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
              Column(
                children: items.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;

                  return Column(
                    children: [
                      Container(
                        width: double.infinity, // Full width
                        height: 50, // Set the desired height
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50), // Make it circular
                          border: Border.all(color: Colors.blue, width: 2),
                          gradient: const LinearGradient(
                            colors: [Colors.green, Colors.white], // Grey and white gradient
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                        child: ListTile(
                          title: Text(item.title),
                          onTap: () {
                            setState(() {
                              if (selectedIndex == index) {
                                selectedIndex = -1; // Close the selected dropdown
                              } else {
                                selectedIndex = index; // Expand the selected dropdown
                              }
                            });
                          },
                        )
                      ),
                      if (selectedIndex == index)
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(item.description),
                        ),
                      const SizedBox(height: 10),
                    ],
                  );
                }).toList(),
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

class Item {
  final String title;
  final String description;

  Item(this.title, this.description);
}





























                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: <Widget>[
                //     Row(
                //       children: <Widget>[
                //         Container(
                //           width: 10,
                //           height: 10,
                //           color: Colors.yellow[800],
                //         ),
                //         const SizedBox(width: 8), // Add some spacing between the square and label
                //         const Text(
                //           'Breakfast',
                //           style: TextStyle(color: Colors.black),
                //         ),
                //       ],
                //     ),
                //     Row(
                //       children: <Widget>[
                //         Container(
                //           width: 10,
                //           height: 10,
                //           color: Colors.blue[900],
                //         ),
                //         const SizedBox(width: 8),
                //         const Text(
                //           'Lunch',
                //           style: TextStyle(color: Colors.black),
                //         ),
                //       ],
                //     ),
                //     Row(
                //       children: <Widget>[
                //         Container(
                //           width: 10,
                //           height: 10,
                //           color: Colors.red[800],
                //         ),
                //         const SizedBox(width: 8),
                //         const Text(
                //           'Dinner',
                //           style: TextStyle(color: Colors.black),
                //         ),
                //       ],
                //     ),
                //     Row(
                //       children: <Widget>[
                //         Container(
                //           width: 10,
                //           height: 10,
                //           color: Colors.brown[600],
                //         ),
                //         const SizedBox(width: 8),
                //         const Text(
                //           'Snacks',
                //           style: TextStyle(color: Colors.black),
                //         ),
                //       ],
                //     ),
                //   ],
                // ),
                // const SizedBox(
                //   height: 15.0,
                // ),
                // Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: <Widget>[
                //       Container(
                //         width: 10,
                //         height: 10,
                //         decoration: const BoxDecoration(
                //           shape: BoxShape.circle, // Makes the container circular
                //           color: Colors.black, // Set the color to black
                //         ),
                //       ),
                //       const SizedBox(width: 8),
                //       const Text(
                //         'Total (Breakfast + Lunch + Dinner + Snacks) / Goal',
                //         style: TextStyle(color: Colors.black),
                //       ),
                //     ]
                // ),
                // const SizedBox(
                //   height: 30.0,
                // ),
                //
                //
                //
                //
                //
                // const Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //       'Calories'
                //     ),
                //     Text(
                //       'Protein'
                //     ),
                //   ],
                // ),
                // const SizedBox(
                //   height: 10.0,
                // ),
                //  const Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Expanded(
                //       child: AspectRatio(
                //         aspectRatio: 1.1, // Adjust the aspect ratio as needed
                //         child: Stack(
                //           alignment: Alignment.center,
                //           children: [
                //             Text(
                //               '117/2500',
                //               style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                //             ),
                //             SummaryPieChart()
                //           ],
                //         ),
                //       ),
                //     ),
                //     Expanded(
                //       child: AspectRatio(
                //         aspectRatio: 1.1, // Adjust the aspect ratio as needed
                //         child: Stack(
                //           alignment: Alignment.center,
                //           children: [
                //             Text(
                //               '117/150g',
                //               style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                //             ),
                //             SummaryPieChart()
                //           ],
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                //
                //
                //
                //
                //
                //
                // const SizedBox(
                //   height: 10.0,
                // ),
                // const Divider(
                //   color: Colors.grey, // Set the color of the line
                //   height: 20, // Set the height (thickness) of the line
                //   thickness: 2, // Set the thickness of the line
                // ),
                // const SizedBox(
                //   height: 10.0,
                // ),
                // const Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //         'Carbohydrates'
                //     ),
                //     Text(
                //         'Fiber'
                //     ),
                //   ],
                // ),
                // const SizedBox(
                //   height: 10.0,
                // ),
                // const Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Expanded(
                //       child: AspectRatio(
                //         aspectRatio: 1.1, // Adjust the aspect ratio as needed
                //         child: Stack(
                //           alignment: Alignment.center,
                //           children: [
                //             Text(
                //               '117/150g',
                //               style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                //             ),
                //             SummaryPieChart()
                //           ],
                //         ),
                //       ),
                //     ),
                //     Expanded(
                //       child: AspectRatio(
                //         aspectRatio: 1.1, // Adjust the aspect ratio as needed
                //         child: Stack(
                //           alignment: Alignment.center,
                //           children: [
                //             Text(
                //               '117/150g',
                //               style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                //             ),
                //             SummaryPieChart()
                //           ],
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                //
                //
                //
                //
                //
                //
                //
                //
                //
                // const SizedBox(
                //   height: 10.0,
                // ),
                // const Divider(
                //   color: Colors.grey, // Set the color of the line
                //   height: 20, // Set the height (thickness) of the line
                //   thickness: 2, // Set the thickness of the line
                // ),
                // const SizedBox(
                //   height: 10.0,
                // ),
                // const Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //         'Sugar'
                //     ),
                //     Text(
                //         'Fat'
                //     ),
                //   ],
                // ),
                // const SizedBox(
                //   height: 10.0,
                // ),
                // const Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Expanded(
                //       child: AspectRatio(
                //         aspectRatio: 1.1, // Adjust the aspect ratio as needed
                //         child: Stack(
                //           alignment: Alignment.center,
                //           children: [
                //             Text(
                //               '117/150g',
                //               style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                //             ),
                //             SummaryPieChart()
                //           ],
                //         ),
                //       ),
                //     ),
                //     Expanded(
                //       child: AspectRatio(
                //         aspectRatio: 1.1, // Adjust the aspect ratio as needed
                //         child: Stack(
                //           alignment: Alignment.center,
                //           children: [
                //             Text(
                //               '117/150g',
                //               style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                //             ),
                //             SummaryPieChart()
                //           ],
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                //
                //
                //
                //
                //
                //
                //
                //
                // const SizedBox(
                //   height: 10.0,
                // ),
                // const Divider(
                //   color: Colors.grey, // Set the color of the line
                //   height: 20, // Set the height (thickness) of the line
                //   thickness: 2, // Set the thickness of the line
                // ),
                // const SizedBox(
                //   height: 10.0,
                // ),
                // const Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //         'Saturated Fat'
                //     ),
                //     Text(
                //         'Polyunsaturated Fat'
                //     ),
                //   ],
                // ),
                // const SizedBox(
                //   height: 10.0,
                // ),
                // const Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Expanded(
                //       child: AspectRatio(
                //         aspectRatio: 1.1, // Adjust the aspect ratio as needed
                //         child: Stack(
                //           alignment: Alignment.center,
                //           children: [
                //             Text(
                //               '117/150g',
                //               style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                //             ),
                //             SummaryPieChart()
                //           ],
                //         ),
                //       ),
                //     ),
                //     Expanded(
                //       child: AspectRatio(
                //         aspectRatio: 1.1, // Adjust the aspect ratio as needed
                //         child: Stack(
                //           alignment: Alignment.center,
                //           children: [
                //             Text(
                //               '117/150g',
                //               style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                //             ),
                //             SummaryPieChart()
                //           ],
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                //
                //
                //
                //
                //
                //
                //
                // const SizedBox(
                //   height: 10.0,
                // ),
                // const Divider(
                //   color: Colors.grey, // Set the color of the line
                //   height: 20, // Set the height (thickness) of the line
                //   thickness: 2, // Set the thickness of the line
                // ),
                // const SizedBox(
                //   height: 10.0,
                // ),
                // const Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //         'Monounsaturated Fat'
                //     ),
                //     Text(
                //         'Trans Fat'
                //     ),
                //   ],
                // ),
                // const SizedBox(
                //   height: 10.0,
                // ),
                // const Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Expanded(
                //       child: AspectRatio(
                //         aspectRatio: 1.1, // Adjust the aspect ratio as needed
                //         child: Stack(
                //           alignment: Alignment.center,
                //           children: [
                //             Text(
                //               '117/150g',
                //               style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                //             ),
                //             SummaryPieChart()
                //           ],
                //         ),
                //       ),
                //     ),
                //     Expanded(
                //       child: AspectRatio(
                //         aspectRatio: 1.1, // Adjust the aspect ratio as needed
                //         child: Stack(
                //           alignment: Alignment.center,
                //           children: [
                //             Text(
                //               '117/150g',
                //               style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                //             ),
                //             SummaryPieChart()
                //           ],
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                // const SizedBox(
                //   height: 10.0,
                // ),
                // const Divider(
                //   color: Colors.grey, // Set the color of the line
                //   height: 20, // Set the height (thickness) of the line
                //   thickness: 2, // Set the thickness of the line
                // ),
                // const SizedBox(
                //   height: 10.0,
                // ),
                // const Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //         'Cholesterol'
                //     ),
                //     Text(
                //         'Sodium'
                //     ),
                //   ],
                // ),
                // const SizedBox(
                //   height: 10.0,
                // ),
                // const Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Expanded(
                //       child: AspectRatio(
                //         aspectRatio: 1.1, // Adjust the aspect ratio as needed
                //         child: Stack(
                //           alignment: Alignment.center,
                //           children: [
                //             Text(
                //               '117/150g',
                //               style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                //             ),
                //             SummaryPieChart()
                //           ],
                //         ),
                //       ),
                //     ),
                //     Expanded(
                //       child: AspectRatio(
                //         aspectRatio: 1.1, // Adjust the aspect ratio as needed
                //         child: Stack(
                //           alignment: Alignment.center,
                //           children: [
                //             Text(
                //               '117/150g',
                //               style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                //             ),
                //             SummaryPieChart()
                //           ],
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                //
                //
                //
                //
                //
                // const SizedBox(
                //   height: 10.0,
                // ),
                // const Divider(
                //   color: Colors.grey, // Set the color of the line
                //   height: 20, // Set the height (thickness) of the line
                //   thickness: 2, // Set the thickness of the line
                // ),
                // const SizedBox(
                //   height: 10.0,
                // ),
                // const Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //         'Potassium'
                //     ),
                //     Text(
                //         'Vitamin A'
                //     ),
                //   ],
                // ),
                // const SizedBox(
                //   height: 10.0,
                // ),
                // const Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Expanded(
                //       child: AspectRatio(
                //         aspectRatio: 1.1, // Adjust the aspect ratio as needed
                //         child: Stack(
                //           alignment: Alignment.center,
                //           children: [
                //             Text(
                //               '117/150g',
                //               style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                //             ),
                //             SummaryPieChart()
                //           ],
                //         ),
                //       ),
                //     ),
                //     Expanded(
                //       child: AspectRatio(
                //         aspectRatio: 1.1, // Adjust the aspect ratio as needed
                //         child: Stack(
                //           alignment: Alignment.center,
                //           children: [
                //             Text(
                //               '117/150g',
                //               style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                //             ),
                //             SummaryPieChart()
                //           ],
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                // const SizedBox(
                //   height: 10.0,
                // ),
                // const Divider(
                //   color: Colors.grey, // Set the color of the line
                //   height: 20, // Set the height (thickness) of the line
                //   thickness: 2, // Set the thickness of the line
                // ),
                // const SizedBox(
                //   height: 10.0,
                // ),
                // const Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //         'Vitamin C'
                //     ),
                //     Text(
                //         'Calcium'
                //     ),
                //   ],
                // ),
                // const SizedBox(
                //   height: 10.0,
                // ),
                // const Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Expanded(
                //       child: AspectRatio(
                //         aspectRatio: 1.1, // Adjust the aspect ratio as needed
                //         child: Stack(
                //           alignment: Alignment.center,
                //           children: [
                //             Text(
                //               '117/150g',
                //               style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                //             ),
                //             SummaryPieChart()
                //           ],
                //         ),
                //       ),
                //     ),
                //     Expanded(
                //       child: AspectRatio(
                //         aspectRatio: 1.1, // Adjust the aspect ratio as needed
                //         child: Stack(
                //           alignment: Alignment.center,
                //           children: [
                //             Text(
                //               '117/150g',
                //               style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                //             ),
                //             SummaryPieChart()
                //           ],
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //
                //   const SizedBox(
                //     height: 10.0,
                //   ),
                //   const Divider(
                //     color: Colors.grey, // Set the color of the line
                //     height: 20, // Set the height (thickness) of the line
                //     thickness: 2, // Set the thickness of the line
                //   ),
                //   const SizedBox(
                //     height: 10.0,
                //   ),
                //   const Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text(
                //           'Cholesterol'
                //       ),
                //       Text(
                //           'Sodium'
                //       ),
                //     ],
                //   ),
                //   const SizedBox(
                //     height: 10.0,
                //   ),
                //   const Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Expanded(
                //         child: AspectRatio(
                //           aspectRatio: 1.1, // Adjust the aspect ratio as needed
                //           child: Stack(
                //             alignment: Alignment.center,
                //             children: [
                //               Text(
                //                 '117/150g',
                //                 style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                //               ),
                //               SummaryPieChart()
                //             ],
                //           ),
                //         ),
                //       ),
                //       Expanded(
                //         child: AspectRatio(
                //           aspectRatio: 1.1, // Adjust the aspect ratio as needed
                //           child: Stack(
                //             alignment: Alignment.center,
                //             children: [
                //               Text(
                //                 '117/150g',
                //                 style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                //               ),
                //               SummaryPieChart()
                //             ],
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),

