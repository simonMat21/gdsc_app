import 'package:flutter/material.dart';

class ColorPickerWidget extends StatelessWidget {
  final String selectedColor;
  final Function(String) onColorChanged;

  const ColorPickerWidget({
    super.key,
    required this.selectedColor,
    required this.onColorChanged,
  });

  static const List<String> noteColors = [
    '#B3E8F5E9', // Light green - translucent
    '#B3F3E5F5', // Light purple - translucent
    '#B3FFF9C4', // Light yellow - translucent
    '#B3FFE0B2', // Light orange - translucent
    '#B3FFCCBC', // Light orange-red - translucent
    '#B3EF9A9A', // Light red - translucent
    '#B3F8BBD0', // Light pink - translucent
    '#B3B3E5FC', // Light blue - translucent
  ];

  static const List<Color> colorValues = [
    Color(0xB3E8F5E9), // Light green - translucent
    Color(0xB3F3E5F5), // Light purple - translucent
    Color(0xB3FFF9C4), // Light yellow - translucent
    Color(0xB3FFE0B2), // Light orange - translucent
    Color(0xB3FFCCBC), // Light orange-red - translucent
    Color(0xB3EF9A9A), // Light red - translucent
    Color(0xB3F8BBD0), // Light pink - translucent
    Color(0xB3B3E5FC), // Light blue - translucent
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: colorValues.length,
        itemBuilder: (context, index) {
          final color = colorValues[index];
          final hexColor = noteColors[index];
          final isSelected = selectedColor == hexColor;

          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () {
                onColorChanged(hexColor);
              },
              child: Container(
                width: 50,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? Colors.black : Colors.grey,
                    width: isSelected ? 3 : 1,
                  ),
                ),
                child: isSelected
                    ? const Icon(Icons.check, color: Colors.black54)
                    : null,
              ),
            ),
          );
        },
      ),
    );
  }
}
