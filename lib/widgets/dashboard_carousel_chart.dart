import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../screens/home/dashboard.dart';

class ChartCard extends StatefulWidget {
  List<Data> initialChartData;
  final String label;
  DateTime initialStartDate;
  DateTime initialEndDate;
  final String goal;
  final Image image;
  final String unit;

  ChartCard({super.key, required this.initialChartData, required this.label, required this.initialStartDate, required this.initialEndDate, required this.goal, required this.image, required this.unit});

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
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () async {
                    final selectedDates = await showDateRangePicker(
                        context: context,
                        initialDateRange: DateTimeRange(
                            start: startDate, end: endDate),
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                        helpText: "Please select a date range of 5 days or less",
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
                  icon: const FaIcon(
                    Icons.calendar_today,
                    size: 18,
                  ),
                ),
              ],
            ),
            SfCartesianChart(
              title: ChartTitle(
                text: "${widget.label} Consumed",
                textStyle:  TextStyle(
                  color: Theme.of(context).scaffoldBackgroundColor == const Color(0xFF323232) ?
                      const Color(0xFFFFFFFF)
                      : const Color(0xFF323232),
                  fontFamily: "Inter",
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600
                ),
              ),
              primaryXAxis: CategoryAxis(
                labelStyle: TextStyle(
                  color: Theme.of(context).scaffoldBackgroundColor == const Color(0xFF323232) ?
                      const Color(0xFFFFFFFF)
                      : const Color(0xFF323232),
                  fontFamily: "Inter",
                ),
                majorGridLines: const MajorGridLines(color: Colors.transparent), // Color for major gridlines
                minorGridLines: const MinorGridLines(color: Colors.transparent),
              ),
              primaryYAxis: NumericAxis(
                labelStyle: TextStyle(
                  color: Theme.of(context).scaffoldBackgroundColor == const Color(0xFF323232) ?
                      const Color(0xFFFFFFFF)
                      : const Color(0xFF323232),
                  fontFamily: "Inter",
                ),
                majorGridLines: const MajorGridLines(color: Colors.transparent), // Color for major gridlines
                minorGridLines: const MinorGridLines(color: Colors.transparent),
              ),
              series: <ColumnSeries<Data, String>>[
                ColumnSeries<Data, String>(
                    dataSource: chartData,
                    xValueMapper: (Data data, _) => data.date,
                    yValueMapper: (Data data, _) => data.value,
                    width: 0.35,
                    dataLabelSettings: DataLabelSettings(
                        isVisible: true,
                        textStyle: TextStyle(
                          color: Theme.of(context).scaffoldBackgroundColor == const Color(0xFF323232) ?
                              const Color(0xFFFFFFFF)
                              : const Color(0xFF323232),
                          fontFamily: "Inter",
                        )
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    color: const Color(0xFF3FCC7C),
                    animationDuration: 1000
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.image,
                const SizedBox(width: 8.0), // Adjust the spacing as needed
                Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Base Goal\n",
                          style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 12,
                              color: Theme.of(context).scaffoldBackgroundColor == const Color(0xFF323232) ?
                                  const Color(0xFFFFFFFF)
                                  : const Color(0xFF323232),
                              fontWeight: FontWeight.w600
                          ),
                        ),
                        TextSpan(
                          text: "${widget.goal} ${widget.unit}", // Replace with your variable
                          style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).scaffoldBackgroundColor == const Color(0xFF323232) ?
                              const Color(0xFFFFFFFF)
                                  : const Color(0xFF323232),
                              fontWeight: FontWeight.w600
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
