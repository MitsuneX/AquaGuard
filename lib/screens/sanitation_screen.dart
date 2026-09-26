import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';
import '../utils/responsive.dart';

class SanitationScreen extends StatelessWidget {
  const SanitationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _SanitationHero(),
        _MainTopicsSection(),
        _HealthImpactDiagram(),
        _WastewaterSection(),
        _GlobalSanitationFacts(),
      ],
    );
  }
}

class _SanitationHero extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final padding = Responsive.pagePadding(context);
    return Container(
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
          child: const SectionHeader(
            eyebrow: 'SANITATION & HYGIENE',
            title: 'The Other Half of SDG 6',
            subtitle:
                'Clean water is only part of the equation. Sanitation and hygiene are equally critical to human health, dignity, and development.',
            eyebrowColor: AppColors.skyBlue,
            titleColor: AppColors.white,
          ),
        ),
      ),
    );
  }
}

class _MainTopicsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final padding = Responsive.pagePadding(context);
    final isMobile = Responsive.isMobile(context);

    final topics = [
      _TopicData(
        icon: '🚽',
        title: 'Sanitation',
        subtitle: 'Safe disposal of human waste',
        color: AppColors.primaryBlue,
        points: [
          'Safely managed sanitation prevents contamination of water sources',
          'Open defecation affects 494 million people worldwide',
          'Pit latrines, septic tanks, and sewers are all forms of sanitation',
          'Poor sanitation disproportionately affects women and children',
          'Investment in sanitation infrastructure yields major health returns',
        ],
        stat: '57%',
        statLabel: 'Basic sanitation coverage (est. 2023)',
      ),
      _TopicData(
        icon: '🧼',
        title: 'Hygiene',
        subtitle: 'Handwashing & personal cleanliness',
        color: AppColors.waterBlue,
        points: [
          'Proper handwashing with soap is one of the most cost-effective health interventions',
          'Hand hygiene can prevent 40% of diarrhoeal illnesses',
          'Billions lack access to basic handwashing facilities at home',
          'School WASH programs improve attendance and learning outcomes',
          'Menstrual hygiene management is a critical but often neglected issue',
        ],
        stat: '3B',
        statLabel: 'People lack handwashing facilities',
      ),
      _TopicData(
        icon: '🦠',
        title: 'Health',
        subtitle: 'Disease prevention & protection',
        color: AppColors.warningAmber,
        points: [
          'Waterborne diseases kill approximately 3.4 million people annually',
          'Diarrhoea is the leading cause of death in children under 5 globally',
          'Cholera, typhoid, and hepatitis A are all water/sanitation-related',
          'WASH improvements can prevent up to 10% of the global disease burden',
          'Safe water and sanitation are prerequisites for all other health goals',
        ],
        stat: '3.4M',
        statLabel: 'Annual deaths from waterborne disease',
      ),
    ];

    return Container(
      color: AppColors.lightGrey,
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
                eyebrow: 'CORE TOPICS',
                title: 'Sanitation, Hygiene & Health',
                subtitle:
                    'These three pillars are deeply interconnected — improvements in one area drive progress in all others.',
              ),
              SizedBox(height: isMobile ? 40 : 56),
              ResponsiveGrid(
                mobileColumns: 1,
                tabletColumns: 1,
                desktopColumns: 3,
                children: topics
                    .map((t) => _TopicCard(data: t))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopicData {
  final String icon;
  final String title;
  final String subtitle;
  final Color color;
  final List<String> points;
  final String stat;
  final String statLabel;

  const _TopicData({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.points,
    required this.stat,
    required this.statLabel,
  });
}

class _TopicCard extends StatefulWidget {
  final _TopicData data;

  const _TopicCard({required this.data});

  @override
  State<_TopicCard> createState() => _TopicCardState();
}

class _TopicCardState extends State<_TopicCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final d = widget.data;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _hovered ? d.color.withOpacity(0.4) : AppColors.cardBorder,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: d.color.withOpacity(0.12),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  )
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: d.color.withOpacity(0.06),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: d.color.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(d.icon,
                          style: const TextStyle(fontSize: 28)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          d.title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: d.color,
                          ),
                        ),
                        Text(
                          d.subtitle,
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.mediumGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Stat
            Container(
              margin: const EdgeInsets.fromLTRB(24, 20, 24, 0),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [d.color.withOpacity(0.08), d.color.withOpacity(0.03)],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Text(
                    d.stat,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: d.color,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      d.statLabel,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.mediumGrey,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Points
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: d.points
                    .map(
                      (p) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 6),
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: d.color,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                p,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: AppColors.darkText,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Health Impact Diagram ───────────────────────────────────────────────────

class _HealthImpactDiagram extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final padding = Responsive.pagePadding(context);
    final isMobile = Responsive.isMobile(context);

    final steps = [
      (
        '💧',
        'Unsafe Water',
        'Water contaminated with pathogens, heavy metals, or chemicals.',
        AppColors.dangerRed,
      ),
      (
        '🦠',
        'Contamination',
        'Pathogens enter the body through drinking, cooking, or contact.',
        AppColors.warningAmber,
      ),
      (
        '🏥',
        'Health Risk',
        'Illness, hospitalisation, malnutrition, and in severe cases, death.',
        AppColors.primaryBlue,
      ),
      (
        '🌍',
        'Community Impact',
        'Reduced productivity, education loss, poverty cycle, and economic cost.',
        AppColors.deepOcean,
      ),
    ];

    return Container(
      color: AppColors.white,
      padding: EdgeInsets.symmetric(
        horizontal: padding.horizontal / 2,
        vertical: Responsive.sectionSpacing(context),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            children: [
              const SectionHeader(
                eyebrow: 'CAUSE & EFFECT',
                title: 'The Health Impact Chain',
                subtitle:
                    'Understanding this chain helps us see why prevention — through clean water and good sanitation — is so critical.',
              ),
              SizedBox(height: isMobile ? 40 : 56),
              isMobile
                  ? Column(
                      children: steps.asMap().entries.map((e) {
                        final i = e.key;
                        final step = e.value;
                        return Column(
                          children: [
                            _DiagramStep(
                              icon: step.$1,
                              title: step.$2,
                              description: step.$3,
                              color: step.$4,
                            ),
                            if (i < steps.length - 1)
                              Container(
                                width: 2,
                                height: 32,
                                color: AppColors.cardBorder,
                                margin: const EdgeInsets.symmetric(vertical: 8),
                              ),
                          ],
                        );
                      }).toList(),
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: steps.asMap().entries.map((e) {
                        final i = e.key;
                        final step = e.value;
                        return Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: _DiagramStep(
                                  icon: step.$1,
                                  title: step.$2,
                                  description: step.$3,
                                  color: step.$4,
                                ),
                              ),
                              if (i < steps.length - 1)
                                Container(
                                  width: 28,
                                  child: const Icon(
                                    Icons.arrow_forward,
                                    color: AppColors.mediumGrey,
                                    size: 20,
                                  ),
                                ),
                            ],
                          ),
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

class _DiagramStep extends StatelessWidget {
  final String icon;
  final String title;
  final String description;
  final Color color;

  const _DiagramStep({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(icon, style: const TextStyle(fontSize: 26)),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.mediumGrey,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Wastewater Section ──────────────────────────────────────────────────────

class _WastewaterSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final padding = Responsive.pagePadding(context);
    final isMobile = Responsive.isMobile(context);

    return Container(
      color: AppColors.veryLightBlue,
      padding: EdgeInsets.symmetric(
        horizontal: padding.horizontal / 2,
        vertical: Responsive.sectionSpacing(context),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: isMobile
              ? Column(
                  children: [
                    _WastewaterText(),
                    const SizedBox(height: 40),
                    _WastewaterSteps(),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _WastewaterText()),
                    const SizedBox(width: 60),
                    Expanded(child: _WastewaterSteps()),
                  ],
                ),
        ),
      ),
    );
  }
}

class _WastewaterText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          eyebrow: 'WASTEWATER',
          title: 'Why Treating Wastewater Matters',
          subtitle:
              'Only about 56% of wastewater globally is safely treated before being returned to the environment (est. 2023). The rest pollutes rivers, lakes, and coastal areas.',
          alignment: CrossAxisAlignment.start,
        ),
        SizedBox(height: 24),
        Text(
          'Untreated wastewater carries pathogens, nutrients, and toxic chemicals that devastate aquatic ecosystems, contaminate drinking water sources, and harm human health. Improving wastewater management is both an environmental and a public health imperative.',
          style: TextStyle(
            fontSize: 15,
            color: AppColors.mediumGrey,
            height: 1.7,
          ),
        ),
      ],
    );
  }
}

class _WastewaterSteps extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final steps = [
      ('Primary Treatment', 'Removes large solids and sediment from wastewater.'),
      ('Secondary Treatment', 'Biological processes remove dissolved organic matter.'),
      ('Tertiary Treatment', 'Advanced filtering for nutrients, chemicals, and pathogens.'),
      ('Safe Discharge / Reuse', 'Treated water returned to environment or reused safely.'),
    ];

    return Column(
      children: steps.asMap().entries.map((e) {
        final i = e.key;
        final step = e.value;
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.cardBorder),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.primaryBlue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        '${i + 1}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppColors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          step.$1,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          step.$2,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (i < steps.length - 1)
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Container(
                  height: 24,
                  width: 2,
                  color: AppColors.primaryBlue.withOpacity(0.2),
                ),
              ),
          ],
        );
      }).toList(),
    );
  }
}

// ─── Global Sanitation Facts ─────────────────────────────────────────────────

class _GlobalSanitationFacts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final padding = Responsive.pagePadding(context);
    final isMobile = Responsive.isMobile(context);

    final facts = [
      ('494M', 'People still practice open defecation'),
      ('2B', 'People lack basic sanitation services'),
      ('4.2B', 'People lack safely managed sanitation'),
      ('40%', 'Reduction in diarrhoea from handwashing'),
      ('\$5.5', 'Return on every \$1 invested in sanitation'),
      ('297K', 'Children under 5 die from diarrhoea annually'),
    ];

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.deepOcean, Color(0xFF0A4F7A)],
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
                eyebrow: 'BY THE NUMBERS',
                title: 'Global Sanitation Crisis',
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
                          color: AppColors.white.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppColors.white.withOpacity(0.12),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              f.$1,
                              style: const TextStyle(
                                fontSize: 30,
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
