import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../widgets/appbar.dart';
import '../../widgets/dashboardcarouselchart.dart';
import '../../widgets/dashboardbodycompositioncharts.dart';
import '../../widgets/navdrawer.dart';

String formatDate(DateTime date) {
  return DateFormat('dd\nEEE').format(date);
}

String formatBodyCompositionDate(DateTime date) {
  return DateFormat('MM-dd\nH:m').format(date);
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

List<BodyCompositionData> weightData = <BodyCompositionData>[];
List<BodyCompositionData> skeletalMuscleData = <BodyCompositionData>[];
List<BodyCompositionData> percentBodyFatData = <BodyCompositionData>[];

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
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(65),
        child: MyAppBar(selectedTabs: []),
      ),
      drawer:  const SizedBox(
          width: 250,
          child: NavDrawer()
      ),
      body: Container(
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
                            ChartCard(initialChartData: calorieData, label: 'Calories', initialStartDate: startDate1, initialEndDate: endDate1, goal: "2500", image: Image.asset('assets/images/svg/calories.png', width: 30, height: 30), unit: "Kcal"),
                            ChartCard(initialChartData: proteinData, label: 'Protein', initialStartDate: startDate2, initialEndDate: endDate2, goal: "250", image: Image.asset('assets/images/svg/protein.png', width: 30, height: 30), unit: "g"),
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
                                  color: currentPage == index ? const Color(0xFF5AC8FA) : const Color(0xFFFFFFFF),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Body Composition History",
                              style: TextStyle(
                                fontFamily: "Inter",
                                fontSize: 15,
                              ),
                            )
                          ]
                        ),
                        const SizedBox(height: 10),
                        BodyCompositionChart(initialChartData: weightData, title: "Weight (Kg)", sizedWidth: 80, color: const Color(0xFF5AC8FA)),
                        BodyCompositionChart(initialChartData: skeletalMuscleData, title: "Skeletal Muscle Mass (Kg)", sizedWidth: 180, color: const Color(0xFFFF9500)),
                        BodyCompositionChart(initialChartData: percentBodyFatData, title: "Percent Body Fat (%)", sizedWidth: 150, color: const Color(0xFFE91E63))
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

class BodyCompositionData {
  final String date;
  final double value;

  BodyCompositionData(this.date, this.value);
}


