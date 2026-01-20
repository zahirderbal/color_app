import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/drawing_provider.dart';
import '../utils/constants.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

/// Color picker widget that shows a basic palette and a custom color option
class ColorPicker extends StatelessWidget {
  const ColorPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DrawingProvider>(
      builder: (context, provider, child) {
        return Container(
          height: 90,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            // +1 for the custom color picker button
            itemCount: AppConstants.colorPalette.length + 1,
            itemBuilder: (context, index) {
              // Custom color picker button at the beginning
              if (index == 0) {
                return _buildCustomColorButton(context, provider);
              }

              final color = AppConstants.colorPalette[index - 1];
              final isSelected = provider.selectedColor == color;

              return GestureDetector(
                onTap: () => provider.setColor(color),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: isSelected ? 65 : 55,
                  height: isSelected ? 65 : 55,
                  margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? Colors.white : Colors.grey.shade200,
                      width: 3,
                    ),
                    boxShadow: [
                      if (isSelected)
                        BoxShadow(
                          color: color.withOpacity(0.5),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                    ],
                  ),
                  child: isSelected
                      ? const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 30,
                        )
                      : null,
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildCustomColorButton(BuildContext context, DrawingProvider provider) {
    // Check if the current selected color is NOT in the basic palette
    bool isCustomSelected = !AppConstants.colorPalette.contains(provider.selectedColor);

    return GestureDetector(
      onTap: () {
        _showFullColorPicker(context, provider);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: isCustomSelected ? 65 : 55,
        height: isCustomSelected ? 65 : 55,
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
          gradient: const SweepGradient(
            colors: [
              Colors.red,
              Colors.yellow,
              Colors.green,
              Colors.blue,
              Colors.purple,
              Colors.red,
            ],
          ),
          shape: BoxShape.circle,
          border: Border.all(
            color: isCustomSelected ? Colors.white : Colors.grey.shade200,
            width: 3,
          ),
          boxShadow: [
            if (isCustomSelected)
              BoxShadow(
                color: provider.selectedColor.withOpacity(0.5),
                blurRadius: 10,
                spreadRadius: 2,
              ),
          ],
        ),
        child: Icon(
          Icons.colorize_rounded,
          color: isCustomSelected ? Colors.white : Colors.white.withOpacity(0.9),
          size: 30,
        ),
      ),
    );
  }

  void _showFullColorPicker(BuildContext context, DrawingProvider provider) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('اختر لوناً مخصصاً', textAlign: TextAlign.center),
          content: SingleChildScrollView(
            child: HueRingPicker(
              pickerColor: provider.selectedColor,
              onColorChanged: (color) => provider.setColor(color),
              enableAlpha: false,
              displayThumbColor: true,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('حفظ'),
            ),
          ],
        );
      },
    );
  }
}
