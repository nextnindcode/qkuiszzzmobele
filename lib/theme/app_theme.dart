import 'package:flutter/material.dart';

class AppColors {
  static const Color coklatTua = Color(0xFF7A3F0D); // appbar & judul
  static const Color orangeTerang = Color(0xFFCD7E07); // aksen
  static const Color orangeGelap = Color(0xFF9D2F04); // aksen gelap
  static const Color krem = Color(0xFFFCECD8); // background
  static const Color putih = Color(0xFFFFFFFF); // card
  static const Color hijauTua = Color(0xFF2E7D32); // tombol utama
  static const Color hijauSage = Color(0xFF8FAF7A); // aksen sekunder
  static const Color error = Color(0xFFB00020);
}

OutlineInputBorder _border(Color color, {double width = 1.5}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(14),
    borderSide: BorderSide(color: color, width: width),
  );
}

final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: AppColors.krem,
  primaryColor: AppColors.coklatTua,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.hijauTua,
    primary: AppColors.coklatTua,
    secondary: AppColors.hijauSage,
    tertiary: AppColors.krem,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.coklatTua,
    foregroundColor: AppColors.krem,
    centerTitle: true,
    elevation: 0,
    scrolledUnderElevation: 0,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: AppColors.krem,
      letterSpacing: 0.3,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.hijauTua,
      foregroundColor: AppColors.krem,
      disabledBackgroundColor: AppColors.hijauSage,
      elevation: 3,
      minimumSize: const Size(double.infinity, 52),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.putih,
    floatingLabelStyle: const TextStyle(color: AppColors.hijauTua),
    border: _border(AppColors.hijauSage),
    enabledBorder: _border(AppColors.hijauSage),
    focusedBorder: _border(AppColors.hijauTua, width: 2),
    errorBorder: _border(AppColors.error),
    focusedErrorBorder: _border(AppColors.error, width: 2),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.putih,
    selectedItemColor: AppColors.coklatTua,
    unselectedItemColor: Colors.grey,
    type: BottomNavigationBarType.fixed,
    showUnselectedLabels: true,
    elevation: 12,
    selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
  ),
);
