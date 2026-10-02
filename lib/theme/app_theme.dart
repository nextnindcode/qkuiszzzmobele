import 'package:flutter/material.dart';

class AppColors {
  static const Color coklatTua = Color(0xFF5C3D2E);
  static const Color coklat = Color(0xFF7A5543);
  static const Color terracotta = Color(0xFFA96B4F);
  static const Color orangeTerang = Color(0xFFC58A5A);
  static const Color krem = Color(0xFFF4E8D8);
  static const Color kremMuda = Color(0xFFFBF7F1);
  static const Color putih = Color(0xFFFFFCF8);
  static const Color hijauTua = Color(0xFF4F6F52);
  static const Color hijauSage = Color(0xFF91A586);
  static const Color hijauMuda = Color(0xFFDCE5D5);
  static const Color teks = Color(0xFF463B35);
  static const Color teksSekunder = Color(0xFF7A706A);
  static const Color garis = Color(0xFFDCCFC1);
  static const Color error = Color(0xFFB84A42);
  static const Color orangeGelap = Color(0xFF8A4F32);
}

OutlineInputBorder _border(Color color,{double width=1.4}) => OutlineInputBorder(
  borderRadius: BorderRadius.circular(14),
  borderSide: BorderSide(color: color,width: width),
);

final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: AppColors.kremMuda,
  primaryColor: AppColors.coklatTua,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.hijauTua,
    primary: AppColors.coklatTua,
    secondary: AppColors.hijauTua,
    tertiary: AppColors.terracotta,
    surface: AppColors.putih,
    error: AppColors.error,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.coklatTua,
    foregroundColor: AppColors.krem,
    centerTitle: false,
    elevation: 0,
    scrolledUnderElevation: 0,
    titleTextStyle: TextStyle(fontSize: 19,fontWeight: FontWeight.w700,color: AppColors.krem),
  ),
  cardTheme: CardThemeData(
    color: AppColors.putih,
    elevation: 0,
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18),
      side: const BorderSide(color: AppColors.garis),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.hijauTua,
      foregroundColor: AppColors.kremMuda,
      disabledBackgroundColor: AppColors.hijauSage,
      elevation: 2,
      minimumSize: const Size(double.infinity,52),
      textStyle: const TextStyle(fontSize:15,fontWeight:FontWeight.w700),
      shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(14)),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled:true,
    fillColor:AppColors.putih,
    labelStyle:const TextStyle(color:AppColors.teksSekunder),
    floatingLabelStyle:const TextStyle(color:AppColors.hijauTua),
    hintStyle:const TextStyle(color:AppColors.teksSekunder),
    border:_border(AppColors.garis),
    enabledBorder:_border(AppColors.garis),
    focusedBorder:_border(AppColors.hijauSage,width:2),
    errorBorder:_border(AppColors.error),
    focusedErrorBorder:_border(AppColors.error,width:2),
    prefixIconColor:AppColors.hijauTua,
  ),
  bottomNavigationBarTheme:const BottomNavigationBarThemeData(
    backgroundColor:AppColors.putih,
    selectedItemColor:AppColors.hijauTua,
    unselectedItemColor:AppColors.teksSekunder,
    type:BottomNavigationBarType.fixed,
    showUnselectedLabels:true,
    elevation:12,
  ),
);

class CalcMateText {
  static const String appName='CalcMate';
  static const String tagline='Hitung lebih mudah, pahami lebih jelas.';
}
