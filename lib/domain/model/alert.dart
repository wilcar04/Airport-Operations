import 'package:airport_operations/app/colors.dart';
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Severity enum
// ---------------------------------------------------------------------------

enum AlertSeverity { critical, warning, info }

extension AlertSeverityStyle on AlertSeverity {
  Color get color {
    switch (this) {
      case AlertSeverity.critical:
        return AppColors.critical;
      case AlertSeverity.warning:
        return AppColors.warning;
      case AlertSeverity.info:
        return AppColors.cyan;
    }
  }

  String get label {
    switch (this) {
      case AlertSeverity.critical:
        return 'CRITICAL';
      case AlertSeverity.warning:
        return 'WARNING';
      case AlertSeverity.info:
        return 'INFO';
    }
  }

  IconData get icon {
    switch (this) {
      case AlertSeverity.critical:
        return Icons.error_outline;
      case AlertSeverity.warning:
        return Icons.cloud_outlined;
      case AlertSeverity.info:
        return Icons.info_outline;
    }
  }
}

// ---------------------------------------------------------------------------
// Data model
// ---------------------------------------------------------------------------

/// A single alert entry.
class AlertData {
  const AlertData({
    required this.severity,
    required this.title,
    required this.description,
    required this.timeAgo,
    required this.metrics,
  });

  final AlertSeverity severity;
  final String title;
  final String description;
  final String timeAgo;

  /// Up to 2 key-value pairs shown in the footer row.
  final List<AlertMetric> metrics;
}

/// A single metric shown in the alert card footer.
class AlertMetric {
  const AlertMetric({
    required this.label,
    required this.value,
    this.valueColor,
  });

  final String label;
  final String value;

  /// Defaults to the severity accent color when null.
  final Color? valueColor;
}
