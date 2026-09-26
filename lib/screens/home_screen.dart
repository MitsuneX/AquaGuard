import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/sdg_data.dart';
import '../widgets/common_widgets.dart';
import '../widgets/app_navbar.dart';
import '../utils/responsive.dart';

class HomeScreen extends StatefulWidget {
  final Function(NavPage) onNavigate;

  const HomeScreen({super.key, required this.onNavigate});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _waveController;
  late AnimationController _heroController;
  late Animation<double> _heroFade;
  late Animation<Offset> _heroSlide;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    _heroController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _heroFade = CurvedAnimation(
      parent: _heroController,
      curve: Curves.easeOut,
    );

    _heroSlide = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _heroController,
      curve: Curves.easeOutCubic,
    ));

    _heroController.forward();
  }

  @override
  void dispose() {
    _waveController.dispose();
    _heroController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _HeroSection(
          waveController: _waveController,
          fadeAnimation: _heroFade,
          slideAnimation: _heroSlide,
          onExplore: () => widget.onNavigate(NavPage.water),
          onCalculate: () => widget.onNavigate(NavPage.calculator),
        ),
        _StatsSection(),
        _AboutSDG6Section(onNavigate: widget.onNavigate),
        _KeyChallengesSection(),
      ],
    );
  }
}

// ─── Hero Section ────────────────────────────────────────────────────────────

class _HeroSection extends StatelessWidget {
  final AnimationController waveController;
  final Animation<double> fadeAnimation;
  final Animation<Offset> slideAnimation;
  final VoidCallback onExplore;
  final VoidCallback onCalculate;

  const _HeroSection({
    required this.waveController,
    required this.fadeAnimation,
    required this.slideAnimation,
    required this.onExplore,
    required this.onCalculate,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);

    return Container(
      constraints: BoxConstraints(
        minHeight: isMobile ? 600 : 700,
      ),
      decoration: const BoxDecoration(
        gradient: AppColors.heroGradient,
      ),
      child: Stack(
        children: [
          // Animated wave background
          Positioned.fill(
            child: AnimatedBuilder(
              animation: waveController,
              builder: (context, child) {
                return CustomPaint(
                  painter: _WavePainter(waveController.value),
                );
              },
            ),
          ),

          // Floating decorative circles
          Positioned(
            top: 60,
            right: isMobile ? 20 : 120,
            child: _FloatingCircle(size: isMobile ? 120 : 200, opacity: 0.06),
          ),
          Positioned(
            bottom: 100,
            left: isMobile ? 10 : 60,
            child: _FloatingCircle(size: isMobile ? 80 : 140, opacity: 0.05),
          ),
          Positioned(
            top: 200,
            left: isMobile ? 200 : 500,
            child: _FloatingCircle(size: 60, opacity: 0.04),
          ),

          // Content
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 24 : isTablet ? 60 : 80,
              vertical: 80,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: isMobile || isTablet
                    ? _HeroContentColumn(
                        fadeAnimation: fadeAnimation,
                        slideAnimation: slideAnimation,
                        onExplore: onExplore,
                        onCalculate: onCalculate,
                        isMobile: isMobile,
                      )
                    : _HeroContentRow(
                        fadeAnimation: fadeAnimation,
                        slideAnimation: slideAnimation,
                        onExplore: onExplore,
                        onCalculate: onCalculate,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroContentColumn extends StatelessWidget {
  final Animation<double> fadeAnimation;
  final Animation<Offset> slideAnimation;
  final VoidCallback onExplore;
  final VoidCallback onCalculate;
  final bool isMobile;

  const _HeroContentColumn({
    required this.fadeAnimation,
    required this.slideAnimation,
    required this.onExplore,
    required this.onCalculate,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeAnimation,
      child: SlideTransition(
        position: slideAnimation,
        child: Column(
          crossAxisAlignment:
              isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            _HeroEyebrow(),
            SizedBox(height: 20),
            Text(
              'Clean Water.\nSafe Sanitation.\nA Healthier Future.',
              textAlign: isMobile ? TextAlign.center : TextAlign.left,
              style: TextStyle(
                fontSize: isMobile ? 36 : 48,
                fontWeight: FontWeight.w800,
                color: AppColors.white,
                letterSpacing: -1.0,
                height: 1.15,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'SDG 6 ensures every person on Earth has access to clean water and safe sanitation — the foundation of health, dignity, and sustainable development.',
              textAlign: isMobile ? TextAlign.center : TextAlign.left,
              style: TextStyle(
                fontSize: 16,
                color: AppColors.skyBlue,
                height: 1.7,
              ),
            ),
            SizedBox(height: 36),
            Wrap(
              alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
              spacing: 16,
              runSpacing: 12,
              children: [
                CustomButton(
                  label: 'Explore SDG 6',
                  onTap: onExplore,
                  dark: true,
                  icon: Icons.explore_outlined,
                ),
                CustomButton(
                  label: 'Calculate My Water Use',
                  onTap: onCalculate,
                  outlined: true,
                  dark: true,
                  icon: Icons.calculate_outlined,
                ),
              ],
            ),
            SizedBox(height: 48),
            _HeroStats(isMobile: isMobile),
          ],
        ),
      ),
    );
  }
}

class _HeroContentRow extends StatelessWidget {
  final Animation<double> fadeAnimation;
  final Animation<Offset> slideAnimation;
  final VoidCallback onExplore;
  final VoidCallback onCalculate;

  const _HeroContentRow({
    required this.fadeAnimation,
    required this.slideAnimation,
    required this.onExplore,
    required this.onCalculate,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: FadeTransition(
            opacity: fadeAnimation,
            child: SlideTransition(
              position: slideAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _HeroEyebrow(),
                  const SizedBox(height: 24),
                  const Text(
                    'Clean Water.\nSafe Sanitation.\nA Healthier Future.',
                    style: TextStyle(
                      fontSize: 56,
                      fontWeight: FontWeight.w800,
                      color: AppColors.white,
                      letterSpacing: -2.0,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'SDG 6 ensures every person on Earth has access to clean water and safe sanitation — the foundation of health, dignity, and sustainable development.',
                    style: TextStyle(
                      fontSize: 17,
                      color: AppColors.skyBlue,
                      height: 1.7,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      CustomButton(
                        label: 'Explore SDG 6',
                        onTap: onExplore,
                        dark: true,
                        icon: Icons.explore_outlined,
                      ),
                      const SizedBox(width: 16),
                      CustomButton(
                        label: 'Calculate My Water Use',
                        onTap: onCalculate,
                        outlined: true,
                        dark: true,
                        icon: Icons.calculate_outlined,
                      ),
                    ],
                  ),
                  const SizedBox(height: 56),
                  const _HeroStats(isMobile: false),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 60),
        Expanded(
          flex: 2,
          child: FadeTransition(
            opacity: fadeAnimation,
            child: _WaterDropVisual(),
          ),
        ),
      ],
    );
  }
}

class _HeroEyebrow extends StatelessWidget {
  const _HeroEyebrow();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.white.withOpacity(0.2)),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('🌍', style: TextStyle(fontSize: 14)),
          SizedBox(width: 8),
          Text(
            'SDG 6 — CLEAN WATER & SANITATION',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
              color: AppColors.skyBlue,
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroStats extends StatelessWidget {
  final bool isMobile;

  const _HeroStats({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final stats = [
      ('2B+', 'People lack safe water'),
      ('3.6B', 'Lack sanitation'),
      ('2030', 'SDG Target Year'),
    ];

    return Wrap(
      spacing: 32,
      runSpacing: 20,
      alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
      children: stats
          .map(
            (s) => Column(
              crossAxisAlignment: isMobile
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                Text(
                  s.$1,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: AppColors.white,
                  ),
                ),
                Text(
                  s.$2,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.skyBlue,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}

class _WaterDropVisual extends StatefulWidget {
  const _WaterDropVisual();

  @override
  State<_WaterDropVisual> createState() => _WaterDropVisualState();
}

class _WaterDropVisualState extends State<_WaterDropVisual>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _pulse = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _pulse,
      child: SizedBox(
        height: 400,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Outer glow ring
            Container(
              width: 320,
              height: 320,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.waterBlue.withOpacity(0.2),
                  width: 2,
                ),
              ),
            ),
            Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.waterBlue.withOpacity(0.15),
                  width: 2,
                ),
              ),
            ),
            // Main circle
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.waterBlue.withOpacity(0.4),
                    AppColors.primaryBlue.withOpacity(0.2),
                  ],
                ),
                border: Border.all(
                  color: AppColors.waterBlue.withOpacity(0.4),
                  width: 2,
                ),
              ),
              child: const Center(
                child: Text(
                  '💧',
                  style: TextStyle(fontSize: 80),
                ),
              ),
            ),
            // Floating stats
            Positioned(
              top: 40,
              right: 20,
              child: _FloatingStat('74%', 'Water Access'),
            ),
            Positioned(
              bottom: 60,
              left: 20,
              child: _FloatingStat('57%', 'Sanitation'),
            ),
          ],
        ),
      ),
    );
  }
}

class _FloatingStat extends StatelessWidget {
  final String value;
  final String label;

  const _FloatingStat(this.value, this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.white.withOpacity(0.2)),
        backdropFilter: null,
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.white,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.skyBlue,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _FloatingCircle extends StatelessWidget {
  final double size;
  final double opacity;

  const _FloatingCircle({required this.size, required this.opacity});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.waterBlue.withOpacity(opacity),
        border: Border.all(
          color: AppColors.waterBlue.withOpacity(opacity * 2),
          width: 1,
        ),
      ),
    );
  }
}

// Custom wave painter
class _WavePainter extends CustomPainter {
  final double progress;

  _WavePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.white.withOpacity(0.04)
      ..style = PaintingStyle.fill;

    for (var i = 0; i < 3; i++) {
      final path = Path();
      final offset = i * 0.3;
      final amplitude = 20.0 + i * 10;
      final yBase = size.height * (0.7 + i * 0.08);

      path.moveTo(0, yBase);
      for (var x = 0.0; x <= size.width; x += 1) {
        final y = yBase +
            amplitude *
                math.sin(2 * math.pi * ((x / size.width) + progress + offset));
        path.lineTo(x, y);
      }
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
      path.close();
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(_WavePainter oldDelegate) =>
      oldDelegate.progress != progress;
}

// ─── Stats Section ────────────────────────────────────────────────────────────

class _StatsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final padding = Responsive.pagePadding(context);

    return Container(
      color: AppColors.veryLightBlue,
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
                eyebrow: 'GLOBAL OVERVIEW',
                title: 'The State of SDG 6 Today',
                subtitle:
                    'Illustrative figures based on global estimates. Real progress is being made, but significant gaps remain.',
              ),
              SizedBox(height: isMobile ? 40 : 56),
              ResponsiveGrid(
                mobileColumns: 1,
                tabletColumns: 2,
                desktopColumns: 4,
                children: SdgData.homeStats
                    .map(
                      (s) => StatCard(
                        icon: s.icon,
                        title: s.title,
                        value: s.value,
                        trend: s.trend,
                        trendPositive: s.trendPositive,
                        description: s.description,
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.warningAmber.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.warningAmber.withOpacity(0.2),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.info_outline,
                        size: 14, color: AppColors.warningAmber),
                    SizedBox(width: 8),
                    Text(
                      'Data shown is illustrative. See UN-Water for official statistics.',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.warningAmber,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── About SDG 6 Section ─────────────────────────────────────────────────────

class _AboutSDG6Section extends StatelessWidget {
  final Function(NavPage) onNavigate;

  const _AboutSDG6Section({required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final padding = Responsive.pagePadding(context);

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
                    _AboutText(onNavigate: onNavigate),
                    const SizedBox(height: 48),
                    _SDGTargetsMini(),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5,
                      child: _AboutText(onNavigate: onNavigate),
                    ),
                    const SizedBox(width: 60),
                    Expanded(
                      flex: 4,
                      child: _SDGTargetsMini(),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class _AboutText extends StatelessWidget {
  final Function(NavPage) onNavigate;

  const _AboutText({required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          eyebrow: 'WHAT IS SDG 6?',
          title: 'Water and Sanitation for All',
          subtitle:
              'The United Nations Sustainable Development Goal 6 commits the global community to ensuring the availability and sustainable management of water and sanitation for every person on Earth by 2030.',
          alignment: CrossAxisAlignment.start,
        ),
        const SizedBox(height: 24),
        const Text(
          'Water is not just a resource — it is a fundamental human right. Yet billions of people still lack access to safe water and basic sanitation. SDG 6 provides a framework for addressing these challenges at every scale, from local communities to international policy.',
          style: TextStyle(
            fontSize: 15,
            color: AppColors.mediumGrey,
            height: 1.7,
          ),
        ),
        const SizedBox(height: 32),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            CustomButton(
              label: 'Learn About Water',
              onTap: () => onNavigate(NavPage.water),
              icon: Icons.water_drop_outlined,
            ),
            CustomButton(
              label: 'View Dashboard',
              onTap: () => onNavigate(NavPage.dashboard),
              outlined: true,
              icon: Icons.bar_chart_outlined,
            ),
          ],
        ),
      ],
    );
  }
}

class _SDGTargetsMini extends StatelessWidget {
  const _SDGTargetsMini();

  @override
  Widget build(BuildContext context) {
    final targets = [
      ('6.1', 'Safe drinking water', '💧'),
      ('6.2', 'Sanitation & hygiene', '🚽'),
      ('6.3', 'Water quality', '🧪'),
      ('6.4', 'Water-use efficiency', '♻️'),
      ('6.5', 'Integrated management', '🌍'),
      ('6.6', 'Water ecosystems', '🌿'),
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
          const Text(
            'SDG 6 Targets',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.darkText,
            ),
          ),
          const SizedBox(height: 16),
          ...targets.map(
            (t) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.primaryBlue.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(t.$3, style: const TextStyle(fontSize: 16)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.primaryBlue,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      t.$1,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    t.$2,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.darkText,
                      fontWeight: FontWeight.w500,
                    ),
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

// ─── Key Challenges Section ──────────────────────────────────────────────────

class _KeyChallengesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final padding = Responsive.pagePadding(context);
    final isMobile = Responsive.isMobile(context);

    final challenges = [
      (
        '🏜️',
        'Water Scarcity',
        'Over 2 billion people live in water-stressed countries. Climate change is making this worse.',
        AppColors.warningAmber,
      ),
      (
        '🦠',
        'Disease Risk',
        'Contaminated water causes millions of preventable deaths annually, especially among children.',
        AppColors.dangerRed,
      ),
      (
        '🚽',
        'Sanitation Gap',
        '3.6 billion people lack safely managed sanitation. Open defecation remains a major health hazard.',
        AppColors.primaryBlue,
      ),
      (
        '♀️',
        'Gender Inequality',
        'Women and girls disproportionately bear the burden of water collection in underserved regions.',
        AppColors.waterBlue,
      ),
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
                eyebrow: 'KEY CHALLENGES',
                title: 'Why SDG 6 Matters',
                subtitle:
                    'The water and sanitation crisis affects billions of lives. Understanding the scale helps us act.',
                eyebrowColor: AppColors.skyBlue,
                titleColor: AppColors.white,
              ),
              SizedBox(height: isMobile ? 40 : 56),
              ResponsiveGrid(
                mobileColumns: 1,
                tabletColumns: 2,
                desktopColumns: 4,
                children: challenges
                    .map(
                      (c) => _ChallengeCard(
                        icon: c.$1,
                        title: c.$2,
                        description: c.$3,
                        accentColor: c.$4,
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

class _ChallengeCard extends StatefulWidget {
  final String icon;
  final String title;
  final String description;
  final Color accentColor;

  const _ChallengeCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.accentColor,
  });

  @override
  State<_ChallengeCard> createState() => _ChallengeCardState();
}

class _ChallengeCardState extends State<_ChallengeCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: _hovered
              ? AppColors.white.withOpacity(0.1)
              : AppColors.white.withOpacity(0.06),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _hovered
                ? widget.accentColor.withOpacity(0.5)
                : AppColors.white.withOpacity(0.1),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: widget.accentColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Text(
                  widget.icon,
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.description,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.skyBlue,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
