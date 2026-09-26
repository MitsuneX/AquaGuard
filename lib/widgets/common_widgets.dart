import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Section header with eyebrow, title, and optional subtitle
class SectionHeader extends StatelessWidget {
  final String? eyebrow;
  final String title;
  final String? subtitle;
  final CrossAxisAlignment alignment;
  final Color? eyebrowColor;
  final Color? titleColor;

  const SectionHeader({
    super.key,
    this.eyebrow,
    required this.title,
    this.subtitle,
    this.alignment = CrossAxisAlignment.center,
    this.eyebrowColor,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    final textAlign = alignment == CrossAxisAlignment.center
        ? TextAlign.center
        : TextAlign.left;

    return Column(
      crossAxisAlignment: alignment,
      children: [
        if (eyebrow != null) ...[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withOpacity(0.08),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.primaryBlue.withOpacity(0.2),
              ),
            ),
            child: Text(
              eyebrow!,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
                color: eyebrowColor ?? AppColors.primaryBlue,
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
        Text(
          title,
          textAlign: textAlign,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: titleColor ?? AppColors.darkText,
              ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 16),
          Text(
            subtitle!,
            textAlign: textAlign,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.mediumGrey,
                ),
          ),
        ],
      ],
    );
  }
}

/// Statistic card widget
class StatCard extends StatefulWidget {
  final String icon;
  final String title;
  final String value;
  final String? trend;
  final bool trendPositive;
  final String description;

  const StatCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    this.trend,
    this.trendPositive = true,
    required this.description,
  });

  @override
  State<StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<StatCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _hovered ? AppColors.primaryBlue.withOpacity(0.3) : AppColors.cardBorder,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: AppColors.primaryBlue.withOpacity(0.12),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [
                  BoxShadow(
                    color: AppColors.deepOcean.withOpacity(0.04),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.icon, style: const TextStyle(fontSize: 32)),
                if (widget.trend != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: (widget.trendPositive
                              ? AppColors.successGreen
                              : AppColors.dangerRed)
                          .withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          widget.trendPositive
                              ? Icons.trending_up
                              : Icons.trending_down,
                          size: 12,
                          color: widget.trendPositive
                              ? AppColors.successGreen
                              : AppColors.dangerRed,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          widget.trend!,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: widget.trendPositive
                                ? AppColors.successGreen
                                : AppColors.dangerRed,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
                color: AppColors.mediumGrey,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              widget.value,
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: AppColors.primaryBlue,
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.description,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

/// Info card with icon, title, and description
class InfoCard extends StatefulWidget {
  final String icon;
  final String title;
  final String description;
  final String? detail;
  final Color? accentColor;
  final VoidCallback? onTap;

  const InfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.detail,
    this.accentColor,
    this.onTap,
  });

  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  bool _hovered = false;
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final accent = widget.accentColor ?? AppColors.primaryBlue;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.detail != null
            ? () => setState(() => _expanded = !_expanded)
            : widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _hovered ? accent.withOpacity(0.3) : AppColors.cardBorder,
            ),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: accent.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: AppColors.deepOcean.withOpacity(0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: accent.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Center(
                            child: Text(
                              widget.icon,
                              style: const TextStyle(fontSize: 24),
                            ),
                          ),
                        ),
                        if (widget.detail != null) ...[
                          const Spacer(),
                          AnimatedRotation(
                            duration: const Duration(milliseconds: 200),
                            turns: _expanded ? 0.5 : 0,
                            child: Icon(
                              Icons.keyboard_arrow_down,
                              color: accent,
                              size: 20,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      widget.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.darkText,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.mediumGrey,
                          ),
                    ),
                  ],
                ),
              ),
              if (_expanded && widget.detail != null)
                AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    decoration: BoxDecoration(
                      color: accent.withOpacity(0.04),
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(20),
                      ),
                    ),
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 1,
                          color: accent.withOpacity(0.15),
                          margin: const EdgeInsets.only(bottom: 16),
                        ),
                        Text(
                          widget.detail!,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.darkText,
                                height: 1.7,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Action card for Take Action page
class ActionCard extends StatefulWidget {
  final String icon;
  final String title;
  final String description;
  final String whyItMatters;
  final String impact;

  const ActionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.whyItMatters,
    required this.impact,
  });

  @override
  State<ActionCard> createState() => _ActionCardState();
}

class _ActionCardState extends State<ActionCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
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
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  )
                ]
              : [
                  BoxShadow(
                    color: AppColors.deepOcean.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  )
                ],
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    gradient: AppColors.cardGradient,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(
                    child: Text(
                      widget.icon,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    widget.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              widget.description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.darkText,
                  ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.veryLightBlue,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.cardBorder),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.lightbulb_outline,
                    size: 16,
                    color: AppColors.waterBlue,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.whyItMatters,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.darkText,
                            height: 1.5,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.successGreen.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.eco_outlined,
                        size: 12,
                        color: AppColors.successGreen,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        widget.impact,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.successGreen,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Progress bar card
class ProgressCard extends StatelessWidget {
  final String category;
  final double current;
  final double target;
  final String unit;
  final int year;

  const ProgressCard({
    super.key,
    required this.category,
    required this.current,
    required this.target,
    required this.unit,
    required this.year,
  });

  double get percentage => (current / target).clamp(0.0, 1.0);

  Color get progressColor {
    if (percentage >= 0.8) return AppColors.successGreen;
    if (percentage >= 0.5) return AppColors.primaryBlue;
    return AppColors.warningAmber;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  category,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              Text(
                '${current.toStringAsFixed(0)}$unit / ${target.toStringAsFixed(0)}$unit',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.mediumGrey,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Stack(
            children: [
              Container(
                height: 8,
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              FractionallySizedBox(
                widthFactor: percentage,
                child: Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: progressColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${(percentage * 100).toStringAsFixed(0)}% of target',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: progressColor,
                ),
              ),
              Text(
                'As of $year',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Custom button with hover effect
class CustomButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final bool outlined;
  final bool dark;
  final IconData? icon;

  const CustomButton({
    super.key,
    required this.label,
    required this.onTap,
    this.outlined = false,
    this.dark = false,
    this.icon,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isOutlined = widget.outlined;
    final isDark = widget.dark;

    Color bgColor;
    Color fgColor;
    Color borderColor;

    if (isDark && isOutlined) {
      bgColor = _hovered ? AppColors.white.withOpacity(0.1) : Colors.transparent;
      fgColor = AppColors.white;
      borderColor = AppColors.white.withOpacity(0.5);
    } else if (isOutlined) {
      bgColor = _hovered ? AppColors.primaryBlue.withOpacity(0.06) : Colors.transparent;
      fgColor = AppColors.primaryBlue;
      borderColor = AppColors.primaryBlue;
    } else {
      bgColor = _hovered
          ? AppColors.waterBlue
          : (isDark ? AppColors.white : AppColors.primaryBlue);
      fgColor = isDark ? AppColors.primaryBlue : AppColors.white;
      borderColor = Colors.transparent;
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 15),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderColor, width: 1.5),
            boxShadow: (!isOutlined && !_hovered)
                ? [
                    BoxShadow(
                      color: AppColors.primaryBlue.withOpacity(0.25),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[
                Icon(widget.icon, size: 18, color: fgColor),
                const SizedBox(width: 8),
              ],
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: fgColor,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Responsive grid container that adapts columns based on screen width
class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final int mobileColumns;
  final int tabletColumns;
  final int desktopColumns;
  final double spacing;
  final double runSpacing;

  const ResponsiveGrid({
    super.key,
    required this.children,
    this.mobileColumns = 1,
    this.tabletColumns = 2,
    this.desktopColumns = 4,
    this.spacing = 24,
    this.runSpacing = 24,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    int columns;
    if (width < 600) {
      columns = mobileColumns;
    } else if (width < 1024) {
      columns = tabletColumns;
    } else {
      columns = desktopColumns;
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth =
            (constraints.maxWidth - (spacing * (columns - 1))) / columns;

        final rows = <Widget>[];
        for (var i = 0; i < children.length; i += columns) {
          final rowItems = children.skip(i).take(columns).toList();
          rows.add(
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var j = 0; j < rowItems.length; j++) ...[
                  if (j > 0) SizedBox(width: spacing),
                  SizedBox(width: itemWidth, child: rowItems[j]),
                ],
                // Fill remaining space if row is incomplete
                if (rowItems.length < columns)
                  SizedBox(
                    width: (columns - rowItems.length) * (itemWidth + spacing),
                  ),
              ],
            ),
          );
          if (i + columns < children.length) {
            rows.add(SizedBox(height: runSpacing));
          }
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: rows,
        );
      },
    );
  }
}
