import 'package:flutter/material.dart';

import 'screen/login.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const CalcMateApp());
}

class CalcMateApp extends StatelessWidget {
  const CalcMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: CalcMateText.appName,
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: const LoginPage(),
    );
  }
}
