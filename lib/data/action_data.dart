import '../models/action_item.dart';

class ActionData {
  ActionData._();

  static const List<ActionItem> actions = [
    ActionItem(
      icon: '💧',
      title: 'Turn Off Taps',
      description:
          'Turn off the tap while brushing your teeth, washing dishes, or soaping your hands.',
      whyItMatters:
          'A running tap wastes approximately 6 liters per minute. Turning it off during a 2-minute brush saves up to 12 liters twice a day.',
      impact: 'Save up to 8,760 L/year',
      category: ActionCategory.saveWater,
    ),
    ActionItem(
      icon: '🚿',
      title: 'Shorter Showers',
      description:
          'Aim for 4–5 minute showers instead of long ones. Use a timer or a song to keep track.',
      whyItMatters:
          'Showers account for a significant portion of household water use. Cutting 3 minutes can save over 11,000 liters per person per year.',
      impact: 'Save 30–40 L/shower',
      category: ActionCategory.saveWater,
    ),
    ActionItem(
      icon: '🔧',
      title: 'Fix Leaks',
      description:
          'Check taps, pipes, and toilets for leaks. Report or repair leaks promptly.',
      whyItMatters:
          'A single dripping tap can waste more than 11,000 liters per year. Leaky toilets can waste up to 200 liters per day.',
      impact: 'Save up to 73,000 L/year',
      category: ActionCategory.saveWater,
    ),
    ActionItem(
      icon: '🚯',
      title: 'Protect Waterways',
      description:
          'Never dump waste, chemicals, or plastics into rivers, drains, or the ocean.',
      whyItMatters:
          'Water pollution is one of the leading causes of preventable death globally. Keeping waterways clean protects ecosystems and communities downstream.',
      impact: 'Protect millions of lives',
      category: ActionCategory.pollution,
    ),
    ActionItem(
      icon: '🧼',
      title: 'Practice Good Hygiene',
      description:
          'Wash hands properly with soap for at least 20 seconds, especially before eating and after using the toilet.',
      whyItMatters:
          'Proper handwashing can reduce diarrhoeal disease by up to 40% and respiratory infections by up to 20%.',
      impact: 'Prevent millions of illnesses',
      category: ActionCategory.sanitation,
    ),
    ActionItem(
      icon: '🌧️',
      title: 'Reuse Water Responsibly',
      description:
          'Collect and reuse rinse water for plants, use greywater (from sinks/showers) for toilet flushing where safe.',
      whyItMatters:
          'Reusing water reduces demand on freshwater sources and decreases the volume of wastewater entering treatment systems.',
      impact: 'Reduce usage by 20–30%',
      category: ActionCategory.saveWater,
    ),
    ActionItem(
      icon: '🌱',
      title: 'Plant Native Species',
      description:
          'Choose drought-resistant native plants for gardens to reduce irrigation needs.',
      whyItMatters:
          'Gardens and landscaping account for up to 30% of household water use in many regions. Native plants are adapted to local rainfall patterns.',
      impact: 'Save 50+ L/day in summer',
      category: ActionCategory.saveWater,
    ),
    ActionItem(
      icon: '📢',
      title: 'Spread Awareness',
      description:
          'Share information about SDG 6 with your community, school, or workplace.',
      whyItMatters:
          'Community engagement is recognized as one of the key drivers of improved water and sanitation outcomes globally.',
      impact: 'Multiply your impact',
      category: ActionCategory.community,
    ),
  ];
}
