import 'package:airport_operations/app/colors.dart';
import 'package:airport_operations/domain/model/kpi_card_data.dart';
import 'package:airport_operations/features/app_scaffold.dart';
import 'package:airport_operations/features/graphics/compare_trends_card.dart';
import 'package:airport_operations/features/graphics/trend_overview_card.dart';
import 'package:airport_operations/features/operations/operational_condition_banner.dart';
import 'package:airport_operations/features/operations/operations_hero_section.dart';
import 'package:airport_operations/features/operations/operations_kpi_grid_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Operations screen — composes all section widgets.
class OperationsScreen extends ConsumerWidget {
  const OperationsScreen({super.key});

  // Sample KPI data — replace with your real data providers.
  static const _kpiCards = [
    KpiCardData(
      icon: Icons.flight,
      value: '12',
      unit: null,
      label: 'Active Flights',
      badge: '+8%',
      badgeColor: AppColors.textGreen,
    ),
    KpiCardData(
      icon: Icons.visibility_outlined,
      value: '10',
      unit: 'km',
      label: 'Visibility Est.',
      badge: 'High',
      badgeColor: AppColors.textCyan,
    ),
    KpiCardData(
      icon: Icons.computer_outlined,
      value: '12.4',
      unit: 'kW',
      label: 'Workstations',
    ),
    KpiCardData(
      icon: Icons.lightbulb_outline,
      value: '8.1',
      unit: 'kW',
      label: 'Sector Lighting',
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      body: Stack(
        children: [
          // Background decorative blobs
          Positioned(
            left: -80,
            top: 413,
            child: _GlowBlob(
              color: AppColors.cyan.withOpacity(0.05),
              size: 256,
              blurRadius: 50,
            ),
          ),
          Positioned(
            right: -80,
            bottom: 413,
            child: _GlowBlob(
              color: AppColors.green.withOpacity(0.05),
              size: 320,
              blurRadius: 60,
            ),
          ),
          // Scrollable content
          SingleChildScrollView(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 64 + 24,
              left: 16,
              right: 16,
              bottom: 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                OperationsHeroSection(),
                SizedBox(height: 24),
                OperationsKpiGridSection(cards: _kpiCards),
                SizedBox(height: 24),
                OperationalConditionBanner(),
                SizedBox(height: 32),
                TrendOverviewCard(),
                SizedBox(height: 32),
                CompareTrendsCard(),
                SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Soft glowing circle used for background decoration.
class _GlowBlob extends StatelessWidget {
  const _GlowBlob({
    required this.color,
    required this.size,
    required this.blurRadius,
  });

  final Color color;
  final double size;
  final double blurRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        // Flutter doesn't have CSS blur on arbitrary widgets;
        // using boxShadow as the closest equivalent.
        boxShadow: [
          BoxShadow(
            color: color,
            blurRadius: blurRadius,
            spreadRadius: blurRadius / 2,
          ),
        ],
      ),
    );
  }
}
