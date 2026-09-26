import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';

class AppFooter extends StatelessWidget {
  final Function(int)? onNavigate;

  const AppFooter({super.key, this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.deepOcean, Color(0xFF0D5F8F)],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 24 : 60,
          vertical: 60,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo and tagline
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.waterBlue.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: AppColors.waterBlue.withOpacity(0.3),
                    ),
                  ),
                  child: const Center(
                    child: Text('💧', style: TextStyle(fontSize: 24)),
                  ),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'AquaGuard',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: AppColors.white,
                        letterSpacing: -0.5,
                      ),
                    ),
                    Text(
                      'SDG 6 — Clean Water & Sanitation',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.skyBlue,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Tagline nav links
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              runSpacing: 4,
              children: ['Learn', 'Explore', 'Calculate', 'Act']
                  .map((s) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        child: Text(
                          s,
                          style: const TextStyle(
                            color: AppColors.skyBlue,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ))
                  .toList(),
            ),

            const SizedBox(height: 40),
            Container(
              height: 1,
              color: AppColors.white.withOpacity(0.1),
            ),
            const SizedBox(height: 24),

            // Bottom row
            if (isMobile)
              Column(
                children: [
                  const Text(
                    '© 2026 AquaGuard',
                    style: TextStyle(
                      color: AppColors.skyBlue,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Educational project focused on SDG 6 awareness.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.white.withOpacity(0.5),
                      fontSize: 12,
                    ),
                  ),
                ],
              )
            else
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '© 2026 AquaGuard',
                    style: TextStyle(
                      color: AppColors.skyBlue,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    'Educational project focused on SDG 6 awareness.',
                    style: TextStyle(
                      color: AppColors.white.withOpacity(0.5),
                      fontSize: 12,
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
