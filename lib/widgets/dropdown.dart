import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> items;

  CustomDropdown({required this.items});

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String selectedValue = 'All';
  bool isDropdownOpen = false;

  void toggleDropdown() {
    setState(() {
      isDropdownOpen = !isDropdownOpen;
    });
  }

  void selectItem(String item) {
    setState(() {
      selectedValue = item;
      isDropdownOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Center(
          child: GestureDetector(
            onTap: toggleDropdown,
            child: Container(
              width: 150,
              height: 40,
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                // borderRadius: BorderRadius.circular(30.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedValue,
                    style: const TextStyle(
                      color: Color(0xFF323232),
                      fontSize: 13,
                      fontFamily: "Inter"
                    ),
                  ),
                  Icon(
                    isDropdownOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                    color: const Color(0xFF323232),
                  ),
                ],
              ),
            ),
          ),
        ),
        // const SizedBox(height: 2),
        if (isDropdownOpen)
          Container(
            width: 150,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              // borderRadius: BorderRadius.circular(30.0),
            ),
            child: Column(
              children: widget.items.map((item) {
                return InkWell(
                  onTap: () {
                    selectItem(item);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      item,
                      style: TextStyle(
                        color: selectedValue == item
                            ? const Color(0xFF5AC8FA) // Highlight the selected item
                            : const Color(0xFF323232),
                        fontSize: 13,
                        fontFamily: "Inter"
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}
