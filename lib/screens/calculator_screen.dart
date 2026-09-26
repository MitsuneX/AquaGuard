import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/water_data.dart';
import '../models/water_tip.dart';
import '../widgets/common_widgets.dart';
import '../utils/responsive.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final Map<String, double> _values = {};

  @override
  void initState() {
    super.initState();
    // Initialize with defaults
    for (final activity in WaterData.calculatorActivities) {
      _values[activity.id] = activity.defaultValue;
    }
  }

  double get _totalDailyLiters {
    double total = 0;
    for (final activity in WaterData.calculatorActivities) {
      total += activity.calculateDaily(_values[activity.id] ?? 0);
    }
    return total;
  }

  double get _weeklyLiters => _totalDailyLiters * 7;
  double get _monthlyLiters => _totalDailyLiters * 30;

  // Estimate "efficient" comparison
  double get _efficientDailyLiters {
    // Lower reference (4 min shower, 3 flushes, 1 laundry/week, etc.)
    const efficient = {
      'shower': 4.0,
      'laundry': 1.5 / 7.0,
      'dishes': 1.0,
      'toilet': 3.0,
      'garden': 0.0,
      'cooking': 3.0,
    };
    double total = 0;
    for (final activity in WaterData.calculatorActivities) {
      total += activity.calculateDaily(efficient[activity.id] ?? 0);
    }
    return total;
  }

  double get _potentialSaving {
    final saving = _totalDailyLiters - _efficientDailyLiters;
    return saving < 0 ? 0 : saving;
  }

  double get _savingPercentage {
    if (_totalDailyLiters == 0) return 0;
    return (_potentialSaving / _totalDailyLiters).clamp(0.0, 1.0);
  }

  Color get _usageColor {
    if (_totalDailyLiters < 100) return AppColors.successGreen;
    if (_totalDailyLiters < 200) return AppColors.primaryBlue;
    if (_totalDailyLiters < 300) return AppColors.warningAmber;
    return AppColors.dangerRed;
  }

  String get _usageLabel {
    if (_totalDailyLiters < 100) return 'Very Low — Excellent!';
    if (_totalDailyLiters < 150) return 'Low — Good Job!';
    if (_totalDailyLiters < 200) return 'Average';
    if (_totalDailyLiters < 300) return 'Above Average';
    return 'High — Room to Improve';
  }

  @override
  Widget build(BuildContext context) {
    final padding = Responsive.pagePadding(context);
    final isMobile = Responsive.isMobile(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
          // Header
          Container(
            decoration: const BoxDecoration(gradient: AppColors.heroGradient),
            padding: EdgeInsets.symmetric(
              horizontal: padding.horizontal / 2,
              vertical: 60,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: const SectionHeader(
                  eyebrow: 'WATER CALCULATOR',
                  title: 'How Much Water Do You Use?',
                  subtitle:
                      'Estimate your daily water consumption and discover where you can save.',
                  eyebrowColor: AppColors.skyBlue,
                  titleColor: AppColors.white,
                ),
              ),
            ),
          ),

          // Calculator body
          Container(
            color: AppColors.lightGrey,
            padding: EdgeInsets.symmetric(
              horizontal: padding.horizontal / 2,
              vertical: 48,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: isMobile
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _InputSection(
                            values: _values,
                            onChanged: (id, val) {
                              setState(() => _values[id] = val);
                            },
                          ),
                          const SizedBox(height: 32),
                          _ResultsSection(
                            totalDaily: _totalDailyLiters,
                            weekly: _weeklyLiters,
                            monthly: _monthlyLiters,
                            potentialSaving: _potentialSaving,
                            savingPercentage: _savingPercentage,
                            usageColor: _usageColor,
                            usageLabel: _usageLabel,
                            breakdown: _buildBreakdown(),
                          ),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 5,
                            child: _InputSection(
                              values: _values,
                              onChanged: (id, val) {
                                setState(() => _values[id] = val);
                              },
                            ),
                          ),
                          const SizedBox(width: 32),
                          Expanded(
                            flex: 4,
                            child: _ResultsSection(
                              totalDaily: _totalDailyLiters,
                              weekly: _weeklyLiters,
                              monthly: _monthlyLiters,
                              potentialSaving: _potentialSaving,
                              savingPercentage: _savingPercentage,
                              usageColor: _usageColor,
                              usageLabel: _usageLabel,
                              breakdown: _buildBreakdown(),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),

          // Tips section
          _CalculatorTipsSection(),
        ],
      );
  }

  List<({String icon, String name, double liters})> _buildBreakdown() {
    return WaterData.calculatorActivities.map((a) {
      return (
        icon: a.icon,
        name: a.name,
        liters: a.calculateDaily(_values[a.id] ?? 0),
      );
    }).where((b) => b.liters > 0).toList();
  }
}

// ─── Input Section ────────────────────────────────────────────────────────────

class _InputSection extends StatelessWidget {
  final Map<String, double> values;
  final Function(String, double) onChanged;

  const _InputSection({
    required this.values,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.tune,
                      color: AppColors.primaryBlue,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Daily Water Activities',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.darkText,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          ...WaterData.calculatorActivities.map(
            (activity) => _ActivitySlider(
              activity: activity,
              value: values[activity.id] ?? activity.defaultValue,
              onChanged: (v) => onChanged(activity.id, v),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActivitySlider extends StatelessWidget {
  final WaterActivity activity;
  final double value;
  final ValueChanged<double> onChanged;

  const _ActivitySlider({
    required this.activity,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final daily = activity.calculateDaily(value);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(activity.icon, style: const TextStyle(fontSize: 22)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          activity.name,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.darkText,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.primaryBlue.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${daily.toStringAsFixed(0)} L/day',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryBlue,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      activity.hint,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.mediumGrey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const SizedBox(width: 34),
              Expanded(
                child: Column(
                  children: [
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: AppColors.primaryBlue,
                        inactiveTrackColor: AppColors.cardBorder,
                        thumbColor: AppColors.primaryBlue,
                        overlayColor: AppColors.primaryBlue.withOpacity(0.1),
                        thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 8,
                        ),
                        trackHeight: 4,
                      ),
                      child: Slider(
                        value: value,
                        min: activity.min,
                        max: activity.max,
                        divisions: (activity.max - activity.min).toInt(),
                        onChanged: onChanged,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${activity.min.toInt()} ${activity.unit}',
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.mediumGrey,
                          ),
                        ),
                        Text(
                          '${value.toInt()} ${activity.unit}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.darkText,
                          ),
                        ),
                        Text(
                          '${activity.max.toInt()} ${activity.unit}',
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.mediumGrey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(height: 1),
        ],
      ),
    );
  }
}

// ─── Results Section ──────────────────────────────────────────────────────────

class _ResultsSection extends StatelessWidget {
  final double totalDaily;
  final double weekly;
  final double monthly;
  final double potentialSaving;
  final double savingPercentage;
  final Color usageColor;
  final String usageLabel;
  final List<({String icon, String name, double liters})> breakdown;

  const _ResultsSection({
    required this.totalDaily,
    required this.weekly,
    required this.monthly,
    required this.potentialSaving,
    required this.savingPercentage,
    required this.usageColor,
    required this.usageLabel,
    required this.breakdown,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Main result card
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.deepOcean, AppColors.primaryBlue],
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'YOUR ESTIMATED WATER USE',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                  color: AppColors.skyBlue,
                ),
              ),
              const SizedBox(height: 20),

              // Big number
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    totalDaily.toStringAsFixed(0),
                    style: TextStyle(
                      fontSize: 64,
                      fontWeight: FontWeight.w800,
                      color: usageColor,
                      height: 1.0,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10, left: 6),
                    child: Text(
                      'L/day',
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.skyBlue,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                usageLabel,
                style: TextStyle(
                  fontSize: 14,
                  color: usageColor,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 24),

              // Period breakdown
              Row(
                children: [
                  Expanded(
                    child: _PeriodStat(
                      label: 'Weekly',
                      value: '${weekly.toStringAsFixed(0)} L',
                    ),
                  ),
                  Expanded(
                    child: _PeriodStat(
                      label: 'Monthly',
                      value: '${monthly.toStringAsFixed(0)} L',
                    ),
                  ),
                  Expanded(
                    child: _PeriodStat(
                      label: 'Yearly',
                      value: '${(totalDaily * 365).toStringAsFixed(0)} L',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Breakdown card
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.cardBorder),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'BREAKDOWN',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                  color: AppColors.mediumGrey,
                ),
              ),
              const SizedBox(height: 16),
              if (breakdown.isEmpty)
                const Text(
                  'Adjust the sliders to see your breakdown.',
                  style: TextStyle(color: AppColors.mediumGrey),
                )
              else
                ...breakdown.map(
                  (b) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        Text(b.icon, style: const TextStyle(fontSize: 18)),
                        const SizedBox(width: 10),
                        Text(
                          b.name,
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.darkText,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '${b.liters.toStringAsFixed(0)} L',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              if (breakdown.isNotEmpty) ...[
                const Divider(),
                Row(
                  children: [
                    const Text(
                      'TOTAL',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.darkText,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${totalDaily.toStringAsFixed(0)} L/day',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Savings card
        if (potentialSaving > 0)
          Container(
            decoration: BoxDecoration(
              color: AppColors.successGreen.withOpacity(0.05),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  color: AppColors.successGreen.withOpacity(0.2)),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'YOUR POTENTIAL SAVING',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5,
                    color: AppColors.successGreen,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  '${potentialSaving.toStringAsFixed(0)} L/day',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: AppColors.successGreen,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'by adopting efficient water habits',
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.mediumGrey,
                  ),
                ),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Stack(
                    children: [
                      Container(
                        height: 12,
                        color: AppColors.lightGrey,
                      ),
                      FractionallySizedBox(
                        widthFactor: 1.0,
                        child: Container(
                          height: 12,
                          color: AppColors.primaryBlue.withOpacity(0.2),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: savingPercentage,
                        child: Container(
                          height: 12,
                          decoration: BoxDecoration(
                            color: AppColors.successGreen,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Saving ${(savingPercentage * 100).toStringAsFixed(0)}% with efficient habits',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.successGreen,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _PeriodStat extends StatelessWidget {
  final String label;
  final String value;

  const _PeriodStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.white,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: AppColors.skyBlue,
          ),
        ),
      ],
    );
  }
}

// ─── Calculator Tips ─────────────────────────────────────────────────────────

class _CalculatorTipsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final padding = Responsive.pagePadding(context);

    final tips = [
      ('🚿', 'Shorter Showers', 'Each minute less saves ~9 L'),
      ('🔧', 'Fix Leaks', 'A drip wastes 30+ L/day'),
      ('🚽', 'Low-Flush Toilet', 'Modern toilets use 4–6 L/flush'),
      ('🌿', 'Efficient Irrigation', 'Use drip systems and native plants'),
    ];

    return Container(
      color: AppColors.veryLightBlue,
      padding: EdgeInsets.symmetric(
        horizontal: padding.horizontal / 2,
        vertical: 60,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              const SectionHeader(
                eyebrow: 'SAVING TIPS',
                title: 'Quick Ways to Use Less',
              ),
              const SizedBox(height: 40),
              ResponsiveGrid(
                mobileColumns: 2,
                tabletColumns: 4,
                desktopColumns: 4,
                children: tips
                    .map(
                      (t) => Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.cardBorder),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(t.$1,
                                style: const TextStyle(fontSize: 28)),
                            const SizedBox(height: 12),
                            Text(
                              t.$2,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.darkText,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              t.$3,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.mediumGrey,
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
