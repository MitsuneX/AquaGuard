/// Action item model for Take Action page
class ActionItem {
  final String icon;
  final String title;
  final String description;
  final String whyItMatters;
  final String impact;
  final ActionCategory category;

  const ActionItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.whyItMatters,
    required this.impact,
    required this.category,
  });
}

enum ActionCategory {
  saveWater,
  sanitation,
  community,
  pollution,
}
