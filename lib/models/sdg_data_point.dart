/// SDG data point model for chart data
class SdgDataPoint {
  final int year;
  final double value;
  final String? label;

  const SdgDataPoint({
    required this.year,
    required this.value,
    this.label,
  });
}

/// Statistic card model
class StatItem {
  final String icon;
  final String title;
  final String value;
  final String? trend;
  final bool trendPositive;
  final String description;

  const StatItem({
    required this.icon,
    required this.title,
    required this.value,
    this.trend,
    this.trendPositive = true,
    required this.description,
  });
}

/// SDG target model
class SdgTarget {
  final String code;
  final String title;
  final String description;
  final String icon;

  const SdgTarget({
    required this.code,
    required this.title,
    required this.description,
    required this.icon,
  });
}

/// Progress indicator model
class ProgressItem {
  final String category;
  final double current;
  final double target;
  final String unit;
  final int year;

  const ProgressItem({
    required this.category,
    required this.current,
    required this.target,
    required this.unit,
    required this.year,
  });

  double get percentage => (current / target).clamp(0.0, 1.0);
}
