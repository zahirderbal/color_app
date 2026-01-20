import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:confetti/confetti.dart';
import 'package:share_plus/share_plus.dart';
import '../providers/drawing_provider.dart';
import '../widgets/drawing_canvas.dart';
import '../widgets/color_picker.dart';
import '../widgets/brush_size_slider.dart';
import '../utils/constants.dart';

/// Main canvas screen for drawing
class CanvasScreen extends StatefulWidget {
  const CanvasScreen({super.key});

  @override
  State<CanvasScreen> createState() => _CanvasScreenState();
}

class _CanvasScreenState extends State<CanvasScreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'لوحة الرسم',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          // Tool selection (Brush/Bucket)
          Consumer<DrawingProvider>(
            builder: (context, provider, child) {
              return Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.brush,
                      color: provider.currentMode == DrawingMode.brush
                          ? Colors.white
                          : Colors.white.withOpacity(0.5),
                    ),
                    onPressed: () => provider.setDrawingMode(DrawingMode.brush),
                    tooltip: 'فرشاة',
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.format_color_fill,
                      color: provider.currentMode == DrawingMode.bucket
                          ? Colors.white
                          : Colors.white.withOpacity(0.5),
                    ),
                    onPressed: () => provider.setDrawingMode(DrawingMode.bucket),
                    tooltip: 'دلو التلوين',
                  ),
                ],
              );
            },
          ),
          // Save button
          Consumer<DrawingProvider>(
            builder: (context, provider, child) {
              return IconButton(
                icon: const Icon(Icons.save_alt),
                onPressed: () async {
                  final success = await provider.saveToGallery();
                  if (mounted) {
                    if (success) {
                      _confettiController.play();
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          success ? 'تم حفظ الصورة في المعرض!' : 'فشل حفظ الصورة',
                          textDirection: TextDirection.rtl,
                        ),
                        backgroundColor: success ? Colors.green : Colors.red,
                      ),
                    );
                  }
                },
                tooltip: 'حفظ في المعرض',
              );
            },
          ),
          // Share button
          Consumer<DrawingProvider>(
            builder: (context, provider, child) {
              return IconButton(
                icon: const Icon(Icons.share_rounded),
                onPressed: () async {
                  final path = await provider.saveToTempFile();
                  if (path != null) {
                    await Share.shareXFiles(
                      [XFile(path)],
                      text: 'انظر إلى رسمي الجميل في عالم الألوان! 🎨✨',
                    );
                  }
                },
                tooltip: 'مشاركة الرسم',
              );
            },
          ),
          // Undo button
          Consumer<DrawingProvider>(
            builder: (context, provider, child) {
              return IconButton(
                icon: const Icon(Icons.undo),
                onPressed: provider.canUndo ? provider.undo : null,
                tooltip: 'تراجع',
              );
            },
          ),
          // Clear button
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () {
              _showClearDialog(context);
            },
            tooltip: 'مسح الكل',
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
            children: [
              // Brush size control
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    BrushSizeSlider(),
                  ],
                ),
              ),
              
              // Drawing canvas
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: const DrawingCanvas(),
                  ),
                ),
              ),
              
              // Color picker
              const ColorPicker(),
            ],
          ),
          // Confetti effect on top
          ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: false,
            colors: const [
              Colors.green,
              Colors.blue,
              Colors.pink,
              Colors.orange,
              Colors.purple,
              Colors.yellow
            ],
          ),
        ],
      ),
    );
  }

  void _showClearDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text(
            'مسح الرسم',
            textDirection: TextDirection.rtl,
          ),
          content: const Text(
            'هل تريد مسح كل الرسم؟',
            textDirection: TextDirection.rtl,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('إلغاء'),
            ),
            TextButton(
              onPressed: () {
                Provider.of<DrawingProvider>(context, listen: false).clear();
                Navigator.pop(dialogContext);
              },
              child: const Text(
                'مسح',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
