import 'package:airport_operations/app/colors.dart';
import 'package:airport_operations/domain/model/alert.dart';
import 'package:airport_operations/features/alerts/alert_card.dart';
import 'package:airport_operations/features/app_scaffold.dart';
import 'package:airport_operations/features/widgets/hero_header_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AlertsScreen extends ConsumerStatefulWidget {
  const AlertsScreen({super.key});

  @override
  ConsumerState<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends ConsumerState<AlertsScreen> {
  int _filterIndex = 0; // 0=All, 1=Critical, 2=Warnings, 3=Info

  static const _filters = ['All', 'Critical', 'Warnings', 'Info'];

  // ── Alert data ────────────────────────────────────────────────────────────

  static const _allAlerts = [
    AlertData(
      severity: AlertSeverity.critical,
      title: 'Monitoring Load Mismatch',
      description:
          'High traffic with low workstation activity. Monitoring capacity may be insufficient.',
      timeAgo: '5 min ago',
      metrics: [
        AlertMetric(label: 'Computer Energy', value: '0.9 kWh'),
        AlertMetric(
          label: 'Active Flights',
          value: '22',
          valueColor: Color(0xFFE0E5FB),
        ),
      ],
    ),
    AlertData(
      severity: AlertSeverity.warning,
      title: 'Reduced Visibility',
      description: 'Low visibility may increase monitoring demand.',
      timeAgo: '22 min ago',
      metrics: [
        AlertMetric(label: 'Visibility', value: '1.2 km'),
        AlertMetric(
          label: 'Active Flights',
          value: '14',
          valueColor: Color(0xFFE0E5FB),
        ),
      ],
    ),
    AlertData(
      severity: AlertSeverity.info,
      title: 'Traffic Peak Detected',
      description: 'Flight activity is rising as expected.',
      timeAgo: '30 min ago',
      metrics: [
        AlertMetric(label: 'Active Flights', value: '18'),
        AlertMetric(
          label: 'Computer Energy',
          value: '2.4 kWh',
          valueColor: Color(0xFFE0E5FB),
        ),
      ],
    ),
    AlertData(
      severity: AlertSeverity.warning,
      title: 'Lighting Inefficiency',
      description: 'High lighting load during low activity.',
      timeAgo: '1 hour ago',
      metrics: [
        AlertMetric(label: 'Lighting Energy', value: '2.8 kWh'),
        AlertMetric(
          label: 'Active Flights',
          value: '5',
          valueColor: Color(0xFFE0E5FB),
        ),
      ],
    ),
    AlertData(
      severity: AlertSeverity.info,
      title: 'Stable Visibility',
      description: 'Visibility remains within normal range.',
      timeAgo: '2 hours ago',
      metrics: [
        AlertMetric(label: 'Visibility', value: '6.5 km'),
        AlertMetric(
          label: 'Active Flights',
          value: '11',
          valueColor: Color(0xFFE0E5FB),
        ),
      ],
    ),
  ];

  List<AlertData> get _filtered {
    switch (_filterIndex) {
      case 1:
        return _allAlerts
            .where((a) => a.severity == AlertSeverity.critical)
            .toList();
      case 2:
        return _allAlerts
            .where((a) => a.severity == AlertSeverity.warning)
            .toList();
      case 3:
        return _allAlerts
            .where((a) => a.severity == AlertSeverity.info)
            .toList();
      default:
        return _allAlerts;
    }
  }

  // ── Counts for header badges ──────────────────────────────────────────────

  int get _criticalCount =>
      _allAlerts.where((a) => a.severity == AlertSeverity.critical).length;
  int get _warningCount =>
      _allAlerts.where((a) => a.severity == AlertSeverity.warning).length;
  int get _infoCount =>
      _allAlerts.where((a) => a.severity == AlertSeverity.info).length;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SingleChildScrollView(
        padding: screenContentPadding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero header — reuses the refactored generic widget
            HeroHeaderSection(
              title: 'Alerts',
              subtitle: 'Operations Monitoring Sector',
              badges: [
                HeroBadge(
                  label: '$_criticalCount Critical',
                  color: const Color(0xFFFC4563),
                ),
                HeroBadge(
                  label: '$_warningCount Warnings',
                  color: const Color(0xFFFF8B6F),
                ),
                HeroBadge(label: '$_infoCount Info', color: AppColors.cyan),
              ],
            ),
            const SizedBox(height: 16),

            // Filter chips
            _FilterChips(
              filters: _filters,
              selected: _filterIndex,
              onSelected: (i) => setState(() => _filterIndex = i),
            ),
            const SizedBox(height: 32),

            // Alert list
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _filtered.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (_, i) => AlertCard(data: _filtered[i]),
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Filter chips row
// ---------------------------------------------------------------------------

class _FilterChips extends StatelessWidget {
  const _FilterChips({
    required this.filters,
    required this.selected,
    required this.onSelected,
  });

  final List<String> filters;
  final int selected;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(filters.length, (i) {
          final isActive = i == selected;
          return Padding(
            padding: EdgeInsets.only(right: i < filters.length - 1 ? 10 : 0),
            child: GestureDetector(
              onTap: () => onSelected(i),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 9,
                ),
                decoration: BoxDecoration(
                  color: isActive ? AppColors.cyan : AppColors.surface,
                  borderRadius: BorderRadius.circular(9999),
                  border:
                      isActive
                          ? null
                          : Border.all(
                            color: const Color(0x1A424859),
                            width: 1,
                          ),
                  boxShadow:
                      isActive
                          ? const [
                            BoxShadow(color: Color(0x4D3ADFFA), blurRadius: 15),
                          ]
                          : null,
                ),
                child: Text(
                  filters[i],
                  style: TextStyle(
                    color:
                        isActive
                            ? const Color(0xFF004B56)
                            : AppColors.textSecondary,
                    fontSize: 14,
                    fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                    height: 1.43,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
