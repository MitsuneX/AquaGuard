import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const AquaGuardRoot());
}

class AquaGuardRoot extends StatelessWidget {
  const AquaGuardRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AquaGuard — Clean Water & Sanitation',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const AquaGuardApp(),
    );
  }
}
