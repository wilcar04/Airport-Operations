import 'package:airport_operations/app/colors.dart';
import 'package:flutter/material.dart';

/// Bottom navigation bar — Operations, Energy, Alerts.
///
/// Pass [currentIndex] and [onTap] to connect with your router/provider.
class AirportBottomNavBar extends StatelessWidget {
  const AirportBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  static const _items = [
    _NavItem(label: 'OPERATIONS', icon: Icons.grid_view_rounded),
    _NavItem(label: 'ENERGY', icon: Icons.bolt_outlined),
    _NavItem(label: 'ALERTS', icon: Icons.warning_amber_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
      child: BackdropFilter(
        filter: ColorFilter.matrix(const <double>[
          // identity — blur is handled via container decoration
          1, 0, 0, 0, 0,
          0, 1, 0, 0, 0,
          0, 0, 1, 0, 0,
          0, 0, 0, 1, 0,
        ]),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xCC080E1D), // rgba(8,14,29,0.8)
            border: const Border(
              top: BorderSide(color: AppColors.borderWhiteFaint, width: 1),
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x80000000),
                blurRadius: 30,
                offset: Offset(0, -10),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(31, 13, 31, 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  _items.length,
                  (i) => Expanded(
                    child: _NavBarItem(
                      item: _items[i],
                      isSelected: i == currentIndex,
                      onTap: () => onTap(i),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  const _NavItem({required this.label, required this.icon});
  final String label;
  final IconData icon;
}

class _NavBarItem extends StatelessWidget {
  const _NavBarItem({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  final _NavItem item;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.cyanDim : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          boxShadow:
              isSelected
                  ? const [
                    BoxShadow(
                      color: Color(0x333ADFFA),
                      blurRadius: 8,
                      spreadRadius: 0,
                      offset: Offset(0, 0),
                    ),
                  ]
                  : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              item.icon,
              size: 18,
              color: isSelected ? AppColors.cyan : AppColors.textSecondary,
            ),
            const SizedBox(height: 4),
            Text(
              item.label,
              style: TextStyle(
                color: isSelected ? AppColors.cyan : AppColors.textSecondary,
                fontSize: 10,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.0,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
