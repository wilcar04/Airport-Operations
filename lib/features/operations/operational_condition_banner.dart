import 'package:airport_operations/app/colors.dart';
import 'package:flutter/material.dart';

/// Full-width alert/banner showing current operational condition.
class OperationalConditionBanner extends StatelessWidget {
  const OperationalConditionBanner({
    super.key,
    this.title = 'Normal Monitoring Load',
    this.description =
        'Airport activity is elevated and workstation consumption is consistent with supervision demand.',
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: AppColors.cyanDim,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderCyan, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Info / radar icon
          const Icon(Icons.radar, color: AppColors.cyan, size: 26),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.toUpperCase(),
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.4,
                    height: 1.43,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    height: 1.625,
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
