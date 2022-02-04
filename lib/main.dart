import 'package:ennea_wallet/screens/splash_screen.dart';
import 'package:ennea_wallet/theme/ThemeService.dart';
import 'package:get_storage/get_storage.dart';

import 'theme/Themes.dart';
import 'package:ennea_wallet/screens/create_wallet_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeService().theme,
      home: const SplashScreen(),
    );
  }
}
