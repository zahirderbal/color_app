import 'package:flutter/material.dart';

/// Represents a single point in the drawing
class DrawingPoint {
  final Offset offset;
  final Color color;
  final double strokeWidth;

  DrawingPoint({
    required this.offset,
    required this.color,
    required this.strokeWidth,
  });

  Map<String, dynamic> toJson() {
    return {
      'x': offset.dx,
      'y': offset.dy,
      'color': color.value,
      'strokeWidth': strokeWidth,
    };
  }

  factory DrawingPoint.fromJson(Map<String, dynamic> json) {
    return DrawingPoint(
      offset: Offset(json['x'], json['y']),
      color: Color(json['color']),
      strokeWidth: json['strokeWidth'],
    );
  }
}
