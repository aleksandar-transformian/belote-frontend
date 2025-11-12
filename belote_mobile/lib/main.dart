import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/constants/app_constants.dart';
import 'core/theme/app_theme.dart';
import 'core/navigation/app_router.dart';
import 'core/di/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Initialize dependency injection
  await configureDependencies();

  runApp(const BeloteApp());
}

class BeloteApp extends StatelessWidget {
  const BeloteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: AppRouter.router,
    );
  }
}
