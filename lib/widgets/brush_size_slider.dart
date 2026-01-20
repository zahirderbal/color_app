import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/drawing_provider.dart';
import '../utils/constants.dart';

/// Brush size slider widget
class BrushSizeSlider extends StatelessWidget {
  const BrushSizeSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DrawingProvider>(
      builder: (context, provider, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.brush, size: 20),
              const SizedBox(width: 10),
              SizedBox(
                width: 150,
                child: Slider(
                  value: provider.strokeWidth,
                  min: AppConstants.minStrokeWidth,
                  max: AppConstants.maxStrokeWidth,
                  divisions: 18,
                  activeColor: AppConstants.primaryColor,
                  onChanged: (value) => provider.setStrokeWidth(value),
                ),
              ),
              Text(
                '${provider.strokeWidth.toInt()}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
