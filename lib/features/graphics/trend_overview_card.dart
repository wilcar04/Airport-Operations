import 'package:airport_operations/app/colors.dart';
import 'package:flutter/material.dart';

/// Trend Overview card — selector chips + single-line chart placeholder.
///
/// For the actual chart, add the `fl_chart` package and replace
/// [_ChartPlaceholder] with a [LineChart] widget.
class TrendOverviewCard extends StatefulWidget {
  const TrendOverviewCard({super.key});

  @override
  State<TrendOverviewCard> createState() => _TrendOverviewCardState();
}

class _TrendOverviewCardState extends State<TrendOverviewCard> {
  int _selectedChip = 0;

  static const _chips = ['FLIGHTS', 'COMPUTER', 'LIGHTING', 'VISIBILITY'];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceDeep,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderSubtle, width: 1),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 25,
            offset: Offset(0, 20),
          ),
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 10,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          const Padding(
            padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Trend Overview',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Hourly behavior of selected variable',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 1.43,
                  ),
                ),
              ],
            ),
          ),
          // Selector chips
          _SelectorChips(
            chips: _chips,
            selected: _selectedChip,
            onSelected: (i) => setState(() => _selectedChip = i),
          ),
          // Chart area
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SizedBox(
              height: 256,
              child: _ChartPlaceholder(selectedLabel: _chips[_selectedChip]),
            ),
          ),
          // Footer
          _ChartFooter(
            icon: Icons.info_outline,
            iconColor: AppColors.cyan,
            text: 'Flight activity peaked at 10:00.',
            textColor: AppColors.cyan,
          ),
        ],
      ),
    );
  }
}

class _SelectorChips extends StatelessWidget {
  const _SelectorChips({
    required this.chips,
    required this.selected,
    required this.onSelected,
  });

  final List<String> chips;
  final int selected;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
        itemCount: chips.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final isActive = i == selected;
          return GestureDetector(
            onTap: () => onSelected(i),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isActive ? AppColors.cyan : AppColors.surfaceMid,
                borderRadius: BorderRadius.circular(9999),
                boxShadow:
                    isActive
                        ? const [
                          BoxShadow(color: AppColors.cyanGlow, blurRadius: 12),
                        ]
                        : null,
              ),
              child: Text(
                chips[i],
                style: TextStyle(
                  color:
                      isActive
                          ? const Color(0xFF004B56)
                          : AppColors.textSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w100,
                  letterSpacing: 0.6,
                  height: 1.33,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Replace this with a real fl_chart LineChart for production.
class _ChartPlaceholder extends StatelessWidget {
  const _ChartPlaceholder({required this.selectedLabel});

  final String selectedLabel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          size: const Size(double.infinity, 256),
          painter: _LineChartPainter(),
        ),
        // Tooltip
        Positioned(
          right: 0,
          top: 40,
          child: Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: const Color(0x66171F33),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0x333ADFFA), width: 1),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '10:00 AM',
                  style: TextStyle(
                    color: Color(0xFF1AD0EB),
                    fontSize: 10,
                    fontWeight: FontWeight.w300,
                    height: 1.5,
                  ),
                ),
                Text(
                  '18 flights',
                  style: TextStyle(
                    color: Color(0xFFE0E5FB),
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    height: 1.65,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Rough approximation of the Figma line chart using CustomPainter.
/// Swap with fl_chart for interactive, data-driven charts.
class _LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final fillPaint =
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.cyan.withOpacity(0.3),
              AppColors.cyan.withOpacity(0.0),
            ],
          ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final linePaint =
        Paint()
          ..color = AppColors.cyan
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round;

    // Sample data points (normalised 0–1)
    final points = [
      Offset(0.00, 0.70),
      Offset(0.10, 0.55),
      Offset(0.20, 0.30),
      Offset(0.30, 0.15),
      Offset(0.40, 0.35),
      Offset(0.50, 0.20), // peak at ~60%
      Offset(0.60, 0.08),
      Offset(0.70, 0.45),
      Offset(0.80, 0.60),
      Offset(0.90, 0.50),
      Offset(1.00, 0.65),
    ];

    final scaledPoints =
        points
            .map((p) => Offset(p.dx * size.width, p.dy * size.height))
            .toList();

    final path = Path()..moveTo(scaledPoints.first.dx, scaledPoints.first.dy);
    for (int i = 1; i < scaledPoints.length; i++) {
      final prev = scaledPoints[i - 1];
      final curr = scaledPoints[i];
      path.cubicTo(
        prev.dx + (curr.dx - prev.dx) / 2,
        prev.dy,
        prev.dx + (curr.dx - prev.dx) / 2,
        curr.dy,
        curr.dx,
        curr.dy,
      );
    }

    // Fill
    final fillPath =
        Path.from(path)
          ..lineTo(size.width, size.height)
          ..lineTo(0, size.height)
          ..close();
    canvas.drawPath(fillPath, fillPaint);

    // Line
    canvas.drawPath(path, linePaint);

    // Vertical indicator line at ~60%
    final indicatorPaint =
        Paint()
          ..color = AppColors.textPrimary.withOpacity(0.6)
          ..strokeWidth = 1;
    canvas.drawLine(
      Offset(size.width * 0.60, 0),
      Offset(size.width * 0.60, size.height),
      indicatorPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ChartFooter extends StatelessWidget {
  const _ChartFooter({
    required this.icon,
    required this.iconColor,
    required this.text,
    required this.textColor,
  });

  final IconData icon;
  final Color iconColor;
  final String text;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0x4D1D253B),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 14),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 14,
              fontWeight: FontWeight.w300,
              height: 1.43,
            ),
          ),
        ],
      ),
    );
  }
}
