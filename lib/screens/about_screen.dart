import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/sdg_data.dart';
import '../widgets/common_widgets.dart';
import '../utils/responsive.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _AboutHero(),
        _WhatIsSDG6Section(),
        _SDGTargetsSection(),
        _TimelineSection(),
        _KeyOrganizationsSection(),
      ],
    );
  }
}

class _AboutHero extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final padding = Responsive.pagePadding(context);
    return Container(
      decoration: const BoxDecoration(gradient: AppColors.heroGradient),
      padding: EdgeInsets.symmetric(
        horizontal: padding.horizontal / 2,
        vertical: 60,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: const SectionHeader(
            eyebrow: 'ABOUT SDG 6',
            title: 'The Global Commitment to Clean Water',
            subtitle:
                'Understanding the scope, targets, and ambition of Sustainable Development Goal 6.',
            eyebrowColor: AppColors.skyBlue,
            titleColor: AppColors.white,
          ),
        ),
      ),
    );
  }
}

class _WhatIsSDG6Section extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final padding = Responsive.pagePadding(context);
    final isMobile = Responsive.isMobile(context);

    return Container(
      color: AppColors.white,
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
                    _SDG6Explanation(),
                    const SizedBox(height: 48),
                    _SDG6Context(),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5,
                      child: _SDG6Explanation(),
                    ),
                    const SizedBox(width: 60),
                    Expanded(
                      flex: 4,
                      child: _SDG6Context(),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class _SDG6Explanation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          eyebrow: 'OVERVIEW',
          title: 'What is SDG 6?',
          alignment: CrossAxisAlignment.start,
        ),
        SizedBox(height: 24),
        Text(
          'Sustainable Development Goal 6 (SDG 6) is one of the 17 Global Goals established by the United Nations in 2015 under the 2030 Agenda for Sustainable Development. It aims to ensure the availability and sustainable management of water and sanitation for all by 2030.',
          style: TextStyle(
            fontSize: 15,
            color: AppColors.mediumGrey,
            height: 1.7,
          ),
        ),
        SizedBox(height: 16),
        Text(
          'SDG 6 recognizes that water is not just a basic need — it is a human right. Lack of access to clean water and sanitation perpetuates cycles of poverty, disease, and inequality. The goal therefore addresses not only access to drinking water, but also sanitation, hygiene, water quality, water use efficiency, ecosystem protection, and international cooperation.',
          style: TextStyle(
            fontSize: 15,
            color: AppColors.mediumGrey,
            height: 1.7,
          ),
        ),
        SizedBox(height: 16),
        Text(
          'SDG 6 comprises six main targets (6.1–6.6) and two means of implementation targets (6.A and 6.B). Progress is tracked through the WHO/UNICEF Joint Monitoring Programme (JMP) and UN-Water.',
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

class _SDG6Context extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final keyFacts = [
      ('📅', 'Adopted', '25 September 2015'),
      ('🗓️', 'Target Year', '2030'),
      ('🌍', 'Scope', 'Universal — all countries'),
      ('📊', 'Tracked by', 'WHO/UNICEF JMP & UN-Water'),
      ('🔗', 'Linked to', 'SDGs 1, 2, 3, 11, 13, 15'),
    ];

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppColors.subtleGradient,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              gradient: AppColors.cardGradient,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              children: [
                Text('💧', style: TextStyle(fontSize: 24)),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SDG 6',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: AppColors.white,
                        ),
                      ),
                      Text(
                        'Clean Water and Sanitation',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.skyBlue,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ...keyFacts.map(
            (f) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Text(f.$1, style: const TextStyle(fontSize: 18)),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        f.$2,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.mediumGrey,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Text(
                        f.$3,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.darkText,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── SDG Targets Section ─────────────────────────────────────────────────────

class _SDGTargetsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final padding = Responsive.pagePadding(context);
    final isMobile = Responsive.isMobile(context);

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
                eyebrow: 'SDG 6 TARGETS',
                title: 'Eight Targets for 2030',
                subtitle:
                    'Each target addresses a different dimension of the water and sanitation challenge.',
              ),
              SizedBox(height: isMobile ? 40 : 56),
              ResponsiveGrid(
                mobileColumns: 1,
                tabletColumns: 2,
                desktopColumns: 4,
                children: SdgData.sdgTargets
                    .map(
                      (target) => _SDGTargetCard(target: target),
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

class _SDGTargetCard extends StatefulWidget {
  final dynamic target;

  const _SDGTargetCard({required this.target});

  @override
  State<_SDGTargetCard> createState() => _SDGTargetCardState();
}

class _SDGTargetCardState extends State<_SDGTargetCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final target = widget.target;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _hovered
                ? AppColors.primaryBlue.withOpacity(0.3)
                : AppColors.cardBorder,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: AppColors.primaryBlue.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 6),
                  )
                ]
              : [],
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(target.icon, style: const TextStyle(fontSize: 28)),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    target.code,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              target.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              target.description,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.mediumGrey,
                    height: 1.6,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Timeline Section ────────────────────────────────────────────────────────

class _TimelineSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final padding = Responsive.pagePadding(context);
    final isMobile = Responsive.isMobile(context);

    final events = [
      (
        '2000',
        'MDGs Adopted',
        'The UN Millennium Development Goals set initial water and sanitation targets.',
      ),
      (
        '2010',
        'Water as Human Right',
        'The UN General Assembly officially recognized access to clean water as a fundamental human right.',
      ),
      (
        '2015',
        'SDGs Adopted',
        'SDG 6 established as part of the 2030 Agenda for Sustainable Development.',
      ),
      (
        '2018',
        'HLPF Review',
        'SDG 6 reviewed in depth at the High-Level Political Forum on Sustainable Development.',
      ),
      (
        '2023',
        'UN Water Conference',
        'First UN Water Conference in 46 years focused progress and committed to accelerated action.',
      ),
      (
        '2030',
        'Target Deadline',
        'Universal access to clean water and sanitation for all people — the ultimate goal.',
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
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            children: [
              const SectionHeader(
                eyebrow: 'TIMELINE',
                title: 'Key Milestones',
                subtitle:
                    'The journey toward universal water and sanitation access has spanned decades.',
              ),
              SizedBox(height: isMobile ? 40 : 56),
              ...events.asMap().entries.map((e) {
                final i = e.key;
                final event = e.value;
                final isLast = i == events.length - 1;

                return _TimelineItem(
                  year: event.$1,
                  title: event.$2,
                  description: event.$3,
                  isLast: isLast,
                  isTarget: isLast,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final String year;
  final String title;
  final String description;
  final bool isLast;
  final bool isTarget;

  const _TimelineItem({
    required this.year,
    required this.title,
    required this.description,
    required this.isLast,
    required this.isTarget,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Year and line
        SizedBox(
          width: 80,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 6, vertical: 4),
                decoration: BoxDecoration(
                  color: isTarget
                      ? AppColors.successGreen
                      : AppColors.primaryBlue,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  year,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                ),
              ),
              if (!isLast)
                Container(
                  width: 2,
                  height: 60,
                  color: AppColors.cardBorder,
                ),
            ],
          ),
        ),

        const SizedBox(width: 16),

        // Content
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 2),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: isTarget
                        ? AppColors.successGreen
                        : AppColors.darkText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.mediumGrey,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Key Organizations Section ───────────────────────────────────────────────

class _KeyOrganizationsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final padding = Responsive.pagePadding(context);
    final isMobile = Responsive.isMobile(context);

    final orgs = [
      (
        '🇺🇳',
        'UN-Water',
        'Coordinates the UN system\'s work on water, monitors SDG 6 progress.',
        'un.org/water',
      ),
      (
        '🏥',
        'WHO',
        'World Health Organization monitors health impacts of water and sanitation.',
        'who.int',
      ),
      (
        '🧒',
        'UNICEF',
        'Works with WHO on the JMP to track global WASH coverage.',
        'unicef.org',
      ),
      (
        '🌍',
        'World Bank',
        'Provides financing and technical assistance for WASH programs.',
        'worldbank.org',
      ),
    ];

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.deepOcean, Color(0xFF0D5F8F)],
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
                eyebrow: 'KEY PARTNERS',
                title: 'Who is Working on SDG 6?',
                subtitle:
                    'Multiple organizations work collaboratively to drive progress on water and sanitation.',
                eyebrowColor: AppColors.skyBlue,
                titleColor: AppColors.white,
              ),
              SizedBox(height: isMobile ? 40 : 56),
              ResponsiveGrid(
                mobileColumns: 1,
                tabletColumns: 2,
                desktopColumns: 4,
                children: orgs
                    .map(
                      (org) => Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: AppColors.white.withOpacity(0.07),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.white.withOpacity(0.1),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              org.$1,
                              style: const TextStyle(fontSize: 32),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              org.$2,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              org.$3,
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
