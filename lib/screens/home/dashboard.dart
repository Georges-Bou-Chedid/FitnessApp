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
                  child: SizedBox(
                    height: 500,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: CarouselSlider(
                            carouselController: _carouselController,
                            options: CarouselOptions(
                              height: 450, // Set the height of the carousel item as needed
                              enableInfiniteScroll: false, // Disable infinite scrolling if needed
                              enlargeCenterPage: true, // Enlarge the center card
                              viewportFraction: 0.9,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  currentPage = index; // Update the current page
                                });
                              },
                            ),
                            items: <Widget>[
                              // Create multiple cards with your bar chart
                              ChartCard(initialChartData: calorieData, label: 'Calories', initialStartDate: startDate1, initialEndDate: endDate1),
                              ChartCard(initialChartData: proteinData, label: 'Protein', initialStartDate: startDate2, initialEndDate: endDate2),
                              // Add more chart cards as needed
                            ],
                          ),
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
                      ],
                    ),
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


