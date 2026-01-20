import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/drawing_provider.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DrawingProvider(),
      child: MaterialApp(
        title: 'عالم الألوان',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF6C63FF),
            brightness: Brightness.light,
          ),
          useMaterial3: true,
          fontFamily: 'Arial',
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
