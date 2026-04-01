import 'package:airport_operations/app/colors.dart';
import 'package:flutter/material.dart';

/// A single KPI card data model.
class KpiCardData {
  const KpiCardData({
    required this.icon,
    required this.value,
    required this.unit,
    required this.label,
    this.badge,
    this.badgeColor = AppColors.textGreen,
  });

  final IconData icon;
  final String value;
  final String? unit; // null if no unit suffix
  final String label;
  final String? badge; // e.g. "+8%" or "High"
  final Color badgeColor;
}
