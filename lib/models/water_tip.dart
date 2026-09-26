/// Water tip / info card model
class WaterTip {
  final String icon;
  final String title;
  final String description;
  final String? detail;
  final WaterCategory category;

  const WaterTip({
    required this.icon,
    required this.title,
    required this.description,
    this.detail,
    required this.category,
  });
}

enum WaterCategory {
  availability,
  quality,
  scarcity,
  conservation,
}

/// Water usage activity model
class WaterActivity {
  final String id;
  final String name;
  final String icon;
  final String unit;
  final double litersPerUnit;
  final double defaultValue;
  final double min;
  final double max;
  final String hint;

  const WaterActivity({
    required this.id,
    required this.name,
    required this.icon,
    required this.unit,
    required this.litersPerUnit,
    required this.defaultValue,
    required this.min,
    required this.max,
    required this.hint,
  });

  double calculateDaily(double value) => value * litersPerUnit;
}
