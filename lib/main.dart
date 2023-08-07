import 'package:huzbiz_app/core/routes/app_routes.dart';
import 'package:huzbiz_app/core/theme/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './core/data/provider/injection_container.dart' as di;

void main() {
  runApp(
    const MyApp(),
  );
  di.init();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'huzbiz',
      debugShowCheckedModeBanner: false,
      theme: AppThemes.getApplicationTheme(),
      initialRoute: AppRoute.splashRoute,
      routes: AppRoute.getAppRoutes(),
    );
  }
}
