import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../theme/app_theme.dart';
import '../data/sdg_data.dart';
import '../models/sdg_data_point.dart';
import '../widgets/common_widgets.dart';
import '../utils/responsive.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _chartTabController;
  int _selectedChartIndex = 0;

  final List<({
    String label,
    String icon,
    List<SdgDataPoint> data,
    String unit,
  })> _charts = const [
    (
      label: 'Water Access',
      icon: '💧',
      data: SdgData.waterAccessProgress,
      unit: '%',
    ),
    (
      label: 'Sanitation',
      icon: '🚽',
      data: SdgData.sanitationProgress,
      unit: '%',
    ),
    (
      label: 'Hygiene',
      icon: '🧼',
      data: SdgData.hygieneProgress,
      unit: '%',
    ),
    (
      label: 'Wastewater',
      icon: '♻️',
      data: SdgData.wastewaterTreatment,
      unit: '%',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _chartTabController = TabController(length: _charts.length, vsync: this);
    _chartTabController.addListener(() {
      if (_chartTabController.indexIsChanging) {
        setState(() => _selectedChartIndex = _chartTabController.index);
      }
    });
  }

  @override
  void dispose() {
    _chartTabController.dispose();
    super.dispose();
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
                  eyebrow: 'SDG 6 DASHBOARD',
                  title: 'Global Overview',
                  subtitle:
                      'Visualize progress toward SDG 6 targets with interactive charts and indicators. All data is illustrative.',
                  eyebrowColor: AppColors.skyBlue,
                  titleColor: AppColors.white,
                ),
              ),
            ),
          ),

          // Summary stats row
          Container(
            color: AppColors.white,
            padding: EdgeInsets.symmetric(
              horizontal: padding.horizontal / 2,
              vertical: 32,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: ResponsiveGrid(
                  mobileColumns: 2,
                  tabletColumns: 4,
                  desktopColumns: 4,
                  children: SdgData.homeStats
                      .map(
                        (s) => _MiniStatCard(
                          icon: s.icon,
                          value: s.value,
                          label: s.title,
                          trend: s.trend,
                          positive: s.trendPositive,
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),

          // Chart section
          Container(
            color: AppColors.lightGrey,
            padding: EdgeInsets.symmetric(
              horizontal: padding.horizontal / 2,
              vertical: Responsive.sectionSpacing(context),
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionHeader(
                      eyebrow: 'PROGRESS CHARTS',
                      title: 'SDG 6 Trend Analysis',
                      alignment: CrossAxisAlignment.start,
                    ),
                    const SizedBox(height: 32),

                    // Chart tabs
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.cardBorder),
                      ),
                      child: Column(
                        children: [
                          // Tab selector
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: _charts.asMap().entries.map((e) {
                                final isSelected =
                                    _selectedChartIndex == e.key;
                                return GestureDetector(
                                  onTap: () {
                                    setState(() =>
                                        _selectedChartIndex = e.key);
                                    _chartTabController.index = e.key;
                                  },
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? AppColors.primaryBlue
                                          : AppColors.lightGrey,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          e.value.icon,
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          e.value.label,
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: isSelected
                                                ? AppColors.white
                                                : AppColors.mediumGrey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),

                          Container(
                            height: 1,
                            color: AppColors.cardBorder,
                          ),

                          // Chart
                          Padding(
                            padding: const EdgeInsets.all(24),
                            child: SizedBox(
                              height: isMobile ? 240 : 320,
                              child: _LineChartWidget(
                                dataPoints: _charts[_selectedChartIndex].data,
                                unit: _charts[_selectedChartIndex].unit,
                                label: _charts[_selectedChartIndex].label,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Bar chart: water scarcity by region
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.cardBorder),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Water Access Gap by Region',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.darkText,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Estimated % of population lacking safe water access (illustrative)',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: AppColors.mediumGrey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(24),
                            child: SizedBox(
                              height: isMobile ? 240 : 280,
                              child: _BarChartWidget(
                                dataPoints: SdgData.waterScarcityByRegion,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Progress bars section
          Container(
            color: AppColors.white,
            padding: EdgeInsets.symmetric(
              horizontal: padding.horizontal / 2,
              vertical: Responsive.sectionSpacing(context),
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionHeader(
                      eyebrow: 'TARGET PROGRESS',
                      title: 'Progress Toward 2030 Targets',
                      subtitle:
                          'Each target requires 100% coverage by 2030. Current estimated progress shown below.',
                    ),
                    const SizedBox(height: 40),
                    ...SdgData.sdgProgressItems.map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: ProgressCard(
                          category: item.category,
                          current: item.current,
                          target: item.target,
                          unit: item.unit,
                          year: item.year,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.warningAmber.withOpacity(0.06),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.warningAmber.withOpacity(0.2),
                        ),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.info_outline,
                              size: 16, color: AppColors.warningAmber),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'All figures shown are illustrative estimates for educational purposes. Refer to UN-Water and WHO/UNICEF JMP for official data.',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.warningAmber,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
  }
}

// ─── Mini Stat Card ──────────────────────────────────────────────────────────

class _MiniStatCard extends StatelessWidget {
  final String icon;
  final String value;
  final String label;
  final String? trend;
  final bool positive;

  const _MiniStatCard({
    required this.icon,
    required this.value,
    required this.label,
    this.trend,
    required this.positive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder),
        boxShadow: [
          BoxShadow(
            color: AppColors.deepOcean.withOpacity(0.04),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(icon, style: const TextStyle(fontSize: 20)),
              const Spacer(),
              if (trend != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: (positive ? AppColors.successGreen : AppColors.dangerRed)
                        .withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    trend!,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: positive ? AppColors.successGreen : AppColors.dangerRed,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: AppColors.primaryBlue,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
              color: AppColors.mediumGrey,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Line Chart ──────────────────────────────────────────────────────────────

class _LineChartWidget extends StatelessWidget {
  final List<SdgDataPoint> dataPoints;
  final String unit;
  final String label;

  const _LineChartWidget({
    required this.dataPoints,
    required this.unit,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    // Separate actual vs target
    final actual = dataPoints.where((p) => p.label != 'Target').toList();
    final hasTarget = dataPoints.any((p) => p.label == 'Target');

    final minYear = actual.first.year.toDouble();
    final maxYear = hasTarget
        ? dataPoints.last.year.toDouble()
        : actual.last.year.toDouble();

    final spots = actual
        .map((p) => FlSpot(p.year.toDouble(), p.value))
        .toList();

    return LineChart(
      LineChartData(
        minX: minYear,
        maxX: maxYear,
        minY: 0,
        maxY: 100,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (value) => FlLine(
            color: AppColors.cardBorder,
            strokeWidth: 1,
          ),
        ),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                if (value % 25 != 0) return const SizedBox.shrink();
                return Text(
                  '${value.toInt()}$unit',
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.mediumGrey,
                  ),
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (value, meta) {
                final year = value.toInt();
                if (!actual.any((p) => p.year == year)) {
                  return const SizedBox.shrink();
                }
                return Text(
                  '$year',
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.mediumGrey,
                  ),
                );
              },
            ),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        lineBarsData: [
          // Actual data line
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: AppColors.primaryBlue,
            barWidth: 3,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) =>
                  FlDotCirclePainter(
                radius: 5,
                color: AppColors.primaryBlue,
                strokeWidth: 2,
                strokeColor: AppColors.white,
              ),
            ),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.primaryBlue.withOpacity(0.15),
                  AppColors.primaryBlue.withOpacity(0.0),
                ],
              ),
            ),
          ),

          // Target line (dashed)
          if (hasTarget)
            LineChartBarData(
              spots: [
                FlSpot(minYear, 100),
                FlSpot(maxYear, 100),
              ],
              isCurved: false,
              color: AppColors.successGreen,
              barWidth: 2,
              dashArray: [8, 4],
              dotData: const FlDotData(show: false),
            ),
        ],
        extraLinesData: const ExtraLinesData(),
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (touchedSpot) => AppColors.deepOcean,
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((ts) {
                return LineTooltipItem(
                  '${ts.x.toInt()}\n${ts.y.toStringAsFixed(1)}$unit',
                  const TextStyle(
                    color: AppColors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                );
              }).toList();
            },
          ),
        ),
      ),
    );
  }
}

// ─── Bar Chart ───────────────────────────────────────────────────────────────

class _BarChartWidget extends StatelessWidget {
  final List<SdgDataPoint> dataPoints;

  const _BarChartWidget({required this.dataPoints});

  @override
  Widget build(BuildContext context) {
    final colors = [
      AppColors.dangerRed,
      AppColors.warningAmber,
      AppColors.warningAmber,
      AppColors.primaryBlue,
      AppColors.successGreen,
      AppColors.successGreen,
    ];

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 100,
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (group) => AppColors.deepOcean,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                '${dataPoints[groupIndex].label ?? ''}\n${rod.toY.toStringAsFixed(0)}%',
                const TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                if (value % 20 != 0) return const SizedBox.shrink();
                return Text(
                  '${value.toInt()}%',
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.mediumGrey,
                  ),
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 52,
              getTitlesWidget: (value, meta) {
                final idx = value.toInt();
                if (idx < 0 || idx >= dataPoints.length) {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    dataPoints[idx].label ?? '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.mediumGrey,
                      height: 1.3,
                    ),
                  ),
                );
              },
            ),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (value) => FlLine(
            color: AppColors.cardBorder,
            strokeWidth: 1,
          ),
        ),
        borderData: FlBorderData(show: false),
        barGroups: dataPoints.asMap().entries.map((e) {
          final color = colors[e.key % colors.length];
          return BarChartGroupData(
            x: e.key,
            barRods: [
              BarChartRodData(
                toY: e.value.value,
                color: color,
                width: 28,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(6),
                ),
                backDrawRodData: BackgroundBarChartRodData(
                  show: true,
                  toY: 100,
                  color: AppColors.lightGrey,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
