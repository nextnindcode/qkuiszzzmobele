import 'package:flutter/material.dart';

import 'theme/app_theme.dart';
import 'screen/main_page.dart';

void main() {
  runApp(const KuisApp());
}

class KuisApp extends StatelessWidget {
  const KuisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kuis Mobile',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: const MainPage(),
    );
  }
}
