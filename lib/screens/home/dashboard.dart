import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../widgets/appbar.dart';
import '../../widgets/navdrawer.dart';

DateTime startDate = DateTime.now().subtract(const Duration(days: 4));
DateTime endDate = DateTime.now(); // Initialize with today's date

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

List<CalorieData> chartData = <CalorieData>[
  CalorieData(formatDate(startDate.add(const Duration(days: 0))), 1000),
  CalorieData(formatDate(startDate.add(const Duration(days: 1))), 1100),
  CalorieData(formatDate(startDate.add(const Duration(days: 2))), 1200),
  CalorieData(formatDate(startDate.add(const Duration(days: 3))), 1300),
  CalorieData(formatDate(startDate.add(const Duration(days: 4))), 1400),
];

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Calories Bar Chart',
                        style: TextStyle(
                            fontFamily: "Inter",
                            color: Colors.grey[350],
                            fontSize: 15
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () async {
                          final selectedDates = await showDateRangePicker(
                            context: context,
                            initialDateRange: DateTimeRange(start: startDate, end: endDate),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );

                          if (selectedDates != null) {
                            setState(() {
                              startDate = selectedDates.start;
                              endDate = selectedDates.end;
                              chartData = <CalorieData>[];
                              chartData = _updateChartData();
                            });
                          }
                        },
                        child: const Icon(
                          Icons.calendar_today, // Replace with the calendar icon you want to use
                          color: Colors.white,
                          size: 17,
                        ),
                      ),
                      SfCartesianChart(
                        primaryXAxis: CategoryAxis(
                          title: AxisTitle(
                            text: 'Days',
                            textStyle: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 12,
                              color: Colors.grey[350]
                            )
                          ),
                          labelStyle: TextStyle(
                            color: Colors.grey[350],
                            fontFamily: "Inter",
                          )
                        ),
                        primaryYAxis: NumericAxis(
                          title: AxisTitle(
                            text: 'Consumed Calories',
                            textStyle: TextStyle(
                                fontFamily: "Inter",
                                fontSize: 12,
                                color: Colors.grey[350]
                            )
                          ),
                          labelStyle: TextStyle(
                            color: Colors.grey[350],
                            fontFamily: "Inter",
                          )
                        ),
                        series: <ColumnSeries<CalorieData, String>>[
                          ColumnSeries<CalorieData, String>(
                            dataSource: chartData,
                            xValueMapper: (CalorieData data, _) => data.date,
                            yValueMapper: (CalorieData data, _) => data.value,
                            width: 0.5,
                            dataLabelSettings: const DataLabelSettings(
                              isVisible: true,
                              textStyle: TextStyle(
                                color: Color(0xFF3FCC7C),
                                fontFamily: "Inter",
                              )
                            ),
                            borderRadius: const BorderRadius.all(Radius.circular(15)),
                            color: const Color(0xFF3FCC7C),
                            animationDuration: 1000
                          ),
                        ],
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

/// Method to update the chart data.
List<CalorieData> _updateChartData() {
  for (int i = 0; i < 5; i++) {
    if (startDate.add(Duration(days: i)) == endDate) {
      chartData.add(CalorieData(formatDate(startDate.add(Duration(days: i))), i * 100));
      break;
    }
    chartData.add(CalorieData(formatDate(startDate.add(Duration(days: i))), i * 100));
  }

  return chartData;
}


class CalorieData {
  final String date;
  final double value;

  CalorieData(this.date, this.value);
}

