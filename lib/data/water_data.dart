import '../models/water_tip.dart';

class WaterData {
  WaterData._();

  // ─── Water Availability ──────────────────────────────────────────────────

  static const List<WaterTip> availabilityTips = [
    WaterTip(
      icon: '🏔️',
      title: 'Freshwater',
      description:
          'Only about 3% of Earth\'s water is freshwater. Of that, roughly 2.5% is locked in glaciers, ice caps, and permafrost.',
      detail:
          'This means only about 0.5% of Earth\'s total water is accessible freshwater in lakes, rivers, and underground aquifers.',
      category: WaterCategory.availability,
    ),
    WaterTip(
      icon: '🌏',
      title: 'Groundwater',
      description:
          'Groundwater accounts for approximately 30% of accessible freshwater. It is found in aquifers beneath the Earth\'s surface.',
      detail:
          'Groundwater is critical for drinking water supply in many regions, but overpumping can deplete aquifers faster than they can recharge.',
      category: WaterCategory.availability,
    ),
    WaterTip(
      icon: '🏞️',
      title: 'Surface Water',
      description:
          'Rivers, lakes, and wetlands are key sources of surface water. They support ecosystems, agriculture, and billions of people.',
      detail:
          'Surface water is highly vulnerable to pollution and seasonal variability caused by climate change.',
      category: WaterCategory.availability,
    ),
    WaterTip(
      icon: '🌧️',
      title: 'Rainwater',
      description:
          'Rainfall is the primary driver of the water cycle. It replenishes rivers, lakes, and underground aquifers.',
      detail:
          'Rainwater harvesting can provide supplementary water supply in areas with unreliable access to piped water.',
      category: WaterCategory.availability,
    ),
  ];

  // ─── Water Quality ────────────────────────────────────────────────────────

  static const List<WaterTip> qualityTips = [
    WaterTip(
      icon: '🏭',
      title: 'Industrial Pollution',
      description:
          'Industrial discharge introduces heavy metals, chemicals, and toxins into water sources.',
      detail:
          'Without proper regulation and treatment, industrial pollution can render water unsafe for humans and wildlife.',
      category: WaterCategory.quality,
    ),
    WaterTip(
      icon: '🌾',
      title: 'Agricultural Runoff',
      description:
          'Fertilizers and pesticides from farmland wash into rivers and lakes, causing algal blooms and contamination.',
      detail:
          'Nutrient pollution (especially nitrogen and phosphorus) creates "dead zones" where aquatic life cannot survive.',
      category: WaterCategory.quality,
    ),
    WaterTip(
      icon: '🔬',
      title: 'Safe Drinking Water',
      description:
          'Safe drinking water is free from harmful pathogens, chemicals, and physical contaminants.',
      detail:
          'Approximately 1 billion people still lack access to safe drinking water, leading to millions of preventable deaths annually.',
      category: WaterCategory.quality,
    ),
    WaterTip(
      icon: '⚗️',
      title: 'Water Treatment',
      description:
          'Treatment processes including filtration, sedimentation, and chlorination make water safe for human consumption.',
      detail:
          'Modern treatment facilities can remove 99%+ of biological contaminants, but access to such infrastructure is unequal globally.',
      category: WaterCategory.quality,
    ),
  ];

  // ─── Water Scarcity ───────────────────────────────────────────────────────

  static const List<WaterTip> scarcityTips = [
    WaterTip(
      icon: '🏜️',
      title: 'Physical Scarcity',
      description:
          'Some regions simply do not have enough water resources to meet the demands of their population.',
      detail:
          'The Middle East, North Africa, and parts of South Asia face severe physical water scarcity due to arid climates.',
      category: WaterCategory.scarcity,
    ),
    WaterTip(
      icon: '⚖️',
      title: 'Unequal Access',
      description:
          'Economic and political factors mean safe water is unequally distributed, even where water exists.',
      detail:
          'Many communities pay dramatically higher prices per liter for unsafe water than households with piped connections pay for treated water.',
      category: WaterCategory.scarcity,
    ),
    WaterTip(
      icon: '🌡️',
      title: 'Climate Pressure',
      description:
          'Climate change is intensifying droughts, disrupting rainfall patterns, and causing glacier retreat.',
      detail:
          'Some estimates suggest that by 2050, half the global population could face severe water stress due to climate impacts.',
      category: WaterCategory.scarcity,
    ),
    WaterTip(
      icon: '📈',
      title: 'Increasing Demand',
      description:
          'Population growth, urbanization, and economic development are driving unprecedented increases in water demand.',
      detail:
          'Agriculture accounts for approximately 70% of global freshwater withdrawals, making food production a major driver of water use.',
      category: WaterCategory.scarcity,
    ),
  ];

  // ─── Water Conservation ──────────────────────────────────────────────────

  static const List<WaterTip> conservationTips = [
    WaterTip(
      icon: '🔧',
      title: 'Fix Leaks',
      description:
          'A small dripping tap can waste over 11,000 liters of water per year. Fixing leaks is one of the highest-impact individual actions.',
      category: WaterCategory.conservation,
    ),
    WaterTip(
      icon: '🚿',
      title: 'Shorter Showers',
      description:
          'Reducing shower time by just 2 minutes can save up to 10–15 liters per shower. Small changes add up significantly.',
      category: WaterCategory.conservation,
    ),
    WaterTip(
      icon: '♻️',
      title: 'Reuse Water',
      description:
          'Reusing rinse water for plants or greywater for toilet flushing can reduce household usage by 20–30%.',
      category: WaterCategory.conservation,
    ),
    WaterTip(
      icon: '🌿',
      title: 'Protect Waterways',
      description:
          'Avoid disposing of chemicals, medicines, or plastics in drains or rivers. These pollute water sources for entire communities.',
      category: WaterCategory.conservation,
    ),
  ];

  // ─── Water Calculator Activities ─────────────────────────────────────────

  static const List<WaterActivity> calculatorActivities = [
    WaterActivity(
      id: 'shower',
      name: 'Shower',
      icon: '🚿',
      unit: 'min/day',
      litersPerUnit: 9.0,
      defaultValue: 8.0,
      min: 1,
      max: 60,
      hint: 'Average shower uses ~9 L/min',
    ),
    WaterActivity(
      id: 'laundry',
      name: 'Laundry',
      icon: '👕',
      unit: 'loads/week',
      litersPerUnit: 70.0 / 7.0,
      defaultValue: 3.0,
      min: 0,
      max: 14,
      hint: 'Avg. washing machine uses ~70 L/load',
    ),
    WaterActivity(
      id: 'dishes',
      name: 'Dishwashing',
      icon: '🍽️',
      unit: 'times/day',
      litersPerUnit: 20.0,
      defaultValue: 2.0,
      min: 0,
      max: 10,
      hint: 'Hand washing dishes: ~20 L/session',
    ),
    WaterActivity(
      id: 'toilet',
      name: 'Toilet Flush',
      icon: '🚽',
      unit: 'flushes/day',
      litersPerUnit: 9.0,
      defaultValue: 6.0,
      min: 0,
      max: 20,
      hint: 'Standard toilet: ~9 L/flush',
    ),
    WaterActivity(
      id: 'garden',
      name: 'Garden / Plants',
      icon: '🌿',
      unit: 'min/day',
      litersPerUnit: 15.0,
      defaultValue: 0.0,
      min: 0,
      max: 60,
      hint: 'Garden hose: ~15 L/min',
    ),
    WaterActivity(
      id: 'cooking',
      name: 'Cooking & Drinking',
      icon: '🍳',
      unit: 'L/day',
      litersPerUnit: 1.0,
      defaultValue: 4.0,
      min: 1,
      max: 20,
      hint: 'Includes drinking, cooking, food prep',
    ),
  ];
}
