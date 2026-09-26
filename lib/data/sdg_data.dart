import '../models/sdg_data_point.dart';

/// NOTE: All data below is illustrative/educational.
/// Figures are approximate global estimates for educational purposes only
/// and should not be cited as official statistics.
class SdgData {
  SdgData._();

  // ─── Home page stat cards ────────────────────────────────────────────────

  static const List<StatItem> homeStats = [
    StatItem(
      icon: '💧',
      title: 'WATER ACCESS',
      value: '74%',
      trend: '+2.4%',
      trendPositive: true,
      description: 'Population with access to safe drinking water (est. 2023)',
    ),
    StatItem(
      icon: '🚽',
      title: 'SANITATION',
      value: '57%',
      trend: '+1.8%',
      trendPositive: true,
      description: 'Population with basic sanitation services (est. 2023)',
    ),
    StatItem(
      icon: '🧼',
      title: 'BASIC HYGIENE',
      value: '67%',
      trend: '+3.1%',
      trendPositive: true,
      description: 'Population with handwashing facilities (est. 2023)',
    ),
    StatItem(
      icon: '🌊',
      title: 'WASTEWATER',
      value: '56%',
      trend: '+0.9%',
      trendPositive: true,
      description: 'Wastewater safely treated before discharge (est. 2023)',
    ),
  ];

  // ─── Dashboard chart data ────────────────────────────────────────────────

  static const List<SdgDataPoint> waterAccessProgress = [
    SdgDataPoint(year: 2000, value: 60.0),
    SdgDataPoint(year: 2005, value: 64.5),
    SdgDataPoint(year: 2010, value: 68.2),
    SdgDataPoint(year: 2015, value: 71.0),
    SdgDataPoint(year: 2020, value: 73.2),
    SdgDataPoint(year: 2023, value: 74.0),
    SdgDataPoint(year: 2030, value: 100.0, label: 'Target'),
  ];

  static const List<SdgDataPoint> sanitationProgress = [
    SdgDataPoint(year: 2000, value: 42.0),
    SdgDataPoint(year: 2005, value: 46.1),
    SdgDataPoint(year: 2010, value: 50.3),
    SdgDataPoint(year: 2015, value: 53.0),
    SdgDataPoint(year: 2020, value: 55.8),
    SdgDataPoint(year: 2023, value: 57.0),
    SdgDataPoint(year: 2030, value: 100.0, label: 'Target'),
  ];

  static const List<SdgDataPoint> hygieneProgress = [
    SdgDataPoint(year: 2000, value: 50.0),
    SdgDataPoint(year: 2005, value: 54.5),
    SdgDataPoint(year: 2010, value: 58.0),
    SdgDataPoint(year: 2015, value: 61.3),
    SdgDataPoint(year: 2020, value: 64.8),
    SdgDataPoint(year: 2023, value: 67.0),
    SdgDataPoint(year: 2030, value: 100.0, label: 'Target'),
  ];

  static const List<SdgDataPoint> waterScarcityByRegion = [
    SdgDataPoint(year: 0, value: 68.0, label: 'Sub-Saharan\nAfrica'),
    SdgDataPoint(year: 1, value: 45.0, label: 'South Asia'),
    SdgDataPoint(year: 2, value: 20.0, label: 'East Asia'),
    SdgDataPoint(year: 3, value: 15.0, label: 'Latin\nAmerica'),
    SdgDataPoint(year: 4, value: 10.0, label: 'Europe'),
    SdgDataPoint(year: 5, value: 8.0, label: 'North\nAmerica'),
  ];

  static const List<SdgDataPoint> wastewaterTreatment = [
    SdgDataPoint(year: 2010, value: 44.0),
    SdgDataPoint(year: 2015, value: 48.5),
    SdgDataPoint(year: 2020, value: 53.0),
    SdgDataPoint(year: 2023, value: 56.0),
    SdgDataPoint(year: 2030, value: 100.0, label: 'Target'),
  ];

  // ─── Progress items ───────────────────────────────────────────────────────

  static const List<ProgressItem> sdgProgressItems = [
    ProgressItem(
      category: 'Safe Drinking Water (6.1)',
      current: 74.0,
      target: 100.0,
      unit: '% population',
      year: 2023,
    ),
    ProgressItem(
      category: 'Basic Sanitation (6.2)',
      current: 57.0,
      target: 100.0,
      unit: '% population',
      year: 2023,
    ),
    ProgressItem(
      category: 'Water Quality & Treatment (6.3)',
      current: 56.0,
      target: 100.0,
      unit: '% wastewater',
      year: 2023,
    ),
    ProgressItem(
      category: 'Water-Use Efficiency (6.4)',
      current: 60.0,
      target: 100.0,
      unit: '% index',
      year: 2023,
    ),
    ProgressItem(
      category: 'Integrated Water Management (6.5)',
      current: 49.0,
      target: 100.0,
      unit: '% countries',
      year: 2023,
    ),
  ];

  // ─── SDG Targets ─────────────────────────────────────────────────────────

  static const List<SdgTarget> sdgTargets = [
    SdgTarget(
      code: '6.1',
      title: 'Safe Drinking Water',
      description:
          'By 2030, achieve universal and equitable access to safe and affordable drinking water for all.',
      icon: '💧',
    ),
    SdgTarget(
      code: '6.2',
      title: 'Sanitation & Hygiene',
      description:
          'By 2030, achieve access to adequate and equitable sanitation and hygiene for all. End open defecation.',
      icon: '🚽',
    ),
    SdgTarget(
      code: '6.3',
      title: 'Water Quality',
      description:
          'Improve water quality by reducing pollution, eliminating dumping, and minimizing release of hazardous chemicals.',
      icon: '🧪',
    ),
    SdgTarget(
      code: '6.4',
      title: 'Water-Use Efficiency',
      description:
          'Substantially increase water-use efficiency across all sectors and ensure sustainable freshwater withdrawals.',
      icon: '♻️',
    ),
    SdgTarget(
      code: '6.5',
      title: 'Integrated Water Management',
      description:
          'Implement integrated water resources management at all levels, including through transboundary cooperation.',
      icon: '🌍',
    ),
    SdgTarget(
      code: '6.6',
      title: 'Water-Related Ecosystems',
      description:
          'Protect and restore water-related ecosystems, including mountains, forests, wetlands, rivers, and lakes.',
      icon: '🌿',
    ),
    SdgTarget(
      code: '6.A',
      title: 'International Cooperation',
      description:
          'Expand international cooperation and capacity-building support to developing countries in water and sanitation.',
      icon: '🤝',
    ),
    SdgTarget(
      code: '6.B',
      title: 'Community Participation',
      description:
          'Support and strengthen the participation of local communities in improving water and sanitation management.',
      icon: '👥',
    ),
  ];
}
