import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/drawing_provider.dart';

class DrawingCanvas extends StatelessWidget {
  const DrawingCanvas({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DrawingProvider>(
      builder: (context, provider, child) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final canvasSize = Size(constraints.maxWidth, constraints.maxHeight);
            
            return GestureDetector(
              onTapUp: (details) {
                provider.handleTap(details.localPosition, canvasSize);
              },
              onPanUpdate: (details) {
                provider.performStroke(details.localPosition, canvasSize);
              },
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.white,
                child: provider.canvasImage != null
                    ? RawImage(
                        image: provider.canvasImage,
                        fit: BoxFit.contain,
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
            );
          },
        );
      },
    );
  }
}
