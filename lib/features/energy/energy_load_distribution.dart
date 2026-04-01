import 'package:airport_operations/app/colors.dart';
import 'package:flutter/material.dart';

/// Load Distribution card — horizontal segmented bar + breakdown labels.
class EnergyLoadDistributionCard extends StatelessWidget {
  const EnergyLoadDistributionCard({
    super.key,
    this.computersKw = 12.4,
    this.lightingKw = 8.1,
  });

  final double computersKw;
  final double lightingKw;

  @override
  Widget build(BuildContext context) {
    final total = computersKw + lightingKw;
    final computerFraction = computersKw / total;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          const Text(
            'LOAD DISTRIBUTION',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.4,
              height: 1.43,
            ),
          ),
          const SizedBox(height: 24),
          // Segmented bar
          ClipRRect(
            borderRadius: BorderRadius.circular(9999),
            child: SizedBox(
              height: 16,
              child: Row(
                children: [
                  Expanded(
                    flex: (computerFraction * 1000).round(),
                    child: Container(color: AppColors.cyan),
                  ),
                  Expanded(
                    flex: ((1 - computerFraction) * 1000).round(),
                    child: Container(color: const Color(0xFF006C49)),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Labels
          Row(
            children: [
              Expanded(
                child: _DistributionLabel(
                  dotColor: AppColors.cyan,
                  label: 'COMPUTERS',
                  value: '${computersKw.toStringAsFixed(1)} kW',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _DistributionLabel(
                  dotColor: const Color(0xFF006C49),
                  label: 'LIGHTING',
                  value: '${lightingKw.toStringAsFixed(1)} kW',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DistributionLabel extends StatelessWidget {
  const _DistributionLabel({
    required this.dotColor,
    required this.label,
    required this.value,
  });

  final Color dotColor;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 10,
                fontWeight: FontWeight.w700,
                height: 1.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Color(0xFFE0E5FB),
            fontSize: 18,
            fontWeight: FontWeight.w500,
            height: 1.55,
          ),
        ),
      ],
    );
  }
}
