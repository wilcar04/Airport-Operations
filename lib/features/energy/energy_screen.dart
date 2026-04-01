import 'package:airport_operations/app/colors.dart';
import 'package:airport_operations/domain/model/correlation_series.dart';
import 'package:airport_operations/domain/model/kpi_card_data.dart';
import 'package:airport_operations/domain/model/y_axis_label.dart';
import 'package:airport_operations/features/app_scaffold.dart';
import 'package:airport_operations/features/energy/energy_correlation_card.dart';
import 'package:airport_operations/features/energy/energy_load_distribution.dart';
import 'package:airport_operations/features/energy/energy_trend_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Shared nav provider

/// Energy & Infrastructure screen.
class EnergyScreen extends ConsumerWidget {
  const EnergyScreen({super.key});

  // ── KPI Cards ──────────────────────────────────────────────────────────────
  static const _kpiCards = [
    KpiCardData(
      icon: Icons.bolt,
      value: '20.5',
      unit: 'kW',
      label: 'Total Consumption',
      badge: 'Live Load',
      badgeColor: AppColors.textSecondary,
    ),
    KpiCardData(
      icon: Icons.computer_outlined,
      value: '12.4',
      unit: 'kW',
      label: 'Workstations',
      badge: '60% Share',
      badgeColor: AppColors.textGreen,
    ),
    KpiCardData(
      icon: Icons.lightbulb_outline,
      value: '8.1',
      unit: 'kW',
      label: 'Infrastructure Lighting',
      badge: '40% Share',
      badgeColor: AppColors.textCyan,
    ),
    // Efficiency card uses a green left border accent — handled via [_EfficiencyCard].
  ];

  // ── Correlation series data ─────────────────────────────────────────────────
  static final _flightsVsComputerSeries = [
    CorrelationSeries(
      label: 'Flights',
      color: AppColors.cyan,
      points: [0.55, 0.35, 0.20, 0.40, 0.25, 0.50, 0.35, 0.60, 0.45],
    ),
    CorrelationSeries(
      label: 'Computer',
      color: AppColors.green,
      dashed: true,
      points: [0.65, 0.45, 0.30, 0.50, 0.35, 0.55, 0.45, 0.65, 0.55],
    ),
  ];

  static final _flightsVsLightingSeries = [
    CorrelationSeries(
      label: 'Flights',
      color: AppColors.cyan,
      points: [0.50, 0.30, 0.25, 0.45, 0.30, 0.55, 0.40, 0.55, 0.50],
    ),
    CorrelationSeries(
      label: 'Lighting',
      color: AppColors.green,
      dashed: true,
      points: [0.60, 0.50, 0.40, 0.55, 0.45, 0.60, 0.50, 0.65, 0.55],
    ),
  ];

  static final _visibilityVsComputerSeries = [
    CorrelationSeries(
      label: 'Visibility (Distance)',
      color: AppColors.green,
      points: [0.25, 0.35, 0.50, 0.30, 0.55, 0.40, 0.60, 0.45, 0.55],
    ),
    CorrelationSeries(
      label: 'Computer',
      color: AppColors.cyan,
      points: [0.55, 0.45, 0.35, 0.50, 0.30, 0.55, 0.40, 0.60, 0.50],
    ),
  ];

  static final _visibilityVsLightingSeries = [
    CorrelationSeries(
      label: 'Visibility (Distance)',
      color: AppColors.green,
      points: [0.30, 0.40, 0.55, 0.35, 0.50, 0.45, 0.60, 0.50, 0.55],
    ),
    CorrelationSeries(
      label: 'Lighting',
      color: AppColors.cyan,
      points: [0.60, 0.50, 0.40, 0.55, 0.40, 0.60, 0.45, 0.65, 0.55],
    ),
  ];

  static const _visibilityYAxis = [
    YAxisLabel('10 KM', 0.0),
    YAxisLabel('5 KM', 0.5),
    YAxisLabel('0 KM', 1.0),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 64 + 24,
          left: 16,
          right: 16,
          bottom: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero header — reused, different title/subtitle/badge
            const _EnergyHeroHeader(),
            const SizedBox(height: 24),

            // 2×2 KPI grid — three standard cards + one custom efficiency card
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.1,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                // Reusing _KpiCard-equivalent via KpiGridSection's internal widget
                // by building individual cards inline:
                _StandardKpiCard(
                  icon: Icons.bolt,
                  value: '20.5',
                  unit: 'kW',
                  unitColor: AppColors.cyan,
                  label: 'TOTAL CONSUMPTION',
                  badge: 'LIVE LOAD',
                  badgeColor: AppColors.textSecondary,
                ),
                _StandardKpiCard(
                  icon: Icons.computer_outlined,
                  value: '12.4',
                  unit: 'kW',
                  unitColor: AppColors.textSecondary,
                  label: 'WORKSTATIONS',
                  badge: '60% SHARE',
                  badgeColor: AppColors.textGreen,
                ),
                _StandardKpiCard(
                  icon: Icons.lightbulb_outline,
                  value: '8.1',
                  unit: 'kW',
                  unitColor: AppColors.textSecondary,
                  label: 'INFRASTRUCTURE\nLIGHTING',
                  badge: '40% SHARE',
                  badgeColor: AppColors.textCyan,
                ),
                _EfficiencyCard(
                  score: 92,
                  maxScore: 100,
                  label: 'OPERATIONAL SCORE',
                  badge: 'HIGH EFFICIENCY',
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Sector Energy Trend bar chart
            const EnergyTrendCard(),
            const SizedBox(height: 24),

            // Load Distribution
            const EnergyLoadDistributionCard(
              computersKw: 12.4,
              lightingKw: 8.1,
            ),
            const SizedBox(height: 24),

            // Compare Trends correlation card
            EnergyCorrelationCard(
              icon: Icons.show_chart,
              title: 'Compare Trends',
              badgeLabel: 'Live Analysis',
              presets: const ['FLIGHTS VS COMPUTER', 'FLIGHTS VS LIGHTING'],
              seriesPerPreset: [
                _flightsVsComputerSeries,
                _flightsVsLightingSeries,
              ],
              insightText: 'Computer energy increased with flight activity.',
            ),
            const SizedBox(height: 24),

            // Visibility Impact correlation card
            EnergyCorrelationCard(
              icon: Icons.visibility_outlined,
              title: 'Visibility Impact',
              badgeLabel: 'Analysis',
              presets: const [
                'VISIBILITY VS COMPUTER',
                'VISIBILITY VS LIGHTING',
              ],
              seriesPerPreset: [
                _visibilityVsComputerSeries,
                _visibilityVsLightingSeries,
              ],
              yAxisLabels: _visibilityYAxis,
              insightText:
                  'Reduced visibility coincided with higher workstation use.',
            ),
          ],
        ),
      ),
    );
  }
}

// ── Energy-specific Hero Header ───────────────────────────────────────────────
// Reuses the same visual pattern as HeroHeaderSection but with different copy.
// Rather than modifying the shared widget we compose a local version here so
// the Operations screen is unaffected.

class _EnergyHeroHeader extends StatelessWidget {
  const _EnergyHeroHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Energy & Infrastructure',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 30,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.75,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'OPERATIONS MONITORING SECTOR',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w400,
              letterSpacing: 1.8,
              height: 1.33,
            ),
          ),
          const SizedBox(height: 16),
          // Status badge — "EFFICIENT"
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 9),
            decoration: BoxDecoration(
              color: const Color(0x1A006C49),
              borderRadius: BorderRadius.circular(9999),
              border: Border.all(color: AppColors.borderGreen, width: 1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.green,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'EFFICIENT',
                  style: TextStyle(
                    color: AppColors.textGreen,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── KPI card variants ─────────────────────────────────────────────────────────

class _StandardKpiCard extends StatelessWidget {
  const _StandardKpiCard({
    required this.icon,
    required this.value,
    required this.unit,
    required this.unitColor,
    required this.label,
    this.badge,
    this.badgeColor = AppColors.textSecondary,
  });

  final IconData icon;
  final String value;
  final String unit;
  final Color unitColor;
  final String label;
  final String? badge;
  final Color badgeColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Color(0x0F3ADFFA), blurRadius: 20)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.textSecondary, size: 20),
              const Spacer(),
              if (badge != null)
                Text(
                  badge!,
                  style: TextStyle(
                    color: badgeColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                  ),
                ),
            ],
          ),
          const Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  height: 1.2,
                ),
              ),
              const SizedBox(width: 4),
              Padding(
                padding: const EdgeInsets.only(bottom: 1),
                child: Text(
                  unit,
                  style: TextStyle(
                    color: unitColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    height: 1.55,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 10,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.5,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

/// Efficiency card — has a green left border accent and a /100 score display.
class _EfficiencyCard extends StatelessWidget {
  const _EfficiencyCard({
    required this.score,
    required this.maxScore,
    required this.label,
    required this.badge,
  });

  final int score;
  final int maxScore;
  final String label;
  final String badge;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: const Border(
          left: BorderSide(color: AppColors.green, width: 4),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 20, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.speed_outlined,
                  color: AppColors.textSecondary,
                  size: 22,
                ),
                const Spacer(),
                Text(
                  badge,
                  style: const TextStyle(
                    color: AppColors.textGreen,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '$score',
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    height: 1.2,
                  ),
                ),
                const SizedBox(width: 4),
                Padding(
                  padding: const EdgeInsets.only(bottom: 1),
                  child: Text(
                    '/$maxScore',
                    style: const TextStyle(
                      color: AppColors.textGreen,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      height: 1.55,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 10,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.5,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
