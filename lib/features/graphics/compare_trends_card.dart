import 'package:airport_operations/app/colors.dart';
import 'package:flutter/material.dart';

/// Compare Trends card — preset chips + dual-line chart placeholder.
class CompareTrendsCard extends StatefulWidget {
  const CompareTrendsCard({super.key});

  @override
  State<CompareTrendsCard> createState() => _CompareTrendsCardState();
}

class _CompareTrendsCardState extends State<CompareTrendsCard> {
  int _selectedPreset = 0;

  static const _presets = [
    'FLIGHTS\nVS\nCOMPUTER',
    'FLIGHTS\nVS\nLIGHTING',
    'VISIBILITY\nVS\nCOMPUTER',
  ];

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
                  'Compare Trends',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Relationship between operational and energy variables',
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
          // Preset chips
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
            child: Row(
              children: List.generate(_presets.length, (i) {
                final isActive = i == _selectedPreset;
                return Padding(
                  padding: EdgeInsets.only(
                    right: i < _presets.length - 1 ? 8 : 0,
                  ),
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedPreset = i),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceMid,
                        borderRadius: BorderRadius.circular(8),
                        border:
                            isActive
                                ? Border.all(
                                  color: AppColors.borderCyanMed,
                                  width: 1,
                                )
                                : null,
                      ),
                      child: Text(
                        _presets[i],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color:
                              isActive
                                  ? AppColors.textCyan
                                  : AppColors.textSecondary,
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.25,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          // Dual line chart
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
            child: SizedBox(
              height: 256,
              child: Stack(
                children: [
                  CustomPaint(
                    size: const Size(double.infinity, 256),
                    painter: _DualLineChartPainter(),
                  ),
                  // Legend
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _LegendItem(
                          label: 'ACTIVE FLIGHTS',
                          color: AppColors.cyan,
                          dashed: false,
                        ),
                        const SizedBox(height: 4),
                        _LegendItem(
                          label: 'COMPUTER ENERGY',
                          color: AppColors.green,
                          dashed: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Disclaimer text
          const Padding(
            padding: EdgeInsets.fromLTRB(24, 4, 24, 0),
            child: Text(
              'Comparison shown as relative trend.',
              style: TextStyle(
                color: Color(0x99A5AABF),
                fontSize: 10,
                fontWeight: FontWeight.w100,
                height: 1.5,
              ),
            ),
          ),
          // Footer
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            margin: const EdgeInsets.only(top: 16),
            decoration: const BoxDecoration(
              color: Color(0x4D1D253B),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.info_outline,
                  color: AppColors.green,
                  size: 14,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Computer energy increased with flight activity.',
                    style: const TextStyle(
                      color: AppColors.textGreen,
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      height: 1.43,
                    ),
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

class _LegendItem extends StatelessWidget {
  const _LegendItem({
    required this.label,
    required this.color,
    required this.dashed,
  });

  final String label;
  final Color color;
  final bool dashed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 9,
            fontWeight: FontWeight.w200,
            letterSpacing: 0.9,
            height: 1.5,
          ),
        ),
        const SizedBox(width: 8),
        dashed
            ? _DashedLine(color: color)
            : Container(width: 32, height: 2, color: color),
      ],
    );
  }
}

class _DashedLine extends StatelessWidget {
  const _DashedLine({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32,
      height: 2,
      child: CustomPaint(painter: _DashedLinePainter(color: color)),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  _DashedLinePainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..strokeWidth = 2;
    const dashWidth = 4.0;
    const gapWidth = 3.0;
    double x = 0;
    while (x < size.width) {
      canvas.drawLine(Offset(x, 1), Offset(x + dashWidth, 1), paint);
      x += dashWidth + gapWidth;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

/// Simple dual-line chart painter. Replace with fl_chart for real data.
class _DualLineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    _drawLine(
      canvas,
      size,
      color: AppColors.cyan,
      points: [
        0.55,
        0.40,
        0.25,
        0.35,
        0.20,
        0.30,
        0.45,
        0.35,
        0.50,
        0.40,
        0.60,
      ],
    );
    _drawDashedLine(
      canvas,
      size,
      color: AppColors.green,
      points: [
        0.70,
        0.55,
        0.50,
        0.45,
        0.40,
        0.50,
        0.55,
        0.50,
        0.65,
        0.55,
        0.75,
      ],
    );
  }

  void _drawLine(
    Canvas canvas,
    Size size, {
    required Color color,
    required List<double> points,
  }) {
    final paint =
        Paint()
          ..color = color
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round;

    final path = Path();
    for (int i = 0; i < points.length; i++) {
      final x = (i / (points.length - 1)) * size.width;
      final y = points[i] * size.height;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        final prevX = ((i - 1) / (points.length - 1)) * size.width;
        final prevY = points[i - 1] * size.height;
        path.cubicTo(
          prevX + (x - prevX) / 2,
          prevY,
          prevX + (x - prevX) / 2,
          y,
          x,
          y,
        );
      }
    }
    canvas.drawPath(path, paint);
  }

  void _drawDashedLine(
    Canvas canvas,
    Size size, {
    required Color color,
    required List<double> points,
  }) {
    final paint =
        Paint()
          ..color = color
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

    const dashLen = 8.0;
    const gapLen = 4.0;

    // Build the full path then simulate dashes by drawing small segments
    final allPoints = List.generate(points.length, (i) {
      return Offset(
        (i / (points.length - 1)) * size.width,
        points[i] * size.height,
      );
    });

    double drawn = 0;
    bool drawing = true;

    for (int i = 1; i < allPoints.length; i++) {
      final seg = allPoints[i] - allPoints[i - 1];
      final segLen = seg.distance;
      double traveled = 0;

      while (traveled < segLen) {
        final remaining = drawing ? dashLen : gapLen;
        final available = segLen - traveled;
        final step = available < remaining ? available : remaining;
        final start = allPoints[i - 1] + seg * (traveled / segLen);
        final end = allPoints[i - 1] + seg * ((traveled + step) / segLen);
        if (drawing) canvas.drawLine(start, end, paint);
        traveled += step;
        drawn += step;
        if (drawn >= (drawing ? dashLen : gapLen)) {
          drawing = !drawing;
          drawn = 0;
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}
