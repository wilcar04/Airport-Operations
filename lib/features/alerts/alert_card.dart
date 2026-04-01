import 'package:airport_operations/app/colors.dart';
import 'package:airport_operations/domain/model/alert.dart';
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Alert card widget
// ---------------------------------------------------------------------------

/// A single alert card with colored left border, icon, title, and footer metrics.
class AlertCard extends StatelessWidget {
  const AlertCard({super.key, required this.data});

  final AlertData data;

  @override
  Widget build(BuildContext context) {
    final color = data.severity.color;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surfaceDeep,
        borderRadius: BorderRadius.circular(16),
        border: Border(
          left: BorderSide(color: color.withOpacity(0.4), width: 4),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 15,
            offset: Offset(0, 10),
          ),
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Main body ────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 20, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon container
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(data.severity.icon, color: color, size: 22),
                ),
                const SizedBox(width: 16),
                // Text content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Severity badge + timestamp
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.20),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              data.severity.label,
                              style: TextStyle(
                                color: color,
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.0,
                                height: 1.5,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            data.timeAgo,
                            style: const TextStyle(
                              color: Color(0xFF6F7588),
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              height: 1.33,
                            ),
                          ),
                          const SizedBox(width: 12),
                        ],
                      ),
                      const SizedBox(height: 4),
                      // Title
                      Text(
                        data.title,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          height: 1.55,
                        ),
                      ),
                      const SizedBox(height: 2),
                      // Description
                      Text(
                        data.description,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 1.625,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // ── Footer metrics row ────────────────────────────────────────────
          Container(
            padding: const EdgeInsets.fromLTRB(24, 17, 20, 20),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Color(0x0DFFFFFF), width: 1),
              ),
            ),
            child: Row(
              children:
                  data.metrics
                      .map(
                        (m) => Padding(
                          padding: const EdgeInsets.only(right: 24),
                          child: _MetricColumn(metric: m, fallbackColor: color),
                        ),
                      )
                      .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricColumn extends StatelessWidget {
  const _MetricColumn({required this.metric, required this.fallbackColor});

  final AlertMetric metric;
  final Color fallbackColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          metric.label.toUpperCase(),
          style: const TextStyle(
            color: Color(0xFF6F7588),
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
            height: 1.5,
          ),
        ),
        Text(
          metric.value,
          style: TextStyle(
            color: metric.valueColor ?? fallbackColor,
            fontSize: 18,
            fontWeight: FontWeight.w400,
            height: 1.55,
          ),
        ),
      ],
    );
  }
}
