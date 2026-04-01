import 'package:airport_operations/app/colors.dart';
import 'package:airport_operations/domain/model/correlation_series.dart';
import 'package:airport_operations/domain/model/y_axis_label.dart';
import 'package:flutter/material.dart';

/// Generic correlation / dual-line analysis card.
///
/// Used for both "Compare Trends" (Flights vs Computer) and
/// "Visibility Impact" (Visibility vs Computer) cards.
class EnergyCorrelationCard extends StatefulWidget {
  const EnergyCorrelationCard({
    super.key,
    required this.icon,
    required this.title,
    required this.badgeLabel,
    required this.presets,
    required this.seriesPerPreset,
    this.yAxisLabels,
    required this.insightText,
  });

  final IconData icon;
  final String title;
  final String badgeLabel;

  /// Tab labels for the preset chips.
  final List<String> presets;

  /// One list of [CorrelationSeries] per preset.
  final List<List<CorrelationSeries>> seriesPerPreset;

  /// Optional Y-axis labels shown inside the chart area.
  final List<YAxisLabel>? yAxisLabels;

  final String insightText;

  @override
  State<EnergyCorrelationCard> createState() => _EnergyCorrelationCardState();
}

class _EnergyCorrelationCardState extends State<EnergyCorrelationCard> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    final series = widget.seriesPerPreset[_selected];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: AppColors.surfaceDeep,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0x1A6F7588), width: 1),
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
          // Header row: icon + title + badge
          Row(
            children: [
              Icon(widget.icon, color: AppColors.cyan, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  widget.title.toUpperCase(),
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.4,
                    height: 1.43,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.surfaceMid,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  widget.badgeLabel.toUpperCase(),
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Preset chips
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(widget.presets.length, (i) {
              final isActive = i == _selected;
              return GestureDetector(
                onTap: () => setState(() => _selected = i),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6.5,
                  ),
                  decoration: BoxDecoration(
                    color: isActive ? AppColors.cyan : Colors.transparent,
                    borderRadius: BorderRadius.circular(9999),
                    border:
                        isActive
                            ? null
                            : Border.all(
                              color: const Color(0xFF424859),
                              width: 1,
                            ),
                    boxShadow:
                        isActive
                            ? const [
                              BoxShadow(
                                color: Color(0x4D3ADFFA),
                                blurRadius: 10,
                              ),
                            ]
                            : null,
                  ),
                  child: Text(
                    widget.presets[i],
                    style: TextStyle(
                      color:
                          isActive
                              ? const Color(0xFF004B56)
                              : AppColors.textSecondary,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                      height: 1.5,
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 16),

          // Chart area
          Container(
            height: 144,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0x4D000000),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0x0DFFFFFF), width: 1),
            ),
            clipBehavior: Clip.hardEdge,
            child: Stack(
              children: [
                // Y-axis labels (optional)
                if (widget.yAxisLabels != null)
                  Positioned(
                    left: 8,
                    top: 24,
                    bottom: 24,
                    width: 30,
                    child: LayoutBuilder(
                      builder:
                          (ctx, box) => Stack(
                            children:
                                widget.yAxisLabels!
                                    .map(
                                      (l) => Positioned(
                                        top:
                                            l.fractionFromTop * box.maxHeight -
                                            6,
                                        left: 0,
                                        child: Text(
                                          l.label,
                                          style: const TextStyle(
                                            color: Color(0x80A5AABF),
                                            fontSize: 8,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: -0.4,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                          ),
                    ),
                  ),
                // Lines
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    widget.yAxisLabels != null ? 36 : 0,
                    0,
                    0,
                    0,
                  ),
                  child: CustomPaint(
                    size: const Size(double.infinity, 144),
                    painter: _DualLinePainter(series: series),
                  ),
                ),
                // "Normalized Scale" watermark
                const Positioned(
                  right: 8,
                  bottom: 4,
                  child: Opacity(
                    opacity: 0.5,
                    child: Text(
                      'NORMALIZED SCALE',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 8,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.4,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Legend
          Row(
            children: [
              Expanded(
                child: Row(
                  children:
                      series
                          .map(
                            (s) => Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: _LegendItem(series: s),
                            ),
                          )
                          .toList(),
                ),
              ),
              const Opacity(
                opacity: 0.6,
                child: Text(
                  'RELATIVE TREND',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 9,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 17),

          // Divider
          const Divider(color: Color(0x1A6F7588), thickness: 1, height: 1),
          const SizedBox(height: 17),

          // Insight text
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.info_outline,
                size: 13,
                color: Color(0xFFE0E5FB),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  widget.insightText,
                  style: const TextStyle(
                    color: Color(0xFFE0E5FB),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    height: 1.25,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({required this.series});

  final CorrelationSeries series;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        series.dashed
            ? _DashedLine(color: series.color)
            : Container(width: 12, height: 2, color: series.color),
        const SizedBox(width: 6),
        Text(
          series.label.toUpperCase(),
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 9,
            fontWeight: FontWeight.w700,
            height: 1.5,
          ),
        ),
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
      width: 12,
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
    final p =
        Paint()
          ..color = color
          ..strokeWidth = 2;
    double x = 0;
    while (x < size.width) {
      canvas.drawLine(Offset(x, 1), Offset((x + 3).clamp(0, size.width), 1), p);
      x += 6;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter o) => false;
}

class _DualLinePainter extends CustomPainter {
  _DualLinePainter({required this.series});
  final List<CorrelationSeries> series;

  @override
  void paint(Canvas canvas, Size size) {
    for (final s in series) {
      _drawLine(canvas, size, s);
    }
  }

  void _drawLine(Canvas canvas, Size size, CorrelationSeries s) {
    final pts = List.generate(
      s.points.length,
      (i) => Offset(
        (i / (s.points.length - 1)) * size.width,
        s.points[i] * size.height,
      ),
    );

    final path = Path()..moveTo(pts.first.dx, pts.first.dy);
    for (int i = 1; i < pts.length; i++) {
      final p = pts[i - 1];
      final n = pts[i];
      path.cubicTo(
        p.dx + (n.dx - p.dx) / 2,
        p.dy,
        p.dx + (n.dx - p.dx) / 2,
        n.dy,
        n.dx,
        n.dy,
      );
    }

    if (s.dashed) {
      _drawDashedPath(canvas, path, s.color);
    } else {
      canvas.drawPath(
        path,
        Paint()
          ..color = s.color
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round,
      );
    }
  }

  void _drawDashedPath(Canvas canvas, Path path, Color color) {
    final metric = path.computeMetrics().first;
    final paint =
        Paint()
          ..color = color
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

    const dashLen = 8.0;
    const gapLen = 4.0;
    double dist = 0;
    bool drawing = true;

    while (dist < metric.length) {
      final seg = drawing ? dashLen : gapLen;
      final end = (dist + seg).clamp(0, metric.length).toDouble();
      if (drawing) {
        canvas.drawPath(metric.extractPath(dist, end), paint);
      }
      dist = end;
      drawing = !drawing;
    }
  }

  @override
  bool shouldRepaint(covariant _DualLinePainter old) => old.series != series;
}
