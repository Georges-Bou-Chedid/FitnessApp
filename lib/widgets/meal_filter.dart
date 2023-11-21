import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class MealFilter extends StatefulWidget {
  final List<String> filterOptions;

  const MealFilter({super.key,
    required this.filterOptions,
  });

  @override
  _MealFilterState createState() => _MealFilterState();
}

class _MealFilterState extends State<MealFilter> {
  String selectedOption = 'All';

  void selectItem(String option) {
    setState(() {
      selectedOption = option;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 130, // Set the desired width
        child: DropdownButton<String>(
          dropdownColor: const Color(0xFF323232),
          value: selectedOption,
          onChanged: (String? newValue) {
            selectItem(newValue!);
          },
          isExpanded: true,
          icon: const Icon(EvaIcons.arrowDownOutline, color: Color(0xFFFFFFFF), size: 18),
          items: widget.filterOptions.map((String option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(
                option,
                style: const TextStyle(
                  fontFamily: "Inter",
                  fontSize: 13
                ),
              ),
            );
          }).toList(),
        ),
    );
  }
}
