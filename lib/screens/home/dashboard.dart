import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../widgets/appbar.dart';
import '../../widgets/dashboardcarouselchart.dart';
import '../../widgets/navdrawer.dart';

String formatDate(DateTime date) {
  DateTime now = DateTime.now();
  if (date.year == now.year && date.month == now.month && date.day == now.day) {
    return 'Today';
  }
  DateTime yesterday = now.subtract(Duration(days: 1));
  if (date.year == yesterday.year && date.month == yesterday.month && date.day == yesterday.day) {
    return 'Yesterday';
  }
  return DateFormat('MM/dd').format(date);
}

String formatBodyCompositionDate(DateTime date) {
  DateTime now = DateTime.now();
  if (date.year == now.year && date.month == now.month && date.day == now.day) {
    return 'Today';
  }
  DateTime yesterday = now.subtract(Duration(days: 1));
  if (date.year == yesterday.year && date.month == yesterday.month && date.day == yesterday.day) {
    return 'Yesterday';
  }
  return DateFormat('MM/dd').format(date);
}

DateTime startDate1 = DateTime.now().subtract(const Duration(days: 4));
DateTime endDate1 = DateTime.now();
List<Data> calorieData = <Data>[
  Data(formatDate(startDate1.add(const Duration(days: 0))), 1000),
  Data(formatDate(startDate1.add(const Duration(days: 1))), 1100),
  Data(formatDate(startDate1.add(const Duration(days: 2))), 1200),
  Data(formatDate(startDate1.add(const Duration(days: 3))), 1300),
  Data(formatDate(startDate1.add(const Duration(days: 4))), 1400),
];

DateTime startDate2 = DateTime.now().subtract(const Duration(days: 4));
DateTime endDate2 = DateTime.now();
List<Data> proteinData = <Data>[
  Data(formatDate(startDate2.add(const Duration(days: 0))), 100),
  Data(formatDate(startDate2.add(const Duration(days: 1))), 50),
  Data(formatDate(startDate2.add(const Duration(days: 2))), 200),
  Data(formatDate(startDate2.add(const Duration(days: 3))), 140),
  Data(formatDate(startDate2.add(const Duration(days: 4))), 80),
];

List<WeightData> weightData = <WeightData>[
  WeightData(formatDate(DateTime.now()), 70),
  WeightData(formatDate(DateTime.now().add(const Duration(days: 1))), 80),
  WeightData(formatDate(DateTime.now().add(const Duration(days: 2))), 81),
  WeightData(formatDate(DateTime.now().add(const Duration(days: 3))), 50),
  WeightData(formatDate(DateTime.now().add(const Duration(days: 4))), 60),
  WeightData(formatDate(DateTime.now().add(const Duration(days: 5))), 30),
  WeightData(formatDate(DateTime.now().add(const Duration(days: 6))), 90),
];
List<SkeletalMuscleMassData> skeletalMuscleData = <SkeletalMuscleMassData>[
  SkeletalMuscleMassData(formatDate(DateTime.now()), 36.4),
  SkeletalMuscleMassData(formatDate(DateTime.now().add(const Duration(days: 1))), 35.2),
  SkeletalMuscleMassData(formatDate(DateTime.now().add(const Duration(days: 2))), 35),
];
List<PercentBodyFatData> percentBodyFatData = <PercentBodyFatData>[
  PercentBodyFatData(formatDate(DateTime.now()), 13),
  PercentBodyFatData(formatDate(DateTime.now().add(const Duration(days: 1))), 15),
  PercentBodyFatData(formatDate(DateTime.now().add(const Duration(days: 2))), 14.5),
  PercentBodyFatData(formatDate(DateTime.now().add(const Duration(days: 3))), 14),
];

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final CarouselController _carouselController = CarouselController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF323232),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(65),
        child: MyAppBar(selectedTabs: []),
      ),
      drawer:  const SizedBox(
          width: 250,
          child: NavDrawer()
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF323232), // Dark Gray
              Color(0xFF444444), // Slightly lighter shade of gray
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Form(
                  key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        CarouselSlider(
                          carouselController: _carouselController,
                          options: CarouselOptions(
                            height: 470, // Set the height of the carousel item as needed
                            enableInfiniteScroll: true, // Disable infinite scrolling if needed
                            enlargeCenterPage: true, // Enlarge the center card
                            viewportFraction: 0.95,
                            onPageChanged: (index, reason) {
                              setState(() {
                                currentPage = index; // Update the current page
                              });
                            },
                          ),
                          items: <Widget>[
                            // Create multiple cards with your bar chart
                            ChartCard(initialChartData: calorieData, label: 'Calories', initialStartDate: startDate1, initialEndDate: endDate1, goal: "2500", image: Image.asset('assets/images/svg/calories.png', width: 30, height: 30)),
                            ChartCard(initialChartData: proteinData, label: 'Protein', initialStartDate: startDate2, initialEndDate: endDate2, goal: "250", image: Image.asset('assets/images/svg/protein.png', width: 30, height: 30)),
                            // Add more chart cards as needed
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List<Widget>.generate(
                            2, // Change this value to the total number of items in your carousel
                                (index) {
                              return Container(
                                width: 8.0,
                                height: 8.0,
                                margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: currentPage == index ? Colors.blue : Colors.grey,
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Body Composition History",
                              style: TextStyle(
                                fontFamily: "Inter",
                                color: Colors.grey[350],
                                fontSize: 16,
                              ),
                            )
                          ]
                        ),
                        const SizedBox(height: 10),
                        Card(
                          elevation: 4, // Add elevation for a shadow effect
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
                            side: BorderSide(
                              color: Colors.grey[350]!, // Border color
                              width: 2.0, // Border width
                            ),
                          ),
                          color: const Color(0xFF444444),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 5.0, top: 5.0),
                                      child: Container(
                                        width: 24, // Set the desired width
                                        height: 24, // Set the desired height
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle, // Make it circular
                                          color: Colors.blue, // Set your desired background color
                                        ),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.zero, // Remove default padding
                                            shape: const CircleBorder(), // Ensure a circular shape
                                          ),
                                          onPressed: () async {

                                          },
                                          child: Icon(
                                            Icons.edit,
                                            // Replace with the calendar icon you want to use
                                            color: Colors.grey[350],
                                            size: 13,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 180,
                                  child: SfCartesianChart(
                                      title: ChartTitle(
                                        text: "Weight (Kg)",
                                        textStyle: TextStyle(
                                          fontFamily: "Inter",
                                          color: Colors.grey[350],
                                          fontSize: 11,
                                        ),
                                      ),
                                      primaryXAxis: CategoryAxis(
                                        title: AxisTitle(
                                            text: 'Time',
                                            textStyle: TextStyle(
                                              fontFamily: "Inter",
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey[350],
                                              height: 2,
                                            )
                                        ),
                                        labelStyle: TextStyle(
                                          color: Colors.grey[350],
                                          fontFamily: "Inter",
                                        ),
                                        majorGridLines: const MajorGridLines(color: Colors.grey), // Color for major gridlines
                                        minorGridLines: const MinorGridLines(color: Colors.grey),
                                      ),
                                      primaryYAxis: NumericAxis(
                                        labelStyle: TextStyle(
                                          color: Colors.grey[350],
                                          fontFamily: "Inter",
                                        ),
                                        majorGridLines: const MajorGridLines(color: Colors.grey), // Color for major gridlines
                                        minorGridLines: const MinorGridLines(color: Colors.grey),
                                      ),
                                      series: <ChartSeries>[
                                        // Renders spline chart
                                        SplineSeries<WeightData, String>(
                                          dataSource: weightData,
                                          dataLabelSettings: const DataLabelSettings(
                                            isVisible: true, // Show data labels
                                            textStyle: TextStyle(
                                              color: Colors.blue, // Specify the desired color for data labels
                                              fontSize: 10, // Specify the desired font size for data labels
                                              fontFamily: "Inter", // Specify the desired font family for data labels
                                              fontWeight: FontWeight.normal, // Specify the desired font weight for data labels
                                            ),
                                          ),
                                          markerSettings: const MarkerSettings(
                                              isVisible: true,
                                              color: Colors.blue
                                          ),
                                          xValueMapper: (WeightData data, _) => data.date,
                                          yValueMapper: (WeightData data, _) => data.weight,
                                          width: 3,
                                          color: Colors.blue,
                                        )
                                      ]
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Card(
                          elevation: 4, // Add elevation for a shadow effect
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
                            side: BorderSide(
                              color: Colors.grey[350]!, // Border color
                              width: 2.0, // Border width
                            ),
                          ),
                          color: const Color(0xFF444444),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 5.0, top: 5.0),
                                      child: Container(
                                        width: 24, // Set the desired width
                                        height: 24, // Set the desired height
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle, // Make it circular
                                          color: Colors.blue, // Set your desired background color
                                        ),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.zero, // Remove default padding
                                            shape: const CircleBorder(), // Ensure a circular shape
                                          ),
                                          onPressed: () async {

                                          },
                                          child: Icon(
                                            Icons.edit,
                                            // Replace with the calendar icon you want to use
                                            color: Colors.grey[350],
                                            size: 13,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 180,
                                  child: SfCartesianChart(
                                      title: ChartTitle(
                                        text: "Skeletal Muscle Mass (Kg)",
                                        textStyle: TextStyle(
                                          fontFamily: "Inter",
                                          color: Colors.grey[350],
                                          fontSize: 11,
                                        ),
                                      ),
                                      primaryXAxis: CategoryAxis(
                                        title: AxisTitle(
                                            text: 'Time',
                                            textStyle: TextStyle(
                                              fontFamily: "Inter",
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey[350],
                                              height: 2,
                                            )
                                        ),
                                        labelStyle: TextStyle(
                                          color: Colors.grey[350],
                                          fontFamily: "Inter",
                                        ),
                                        majorGridLines: const MajorGridLines(color: Colors.grey), // Color for major gridlines
                                        minorGridLines: const MinorGridLines(color: Colors.grey),
                                      ),
                                      primaryYAxis: NumericAxis(
                                        labelStyle: TextStyle(
                                          color: Colors.grey[350],
                                          fontFamily: "Inter",
                                        ),
                                        majorGridLines: const MajorGridLines(color: Colors.grey), // Color for major gridlines
                                        minorGridLines: const MinorGridLines(color: Colors.grey),
                                      ),
                                      series: <ChartSeries>[
                                        // Renders spline chart
                                        SplineSeries<SkeletalMuscleMassData, String>(
                                          dataSource: skeletalMuscleData,
                                          dataLabelSettings: const DataLabelSettings(
                                            isVisible: true, // Show data labels
                                            textStyle: TextStyle(
                                              color: Colors.orange, // Specify the desired color for data labels
                                              fontSize: 10, // Specify the desired font size for data labels
                                              fontFamily: "Inter", // Specify the desired font family for data labels
                                              fontWeight: FontWeight.normal, // Specify the desired font weight for data labels
                                            ),
                                          ),
                                          markerSettings: const MarkerSettings(
                                              isVisible: true,
                                              color: Colors.orange
                                          ),
                                          xValueMapper: (SkeletalMuscleMassData data, _) => data.date,
                                          yValueMapper: (SkeletalMuscleMassData data, _) => data.skeletalMuscle,
                                          width: 3,
                                          color: Colors.orange,
                                        )
                                      ]
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Card(
                          elevation: 4, // Add elevation for a shadow effect
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
                            side: BorderSide(
                              color: Colors.grey[350]!, // Border color
                              width: 2.0, // Border width
                            ),
                          ),
                          color: const Color(0xFF444444),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 5.0, top: 5.0),
                                      child: Container(
                                        width: 24, // Set the desired width
                                        height: 24, // Set the desired height
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle, // Make it circular
                                          color: Colors.blue, // Set your desired background color
                                        ),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.zero, // Remove default padding
                                            shape: const CircleBorder(), // Ensure a circular shape
                                          ),
                                          onPressed: () async {

                                          },
                                          child: Icon(
                                            Icons.edit,
                                            // Replace with the calendar icon you want to use
                                            color: Colors.grey[350],
                                            size: 13,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 180,
                                  child: SfCartesianChart(
                                      title: ChartTitle(
                                        text: "Percent Body Fat (%)",
                                        textStyle: TextStyle(
                                          fontFamily: "Inter",
                                          color: Colors.grey[350],
                                          fontSize: 11,
                                        ),
                                      ),
                                      primaryXAxis: CategoryAxis(
                                        title: AxisTitle(
                                            text: 'Time',
                                            textStyle: TextStyle(
                                              fontFamily: "Inter",
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey[350],
                                              height: 2,
                                            )
                                        ),
                                        labelStyle: TextStyle(
                                          color: Colors.grey[350],
                                          fontFamily: "Inter",
                                        ),
                                        majorGridLines: const MajorGridLines(color: Colors.grey), // Color for major gridlines
                                        minorGridLines: const MinorGridLines(color: Colors.grey),
                                      ),
                                      primaryYAxis: NumericAxis(
                                        labelStyle: TextStyle(
                                          color: Colors.grey[350],
                                          fontFamily: "Inter",
                                        ),
                                        majorGridLines: const MajorGridLines(color: Colors.grey), // Color for major gridlines
                                        minorGridLines: const MinorGridLines(color: Colors.grey),
                                        // minimum: 0,
                                        // maximum: 100
                                      ),
                                      series: <ChartSeries>[
                                        // Renders spline chart
                                        SplineSeries<PercentBodyFatData, String>(
                                          dataSource: percentBodyFatData,
                                          dataLabelSettings: const DataLabelSettings(
                                            isVisible: true, // Show data labels
                                            textStyle: TextStyle(
                                              color: Colors.purple, // Specify the desired color for data labels
                                              fontSize: 10, // Specify the desired font size for data labels
                                              fontFamily: "Inter", // Specify the desired font family for data labels
                                              fontWeight: FontWeight.normal, // Specify the desired font weight for data labels
                                            ),
                                          ),
                                          markerSettings: const MarkerSettings(
                                              isVisible: true,
                                              color: Colors.purple
                                          ),
                                          xValueMapper: (PercentBodyFatData data, _) => data.date,
                                          yValueMapper: (PercentBodyFatData data, _) => data.percentBodyFat,
                                          width: 3,
                                          color: Colors.purple,
                                        )
                                      ]
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ]
          ),
        ),
      ),
    );
  }
}

class Data {
  final String date;
  final double value;

  Data(this.date, this.value);
}

class WeightData {
  final String date;
  final double weight;

  WeightData(this.date, this.weight);
}

class SkeletalMuscleMassData {
  final String date;
  final double skeletalMuscle;

  SkeletalMuscleMassData(this.date, this.skeletalMuscle);
}

class PercentBodyFatData {
  final String date;
  final double percentBodyFat;

  PercentBodyFatData(this.date, this.percentBodyFat);
}


