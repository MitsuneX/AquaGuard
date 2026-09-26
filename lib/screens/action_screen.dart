import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/action_data.dart';
import '../widgets/common_widgets.dart';
import '../utils/responsive.dart';

class ActionScreen extends StatelessWidget {
  const ActionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _ActionHero(),
        _ActionsGrid(),
        _ImpactCalculatorTeaser(),
        _CommitmentBanner(),
      ],
    );
  }
}

class _ActionHero extends StatelessWidget {
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
            eyebrow: 'TAKE ACTION',
            title: 'Small Actions. Big Impact.',
            subtitle:
                'Every drop saved counts. Here are meaningful steps you can take today to support clean water and sanitation for all.',
            eyebrowColor: AppColors.skyBlue,
            titleColor: AppColors.white,
          ),
        ),
      ),
    );
  }
}

class _ActionsGrid extends StatelessWidget {
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
                eyebrow: 'INDIVIDUAL ACTIONS',
                title: 'What You Can Do',
                subtitle:
                    'These actions are practical, proven, and impactful. Start with one and build from there.',
              ),
              SizedBox(height: isMobile ? 40 : 56),
              ResponsiveGrid(
                mobileColumns: 1,
                tabletColumns: 2,
                desktopColumns: 2,
                children: ActionData.actions
                    .map(
                      (action) => ActionCard(
                        icon: action.icon,
                        title: action.title,
                        description: action.description,
                        whyItMatters: action.whyItMatters,
                        impact: action.impact,
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

class _ImpactCalculatorTeaser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final padding = Responsive.pagePadding(context);
    final isMobile = Responsive.isMobile(context);

    final impacts = [
      ('🚰', '3 min shorter shower', '~11,000 L saved per year'),
      ('🔧', 'Fix a dripping tap', '~11,000 L saved per year'),
      ('🚿', 'Turn off tap while brushing', '~5,000 L saved per year'),
      ('🌿', 'Efficient garden watering', '~18,000 L saved per summer'),
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
                eyebrow: 'IMPACT PER ACTION',
                title: 'See What Each Action Saves',
                subtitle:
                    'Individual actions compound over time. Here are approximate annual savings per person.',
              ),
              SizedBox(height: isMobile ? 40 : 56),
              ResponsiveGrid(
                mobileColumns: 1,
                tabletColumns: 2,
                desktopColumns: 4,
                children: impacts
                    .map(
                      (item) => Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          gradient: AppColors.subtleGradient,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.cardBorder),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.$1,
                              style: const TextStyle(fontSize: 36),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              item.$2,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.darkText,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: AppColors.successGreen.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                item.$3,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.successGreen,
                                ),
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

class _CommitmentBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final padding = Responsive.pagePadding(context);
    final isMobile = Responsive.isMobile(context);

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primaryBlue, AppColors.waterBlue],
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: padding.horizontal / 2,
        vertical: 80,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              const Text(
                '🌊',
                style: TextStyle(fontSize: 64),
              ),
              const SizedBox(height: 24),
              const Text(
                'Make Every Drop Count',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                  color: AppColors.white,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Water is life. By making conscious choices every day, we contribute to a world where clean water and sanitation are a reality for everyone — not just a privilege for the few.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.skyBlue,
                  height: 1.7,
                ),
              ),
              const SizedBox(height: 40),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 16,
                runSpacing: 12,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 14),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      '💧 I Commit to Save Water',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
