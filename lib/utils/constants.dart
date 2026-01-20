import 'package:flutter/material.dart';

/// App-wide constants
class AppConstants {
  // Colors palette for kids
  static const List<Color> colorPalette = [
    Color(0xFFFF0000), // Red
    Color(0xFFFF4500), // Orange Red
    Color(0xFFFF6B00), // Orange
    Color(0xFFFFD700), // Gold
    Color(0xFFFFFF00), // Yellow
    Color(0xFFADFF2F), // Green Yellow
    Color(0xFF00FF00), // Green
    Color(0xFF32CD32), // Lime Green
    Color(0xFF00FA9A), // Medium Spring Green
    Color(0xFF00BFFF), // Sky Blue
    Color(0xFF0000FF), // Blue
    Color(0xFF00008B), // Dark Blue
    Color(0xFF4B0082), // Indigo
    Color(0xFF9370DB), // Purple
    Color(0xFFEE82EE), // Violet
    Color(0xFFFF1493), // Pink
    Color(0xFFFF69B4), // Hot Pink
    Color(0xFFFFC0CB), // Light Pink
    Color(0xFF8B4513), // Brown
    Color(0xFFD2691E), // Chocolate
    Color(0xFFFFFFFF), // White
    Color(0xFF808080), // Gray
    Color(0xFF000000), // Black
  ];

  // Default values
  static const double defaultStrokeWidth = 5.0;
  static const double minStrokeWidth = 2.0;
  static const double maxStrokeWidth = 20.0;

  // App colors
  static const Color primaryColor = Color(0xFF6C63FF);
  static const Color secondaryColor = Color(0xFFFF6584);
  static const Color backgroundColor = Color(0xFFF8F9FF);

  // Template categories
  static const List<String> categories = [
    'الكل',
    'حيوانات',
    'كرتون',
    'أعلام الدول',
    'حروف',
  ];

  // Templates
  static final List<Map<String, String>> templates = [
    // --- Animals ---
    {
      'id': 'bee',
      'name': 'نحلة نشيطة',
      'imagePath': 'assets/templates/animals/bee.png',
      'category': 'حيوانات'
    },
    {
      'id': 'beer',
      'name': 'دب كبير',
      'imagePath': 'assets/templates/animals/beer.png',
      'category': 'حيوانات'
    },
    {
      'id': 'bird',
      'name': 'عصفور مغرد',
      'imagePath': 'assets/templates/animals/bird.png',
      'category': 'حيوانات'
    },
    {
      'id': 'elephant',
      'name': 'فيل ضخم',
      'imagePath': 'assets/templates/animals/elephant.png',
      'category': 'حيوانات'
    },
    {
      'id': 'giraf',
      'name': 'زرافة طويلة',
      'imagePath': 'assets/templates/animals/giraf.png',
      'category': 'حيوانات'
    },
    {
      'id': 'lion',
      'name': 'أسد ملك',
      'imagePath': 'assets/templates/animals/lion.png',
      'category': 'حيوانات'
    },
    {
      'id': 'monkey',
      'name': 'قرد شقي',
      'imagePath': 'assets/templates/animals/monkey.png',
      'category': 'حيوانات'
    },
    {
      'id': 'shark',
      'name': 'قرش بحري',
      'imagePath': 'assets/templates/animals/shark.png',
      'category': 'حيوانات'
    },
    {
      'id': 'tiger',
      'name': 'نمر مخطط',
      'imagePath': 'assets/templates/animals/tiger.png',
      'category': 'حيوانات'
    },
    {
      'id': 'turtl',
      'name': 'سلحفاة بطيئة',
      'imagePath': 'assets/templates/animals/turtl.png',
      'category': 'حيوانات'
    },
    // --- Cartoons ---
    {
      'id': 'c1',
      'name': 'كرتون 1',
      'imagePath': 'assets/templates/cartoons/1.png',
      'category': 'كرتون'
    },
    {
      'id': 'c2',
      'name': 'كرتون 2',
      'imagePath': 'assets/templates/cartoons/2.png',
      'category': 'كرتون'
    },
    {
      'id': 'c3',
      'name': 'كرتون 3',
      'imagePath': 'assets/templates/cartoons/3.png',
      'category': 'كرتون'
    },
    {
      'id': 'c4',
      'name': 'كرتون 4',
      'imagePath': 'assets/templates/cartoons/4.png',
      'category': 'كرتون'
    },
    {
      'id': 'c5',
      'name': 'كرتون 5',
      'imagePath': 'assets/templates/cartoons/5.png',
      'category': 'كرتون'
    },
    {
      'id': 'c6',
      'name': 'كرتون 6',
      'imagePath': 'assets/templates/cartoons/6.png',
      'category': 'كرتون'
    },
    {
      'id': 'c7',
      'name': 'كرتون 7',
      'imagePath': 'assets/templates/cartoons/7.png',
      'category': 'كرتون'
    },
    {
      'id': 'c8',
      'name': 'كرتون 8',
      'imagePath': 'assets/templates/cartoons/8.png',
      'category': 'كرتون'
    },
    {
      'id': 'c9',
      'name': 'كرتون 9',
      'imagePath': 'assets/templates/cartoons/9.png',
      'category': 'كرتون'
    },
    {
      'id': 'c10',
      'name': 'كرتون 10',
      'imagePath': 'assets/templates/cartoons/10.png',
      'category': 'كرتون'
    },
    // --- Flags ---
    {
      'id': 'f_algeria',
      'name': 'علم الجزائر',
      'imagePath': 'assets/templates/flags/algeria.png',
      'category': 'أعلام الدول'
    },
    {
      'id': 'f_brazil',
      'name': 'علم البرازيل',
      'imagePath': 'assets/templates/flags/brazil.png',
      'category': 'أعلام الدول'
    },
    {
      'id': 'f_canada',
      'name': 'علم كندا',
      'imagePath': 'assets/templates/flags/canada.png',
      'category': 'أعلام الدول'
    },
    {
      'id': 'f_china',
      'name': 'علم الصين',
      'imagePath': 'assets/templates/flags/china.png',
      'category': 'أعلام الدول'
    },
    {
      'id': 'f_egypt',
      'name': 'علم مصر',
      'imagePath': 'assets/templates/flags/egypt.png',
      'category': 'أعلام الدول'
    },
    {
      'id': 'f_england',
      'name': 'علم إنجلترا',
      'imagePath': 'assets/templates/flags/england.png',
      'category': 'أعلام الدول'
    },
    {
      'id': 'f_germany',
      'name': 'علم ألمانيا',
      'imagePath': 'assets/templates/flags/germany.png',
      'category': 'أعلام الدول'
    },
    {
      'id': 'f_italy',
      'name': 'علم إيطاليا',
      'imagePath': 'assets/templates/flags/italy.png',
      'category': 'أعلام الدول'
    },
    {
      'id': 'f_japan',
      'name': 'علم اليابان',
      'imagePath': 'assets/templates/flags/japan.png',
      'category': 'أعلام الدول'
    },
    {
      'id': 'f_jordan',
      'name': 'علم الأردن',
      'imagePath': 'assets/templates/flags/jordanie.png',
      'category': 'أعلام الدول'
    },
    {
      'id': 'f_morocco',
      'name': 'علم المغرب',
      'imagePath': 'assets/templates/flags/morocco.png',
      'category': 'أعلام الدول'
    },
    {
      'id': 'f_palestine',
      'name': 'علم فلسطين',
      'imagePath': 'assets/templates/flags/palastine.png',
      'category': 'أعلام الدول'
    },
    {
      'id': 'f_saudi',
      'name': 'علم السعودية',
      'imagePath': 'assets/templates/flags/saoudi.png',
      'category': 'أعلام الدول'
    },
    {
      'id': 'f_tunisia',
      'name': 'علم تونس',
      'imagePath': 'assets/templates/flags/tunisia.png',
      'category': 'أعلام الدول'
    },
    // --- Letters ---
    {'id': 'l_alif', 'name': 'حرف الألف', 'imagePath': 'assets/templates/lettres/أ.png', 'category': 'حروف'},
    {'id': 'l_ba', 'name': 'حرف الباء', 'imagePath': 'assets/templates/lettres/ب.png', 'category': 'حروف'},
    {'id': 'l_ta', 'name': 'حرف التاء', 'imagePath': 'assets/templates/lettres/ت.png', 'category': 'حروف'},
    {'id': 'l_tha', 'name': 'حرف الثاء', 'imagePath': 'assets/templates/lettres/ث.png', 'category': 'حروف'},
    {'id': 'l_jim', 'name': 'حرف الجيم', 'imagePath': 'assets/templates/lettres/ج.png', 'category': 'حروف'},
    {'id': 'l_ha', 'name': 'حرف الحاء', 'imagePath': 'assets/templates/lettres/ح.png', 'category': 'حروف'},
    {'id': 'l_kha', 'name': 'حرف الخاء', 'imagePath': 'assets/templates/lettres/خ.png', 'category': 'حروف'},
    {'id': 'l_dal', 'name': 'حرف الدال', 'imagePath': 'assets/templates/lettres/د.png', 'category': 'حروف'},
    {'id': 'l_thal', 'name': 'حرف الذال', 'imagePath': 'assets/templates/lettres/ذ.png', 'category': 'حروف'},
    {'id': 'l_ra', 'name': 'حرف الراء', 'imagePath': 'assets/templates/lettres/ر.png', 'category': 'حروف'},
    {'id': 'l_zay', 'name': 'حرف الزاي', 'imagePath': 'assets/templates/lettres/ز.png', 'category': 'حروف'},
    {'id': 'l_sin', 'name': 'حرف السين', 'imagePath': 'assets/templates/lettres/س.png', 'category': 'حروف'},
    {'id': 'l_shin', 'name': 'حرف الشين', 'imagePath': 'assets/templates/lettres/ش.png', 'category': 'حروف'},
    {'id': 'l_sad', 'name': 'حرف الصاد', 'imagePath': 'assets/templates/lettres/ص.png', 'category': 'حروف'},
    {'id': 'l_dad', 'name': 'حرف الضاد', 'imagePath': 'assets/templates/lettres/ض.png', 'category': 'حروف'},
    {'id': 'l_ta_2', 'name': 'حرف الطاء', 'imagePath': 'assets/templates/lettres/ط.png', 'category': 'حروف'},
    {'id': 'l_za', 'name': 'حرف الظاء', 'imagePath': 'assets/templates/lettres/ظ.png', 'category': 'حروف'},
    {'id': 'l_ayn', 'name': 'حرف العين', 'imagePath': 'assets/templates/lettres/ع.png', 'category': 'حروف'},
    {'id': 'l_ghayn', 'name': 'حرف الغين', 'imagePath': 'assets/templates/lettres/غ.png', 'category': 'حروف'},
    {'id': 'l_fa', 'name': 'حرف الفاء', 'imagePath': 'assets/templates/lettres/ف.png', 'category': 'حروف'},
    {'id': 'l_qaf', 'name': 'حرف القاف', 'imagePath': 'assets/templates/lettres/ق.png', 'category': 'حروف'},
    {'id': 'l_kaf', 'name': 'حرف الكاف', 'imagePath': 'assets/templates/lettres/ك.png', 'category': 'حروف'},
    {'id': 'l_lam', 'name': 'حرف اللام', 'imagePath': 'assets/templates/lettres/ل.png', 'category': 'حروف'},
    {'id': 'l_mim', 'name': 'حرف الميم', 'imagePath': 'assets/templates/lettres/م.png', 'category': 'حروف'},
    {'id': 'l_nun', 'name': 'حرف النون', 'imagePath': 'assets/templates/lettres/ن.png', 'category': 'حروف'},
    {'id': 'l_ha_2', 'name': 'حرف الهاء', 'imagePath': 'assets/templates/lettres/ه.png', 'category': 'حروف'},
    {'id': 'l_waw', 'name': 'حرف الواو', 'imagePath': 'assets/templates/lettres/و.png', 'category': 'حروف'},
    {'id': 'l_ya', 'name': 'حرف الياء', 'imagePath': 'assets/templates/lettres/ي.png', 'category': 'حروف'},
  ];
}
