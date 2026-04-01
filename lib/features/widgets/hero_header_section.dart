import 'package:airport_operations/app/colors.dart';
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Badge model
// ---------------------------------------------------------------------------

/// A single pill badge shown below the title in the hero header.
class HeroBadge {
  const HeroBadge({required this.label, required this.color});

  final String label;

  /// The accent color used for the dot, text, border, and background tint.
  final Color color;
}

// ---------------------------------------------------------------------------
// Widget
// ---------------------------------------------------------------------------

/// Generic hero header used on every screen.
///
/// ```dart
/// HeroHeaderSection(
///   title: 'Airport Operations',
///   subtitle: 'Operations Monitoring Sector',
///   badges: [HeroBadge(label: 'Normal', color: AppColors.green)],
/// )
/// ```
class HeroHeaderSection extends StatelessWidget {
  const HeroHeaderSection({
    super.key,
    required this.title,
    required this.subtitle,
    required this.badges,
  });

  final String title;
  final String subtitle;

  /// One or more pill badges rendered in a horizontal row.
  final List<HeroBadge> badges;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 30,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.75,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle.toUpperCase(),
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w400,
              letterSpacing: 1.8,
              height: 1.33,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: badges.map((b) => _HeroBadgePill(badge: b)).toList(),
          ),
        ],
      ),
    );
  }
}

class _HeroBadgePill extends StatelessWidget {
  const _HeroBadgePill({required this.badge});

  final HeroBadge badge;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 9),
      decoration: BoxDecoration(
        color: badge.color.withOpacity(0.10),
        borderRadius: BorderRadius.circular(9999),
        border: Border.all(color: badge.color.withOpacity(0.20), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: badge.color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            badge.label.toUpperCase(),
            style: TextStyle(
              color: badge.color,
              fontSize: 10,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.0,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
