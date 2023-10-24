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
        GestureDetector(
          onTap: toggleDropdown,
          child: Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.cyan, Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedValue,
                  style: const TextStyle(
                    color: Colors.black
                  ),
                ),
                Icon(
                  isDropdownOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: Colors.black
                ),
              ],
            ),
          ),
        ),
        if (isDropdownOpen)
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
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
                            ? Colors.cyan // Highlight the selected item
                            : Colors.black,
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
