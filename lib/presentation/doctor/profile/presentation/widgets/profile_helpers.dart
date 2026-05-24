String formatReviews(int? reviews) {
  final value = reviews ?? 1200;
  if (value >= 1000) {
    final double compact = value / 1000;
    return '${compact.toStringAsFixed(compact.truncateToDouble() == compact ? 0 : 1)}k';
  }
  return value.toString();
}
