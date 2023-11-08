import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../screens/home/dashboard.dart';

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

class ChartCard extends StatefulWidget {
  List<Data> initialChartData;
  final String label;
  DateTime initialStartDate;
  DateTime initialEndDate;

  ChartCard({super.key, required this.initialChartData, required this.label, required this.initialStartDate, required this.initialEndDate});

  @override
  ChartCardState createState() => ChartCardState();
}

class ChartCardState extends State<ChartCard> {
  List<Data> chartData = []; // Create a separate chartData list
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    chartData = widget.initialChartData.toList(); // Copy the initial data
    startDate = widget.initialStartDate;
    endDate = widget.initialEndDate;
  }

  /// Method to update the chart data.
  List<Data> _updateChartData() {
    final daysDifference = endDate.difference(startDate).inDays;
    for (int i = 0; i < daysDifference + 1; i++) {
      chartData.add(Data(formatDate(startDate.add(Duration(days: i))), i * 100));
    }
    return chartData;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
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
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: <Widget>[
            Text(
              '${widget.label} Daily Report',
              style: TextStyle(
                fontFamily: "Inter",
                color: Colors.grey[350],
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                final selectedDates = await showDateRangePicker(
                    context: context,
                    initialDateRange: DateTimeRange(
                        start: startDate, end: endDate),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                    helpText: "Please select a date range of 5 days or less"
                );

                if (selectedDates != null) {
                  final daysDifference = selectedDates.end
                      .difference(selectedDates.start)
                      .inDays;

                  if (daysDifference <= 4) {
                    setState(() {
                      startDate = selectedDates.start;
                      endDate = selectedDates.end;
                      chartData = <Data>[];
                      chartData = _updateChartData();
                    });
                  } else {
                    Fluttertoast.showToast(
                        msg: "Please select a date range of 5 days or less",
                        toastLength: Toast.LENGTH_SHORT,
                        // Toast duration (Toast.LENGTH_SHORT or Toast.LENGTH_LONG)
                        gravity: ToastGravity.BOTTOM,
                        // Toast position (ToastGravity.TOP, ToastGravity.CENTER, or ToastGravity.BOTTOM)
                        timeInSecForIosWeb: 1,
                        // Time for iOS and web (in seconds)
                        fontSize: 16.0
                    );
                  }
                }
              },
              child: const Icon(
                Icons.calendar_today,
                // Replace with the calendar icon you want to use
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
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[350],
                          height: 1.5,
                      )
                  ),
                  labelStyle: TextStyle(
                    color: Colors.grey[350],
                    fontFamily: "Inter",
                  )
              ),
              primaryYAxis: NumericAxis(
                  title: AxisTitle(
                      text: 'Consumed ${widget.label}',
                      textStyle: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 12,
                          color: Colors.grey[350],
                          fontWeight: FontWeight.w600
                      )
                  ),
                  labelStyle: TextStyle(
                    color: Colors.grey[350],
                    fontFamily: "Inter",
                  )
              ),
              series: <ColumnSeries<Data, String>>[
                ColumnSeries<Data, String>(
                    dataSource: chartData,
                    xValueMapper: (Data data, _) => data.date,
                    yValueMapper: (Data data, _) => data.value,
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
    );
  }
}
