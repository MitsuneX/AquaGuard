import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/water_data.dart';
import '../models/water_tip.dart';
import '../widgets/common_widgets.dart';
import '../utils/responsive.dart';

class WaterScreen extends StatefulWidget {
  const WaterScreen({super.key});

  @override
  State<WaterScreen> createState() => _WaterScreenState();
}

class _WaterScreenState extends State<WaterScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<({String label, String icon, WaterCategory category, List<WaterTip> tips})>
      _tabs = const [
    (
      label: 'Availability',
      icon: '🌏',
      category: WaterCategory.availability,
      tips: WaterData.availabilityTips,
    ),
    (
      label: 'Quality',
      icon: '🧪',
      category: WaterCategory.quality,
      tips: WaterData.qualityTips,
    ),
    (
      label: 'Scarcity',
      icon: '🏜️',
      category: WaterCategory.scarcity,
      tips: WaterData.scarcityTips,
    ),
    (
      label: 'Conservation',
      icon: '♻️',
      category: WaterCategory.conservation,
      tips: WaterData.conservationTips,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final padding = Responsive.pagePadding(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
          // Page header
          Container(
            decoration: const BoxDecoration(
              gradient: AppColors.heroGradient,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: padding.horizontal / 2,
              vertical: 60,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Column(
                  children: [
                    SectionHeader(
                      eyebrow: 'WATER EDUCATION',
                      title: 'Understanding Our Water',
                      subtitle:
                          'Explore freshwater availability, quality challenges, scarcity pressures, and practical conservation strategies.',
                      eyebrowColor: AppColors.skyBlue,
                      titleColor: AppColors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Tab bar
          Container(
            color: AppColors.white,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: TabBar(
                  controller: _tabController,
                  isScrollable: isMobile,
                  labelColor: AppColors.primaryBlue,
                  unselectedLabelColor: AppColors.mediumGrey,
                  indicatorColor: AppColors.primaryBlue,
                  indicatorWeight: 3,
                  labelStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  tabs: _tabs
                      .map(
                        (t) => Tab(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(t.icon, style: const TextStyle(fontSize: 16)),
                              const SizedBox(width: 8),
                              Text(t.label),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),

          // Tab content
          AnimatedBuilder(
            animation: _tabController,
            builder: (context, child) {
              return Container(
                color: AppColors.lightGrey,
                padding: EdgeInsets.symmetric(
                  horizontal: padding.horizontal / 2,
                  vertical: 48,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1200),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Category intro
                        _CategoryIntro(
                          category: _tabs[_tabController.index].category,
                        ),
                        const SizedBox(height: 32),
                        // Tips grid
                        ResponsiveGrid(
                          mobileColumns: 1,
                          tabletColumns: 2,
                          desktopColumns: 2,
                          children: _tabs[_tabController.index]
                              .tips
                              .map(
                                (tip) => InfoCard(
                                  icon: tip.icon,
                                  title: tip.title,
                                  description: tip.description,
                                  detail: tip.detail,
                                  accentColor: _categoryColor(tip.category),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

          // Water cycle section
          _WaterCycleSection(),

          // Global water facts
          _WaterFactsSection(),
        ],
      );
  }

  Color _categoryColor(WaterCategory cat) {
    switch (cat) {
      case WaterCategory.availability:
        return AppColors.primaryBlue;
      case WaterCategory.quality:
        return AppColors.waterBlue;
      case WaterCategory.scarcity:
        return AppColors.warningAmber;
      case WaterCategory.conservation:
        return AppColors.successGreen;
    }
  }
}

class _CategoryIntro extends StatelessWidget {
  final WaterCategory category;

  const _CategoryIntro({required this.category});

  @override
  Widget build(BuildContext context) {
    final info = _info[category]!;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            info.$3.withOpacity(0.08),
            info.$3.withOpacity(0.02),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: info.$3.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Text(info.$1, style: const TextStyle(fontSize: 48)),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  info.$2,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 6),
                Text(
                  info.$4,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.mediumGrey,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static const _info = {
    WaterCategory.availability: (
      '🌊',
      'Water Availability',
      AppColors.primaryBlue,
      'Understanding where freshwater comes from and how it is distributed is fundamental to addressing the global water crisis.',
    ),
    WaterCategory.quality: (
      '🔬',
      'Water Quality',
      AppColors.waterBlue,
      'Access to water is only the first step — the water must also be safe. Quality challenges threaten billions of people worldwide.',
    ),
    WaterCategory.scarcity: (
      '⚠️',
      'Water Scarcity',
      AppColors.warningAmber,
      'Growing populations, climate change, and poor water management are converging to create an unprecedented water scarcity crisis.',
    ),
    WaterCategory.conservation: (
      '🌿',
      'Water Conservation',
      AppColors.successGreen,
      'Small individual and community actions, taken consistently at scale, can make a measurable difference in water security.',
    ),
  };
}

class _WaterCycleSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final padding = Responsive.pagePadding(context);

    final steps = [
      ('☁️', 'Evaporation', 'Water evaporates from oceans, lakes, and rivers into the atmosphere.'),
      ('🌧️', 'Precipitation', 'Water vapor condenses and falls as rain, snow, or hail.'),
      ('🏞️', 'Collection', 'Water collects in rivers, lakes, and aquifers, or flows to the ocean.'),
      ('🌱', 'Infiltration', 'Water seeps into the ground, recharging underground aquifers.'),
    ];

    return Container(
      color: AppColors.white,
      padding: EdgeInsets.symmetric(
        horizontal: padding.horizontal / 2,
        vertical: Responsive.sectionSpacing(context),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              const SectionHeader(
                eyebrow: 'THE WATER CYCLE',
                title: 'How Water Moves on Earth',
                subtitle:
                    'The hydrological cycle continuously moves water through the environment — a natural system we depend on and must protect.',
              ),
              SizedBox(height: isMobile ? 40 : 56),
              ResponsiveGrid(
                mobileColumns: 1,
                tabletColumns: 2,
                desktopColumns: 4,
                children: steps.asMap().entries.map((e) {
                  final i = e.key;
                  final step = e.value;
                  return _WaterCycleStep(
                    number: i + 1,
                    icon: step.$1,
                    title: step.$2,
                    description: step.$3,
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WaterCycleStep extends StatelessWidget {
  final int number;
  final String icon;
  final String title;
  final String description;

  const _WaterCycleStep({
    required this.number,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.cardBorder),
        boxShadow: [
          BoxShadow(
            color: AppColors.deepOcean.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '$number',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Text(icon, style: const TextStyle(fontSize: 32)),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.mediumGrey,
                  height: 1.6,
                ),
          ),
        ],
      ),
    );
  }
}

class _WaterFactsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final padding = Responsive.pagePadding(context);
    final isMobile = Responsive.isMobile(context);

    final facts = [
      ('97%', 'of Earth\'s water is saltwater'),
      ('70%', 'of global freshwater is frozen in glaciers'),
      ('70%', 'of freshwater withdrawals go to agriculture'),
      ('785M', 'people lack basic drinking water service'),
      ('2B', 'people use contaminated water sources'),
      ('6hrs', 'average daily walk for water in some regions'),
    ];

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0D5F8F), AppColors.waterBlue],
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: padding.horizontal / 2,
        vertical: Responsive.sectionSpacing(context),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              SectionHeader(
                eyebrow: 'QUICK FACTS',
                title: 'Water by the Numbers',
                eyebrowColor: AppColors.skyBlue,
                titleColor: AppColors.white,
              ),
              SizedBox(height: isMobile ? 40 : 56),
              ResponsiveGrid(
                mobileColumns: 2,
                tabletColumns: 3,
                desktopColumns: 3,
                children: facts
                    .map(
                      (f) => Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: AppColors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppColors.white.withOpacity(0.15),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              f.$1,
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w800,
                                color: AppColors.white,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              f.$2,
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.skyBlue,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
