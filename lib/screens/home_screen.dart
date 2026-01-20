import 'package:flutter/material.dart';
import 'canvas_screen.dart';
import 'template_screen.dart';
import '../utils/constants.dart';

/// Home screen with colorful welcome interface
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Dynamic Gradient Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF6C63FF),
                  Color(0xFFFF6584),
                  Color(0xFFFFD700),
                ],
              ),
            ),
          ),
          
          // Animated Decorative Elements
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Stack(
                children: [
                   _buildFloatingShape(
                    top: 100 + 20 * _controller.value,
                    left: 50 + 10 * _controller.value,
                    size: 80,
                    color: Colors.white.withOpacity(0.1),
                  ),
                  _buildFloatingShape(
                    bottom: 150 + 30 * (1 - _controller.value),
                    right: 40 + 15 * _controller.value,
                    size: 120,
                    color: Colors.white.withOpacity(0.15),
                  ),
                  _buildFloatingShape(
                    top: 250 - 40 * _controller.value,
                    right: 80,
                    size: 60,
                    color: Colors.white.withOpacity(0.1),
                  ),
                ],
              );
            },
          ),

          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // App Icon/Brand
                   TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(seconds: 1),
                    curve: Curves.elasticOut,
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: value,
                        child: Container(
                          padding: const EdgeInsets.all(25),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 20,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.palette_rounded,
                            size: 80,
                            color: Color(0xFF6C63FF),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  
                  // App Title
                  const Text(
                    'عالم الألوان',
                    style: TextStyle(
                      fontSize: 56,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Arial',
                      shadows: [
                        Shadow(
                          color: Colors.black26,
                          offset: Offset(3, 3),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    'أبدع، لوّن، وامرح!',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.2,
                    ),
                  ),
                  
                  const SizedBox(height: 70),
                  
                  // Navigation Buttons
                  _buildMenuButton(
                    context,
                    label: 'ابدأ الرسم الحر',
                    icon: Icons.brush_rounded,
                    color: Colors.white,
                    textColor: const Color(0xFF6C63FF),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CanvasScreen()),
                    ),
                  ),
                  
                  const SizedBox(height: 25),
                  
                  _buildMenuButton(
                    context,
                    label: 'قوالب التلوين',
                    icon: Icons.auto_awesome_motion_rounded,
                    color: const Color(0xFFFF6584),
                    textColor: Colors.white,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TemplateScreen()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingShape({double? top, double? bottom, double? left, double? right, required double size, required Color color}) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _buildMenuButton(
    BuildContext context, {
    required String label,
    required IconData icon,
    required Color color,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 1.0, end: 1.0), // Placeholder for animation if needed
      duration: const Duration(milliseconds: 200),
      builder: (context, scale, child) {
        return GestureDetector(
          onTap: onTap,
          child: Container(
            width: 300,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: textColor, size: 30),
                const SizedBox(width: 15),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                    fontFamily: 'Arial',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
