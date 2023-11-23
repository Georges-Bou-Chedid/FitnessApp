import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SummaryDatePicker extends StatefulWidget {
  const SummaryDatePicker({super.key});

  @override
  SummaryDatePickerState createState() => SummaryDatePickerState();
}

class SummaryDatePickerState extends State<SummaryDatePicker> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    )) ?? DateTime.now();

    if (picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      decoration: Theme.of(context).scaffoldBackgroundColor == const Color(0xFF323232) ?
          BoxDecoration(
            borderRadius: BorderRadius.circular(60.0),
            border: Border.all(
              color: Colors.white54, // Set the border color here
              width: 1.0, // Set the border width here
            ),
          )
          : BoxDecoration(
            borderRadius: BorderRadius.circular(60.0),
            border: Border.all(
              color: Colors.black12, // Set the border color here
              width: 1.0, // Set the border width here
            ),
      ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: const Icon(EvaIcons.chevronLeftOutline, size: 16),
              onPressed: () {
                setState(() {
                  selectedDate = selectedDate.subtract(const Duration(days: 1));
                });
              },
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: const Icon(
                    Icons.calendar_today, // Replace with the calendar icon you want to use
                    size: 15,
                  ),
                ),
                const SizedBox(width: 5),
                InkWell(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: Text(
                    formatDate(selectedDate),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Inter"
                    ),
                  ),
                ),
              ],
            ),
            IconButton(
              icon: const Icon(EvaIcons.chevronRightOutline, size: 16),
              onPressed: () {
                setState(() {
                  selectedDate = selectedDate.add(const Duration(days: 1));
                });
              },
            ),
          ],
        )
    );
  }
}

String formatDate(DateTime date) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = today.subtract(Duration(days: 1));
  final tomorrow = today.add(Duration(days: 1));

  if (date.isAtSameMomentAs(today)) {
    return 'Today';
  } else if (date.isAtSameMomentAs(yesterday)) {
    return 'Yesterday';
  } else if (date.isAtSameMomentAs(tomorrow)) {
    return 'Tomorrow';
  } else {
    final formatter = DateFormat('EEE, d MMM');
    return formatter.format(date);
  }
}
