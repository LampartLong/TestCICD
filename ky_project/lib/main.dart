import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ky_project/Commons/ThemeData/theme_data.dart';
import 'package:ky_project/Helpers/app_routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: const [
        Locale('en'),
        Locale('ja'),
      ],
      locale: const Locale('ja'),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, listTileTheme: listTileThemeData, appBarTheme: appBarTheme, bottomNavigationBarTheme: bottomNavigationBarThemeData),
      initialRoute: AppRoutes.loading,
      getPages: AppRoutes.routes,
    );
  }
}
