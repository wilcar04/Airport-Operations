/// Data model for the Y-axis labels (optional, shown on left side).
class YAxisLabel {
  const YAxisLabel(this.label, this.fractionFromTop);
  final String label;
  final double fractionFromTop; // 0 = top, 1 = bottom
}
