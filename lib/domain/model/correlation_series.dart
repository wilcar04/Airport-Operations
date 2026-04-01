import 'package:flutter/material.dart';

/// Data model for a series displayed in the correlation chart.
class CorrelationSeries {
  const CorrelationSeries({
    required this.label,
    required this.color,
    this.dashed = false,
    required this.points,
  });

  final String label;
  final Color color;
  final bool dashed;

  /// Normalised Y values (0 = top, 1 = bottom) for each X step.
  final List<double> points;
}
