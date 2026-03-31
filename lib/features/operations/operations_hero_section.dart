import 'package:airport_operations/app/colors.dart';
import 'package:flutter/material.dart';

/// Hero header — title, subtitle, and operational status badge.
class OperationsHeroSection extends StatelessWidget {
  const OperationsHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          const Text(
            'Airport Operations',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 30,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.75,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 4),
          // Subtitle
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
          // Status badge
          _StatusBadge(),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 9),
      decoration: BoxDecoration(
        color: const Color(0x1A006C49), // rgba(0,108,73,0.1)
        borderRadius: BorderRadius.circular(9999),
        border: Border.all(color: AppColors.borderGreen, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Green dot
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
            'NORMAL',
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
    );
  }
}
