import 'package:airport_operations/app/colors.dart';
import 'package:flutter/material.dart';

/// Top app bar — "AIRPORT OPERATIONS" header with logo icon.
class AirportTopBar extends StatelessWidget implements PreferredSizeWidget {
  const AirportTopBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF0C1324), AppColors.background],
        ),
        boxShadow: [BoxShadow(color: Color(0x0F3ADFFA), blurRadius: 20)],
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              // Logo icon placeholder — swap with your SVG/image asset
              const Icon(Icons.flight_takeoff, color: AppColors.cyan, size: 20),
              const SizedBox(width: 12),
              const Text(
                'AIRPORT OPERATIONS',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.4,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
