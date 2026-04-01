import 'package:airport_operations/app/colors.dart';
import 'package:flutter/material.dart';

/// Sector Energy Trend card — 24h bar chart with Total / Computers / Lighting toggle.
class EnergyTrendCard extends StatefulWidget {
  const EnergyTrendCard({super.key});

  @override
  State<EnergyTrendCard> createState() => _EnergyTrendCardState();
}

class _EnergyTrendCardState extends State<EnergyTrendCard> {
  int _selectedToggle = 0;
  static const _toggles = ['TOTAL', 'COMPUTERS', 'LIGHTING'];

  // Normalised bar heights (0–1) representing 24-hour load profile
  static const _bars = [
    0.50,
    0.625,
    0.5625,
    0.75,
    0.875,
    1.0,
    0.8125,
    0.6875,
    0.50,
  ];
  static const _timeLabels = ['06:00', '12:00', '18:00', '00:00'];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surfaceDeep,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          const Text(
            'Sector Energy Trend',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              height: 1.55,
            ),
          ),
          const Text(
            '24-hour operational load analysis',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w400,
              height: 1.33,
            ),
          ),
          const SizedBox(height: 16),
          // Toggle
          _SegmentedToggle(
            options: _toggles,
            selected: _selectedToggle,
            onChanged: (i) => setState(() => _selectedToggle = i),
          ),
          const SizedBox(height: 32),
          // Bar chart
          SizedBox(height: 240, child: _BarChart(bars: _bars)),
          const SizedBox(height: 8),
          // Time axis labels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:
                _timeLabels
                    .map(
                      (t) => Text(
                        t,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.0,
                          height: 1.5,
                        ),
                      ),
                    )
                    .toList(),
          ),
        ],
      ),
    );
  }
}

class _SegmentedToggle extends StatelessWidget {
  const _SegmentedToggle({
    required this.options,
    required this.selected,
    required this.onChanged,
  });

  final List<String> options;
  final int selected;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(options.length, (i) {
          final isActive = i == selected;
          return GestureDetector(
            onTap: () => onChanged(i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isActive ? const Color(0xFF00CBE6) : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                options[i],
                style: TextStyle(
                  color:
                      isActive
                          ? const Color(0xFF003D46)
                          : AppColors.textSecondary,
                  fontSize: 8,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  height: 1.875,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _BarChart extends StatelessWidget {
  const _BarChart({required this.bars});

  final List<double> bars;

  @override
  Widget build(BuildContext context) {
    // Opacity values matching the Figma design
    const opacities = [0.10, 0.20, 0.15, 0.30, 0.40, 0.50, 0.30, 0.20, 0.10];

    return Stack(
      children: [
        // Grid lines
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            4,
            (_) => Container(
              height: 1,
              width: double.infinity,
              color: Colors.white.withOpacity(0.1),
            ),
          ),
        ),
        // Bars
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: List.generate(bars.length, (i) {
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: i < bars.length - 1 ? 2 : 0),
                child: FractionallySizedBox(
                  heightFactor: bars[i],
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.cyan.withOpacity(opacities[i]),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(2),
                        topRight: Radius.circular(2),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
        // Trend line overlay (CustomPainter)
        CustomPaint(
          size: const Size(double.infinity, 240),
          painter: _TrendLinePainter(),
        ),
      ],
    );
  }
}

class _TrendLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = AppColors.cyan
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round;

    // Matches the SVG trend in the Figma design
    final points =
        [
          Offset(0.00, 0.78),
          Offset(0.12, 0.65),
          Offset(0.25, 0.55),
          Offset(0.37, 0.38),
          Offset(0.50, 0.20),
          Offset(0.62, 0.32),
          Offset(0.75, 0.50),
          Offset(0.87, 0.62),
          Offset(1.00, 0.72),
        ].map((p) => Offset(p.dx * size.width, p.dy * size.height)).toList();

    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (int i = 1; i < points.length; i++) {
      final p = points[i - 1];
      final n = points[i];
      path.cubicTo(
        p.dx + (n.dx - p.dx) / 2,
        p.dy,
        p.dx + (n.dx - p.dx) / 2,
        n.dy,
        n.dx,
        n.dy,
      );
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}
