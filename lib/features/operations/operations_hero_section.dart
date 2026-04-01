import 'package:airport_operations/app/colors.dart';
import 'package:airport_operations/features/widgets/hero_header_section.dart';
import 'package:flutter/material.dart';

/// Hero header — title, subtitle, and operational status badge.
class OperationsHeroSection extends StatelessWidget {
  const OperationsHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return HeroHeaderSection(
      title: "Airport Operations",
      subtitle: "OPERATIONS MONITORING SECTOR",
      badges: [HeroBadge(label: 'NORMAL', color: AppColors.green)],
    );
  }
}
