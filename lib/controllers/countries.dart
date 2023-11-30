import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';

class CountryDropdown extends StatelessWidget {
  final Country? selectedCountry;
  final ValueChanged<Country?> onCountryChanged;

  const CountryDropdown({super.key, required this.selectedCountry, required this.onCountryChanged});

  void _openCountryPicker(BuildContext context) {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      onSelect: (Country country) {
        onCountryChanged(country);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openCountryPicker(context),
      child: Row(
        children: <Widget>[
          Text(
            selectedCountry?.flagEmoji ?? '', // Display the flag emoji
            style: const TextStyle(fontSize: 17), // Adjust the font size as needed
          ),
          const SizedBox(width: 8.0),
          Text(
            selectedCountry?.name ?? "Select Country",
            style: const TextStyle(
              fontSize: 17.0
            ),
          ),
          const SizedBox(width: 30),
          const Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }
}