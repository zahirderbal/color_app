import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import 'package:image/image.dart' as img;
import 'package:saver_gallery/saver_gallery.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../utils/constants.dart';

enum DrawingMode { brush, bucket }

class DrawingProvider extends ChangeNotifier {
  Color _selectedColor = const Color(0xFFFF0000);
  double _strokeWidth = 5.0;
  DrawingMode _currentMode = DrawingMode.bucket;
  String? _currentTemplate;
  ui.Image? _cachedUiImage;
  img.Image? _currentBitmap;
  
  // History for undo
  final List<img.Image> _history = [];

  Color get selectedColor => _selectedColor;
  double get strokeWidth => _strokeWidth;
  DrawingMode get currentMode => _currentMode;
  String? get currentTemplate => _currentTemplate;
  ui.Image? get canvasImage => _cachedUiImage;

  void setColor(Color color) {
    _selectedColor = color;
    notifyListeners();
  }

  void setStrokeWidth(double width) {
    _strokeWidth = width;
    notifyListeners();
  }

  void setDrawingMode(DrawingMode mode) {
    _currentMode = mode;
    notifyListeners();
  }

  Future<void> setTemplate(String? templatePath) async {
    _currentTemplate = templatePath;
    _history.clear();
    if (templatePath != null) {
      await _loadTemplate(templatePath);
    } else {
      _currentBitmap = null;
      _cachedUiImage = null;
    }
    notifyListeners();
  }

  Future<void> _loadTemplate(String path) async {
    try {
      debugPrint('Loading template: $path');
      final data = await rootBundle.load(path);
      final bytes = data.buffer.asUint8List();
      _currentBitmap = img.decodeImage(bytes);
      if (_currentBitmap != null) {
        if (!_currentBitmap!.hasAlpha) {
          _currentBitmap = _currentBitmap!.convert(numChannels: 4);
        }
        await _updateUiImage();
        debugPrint('Template loaded successfully: ${_currentBitmap!.width}x${_currentBitmap!.height}');
      } else {
        debugPrint('Failed to decode image');
      }
    } catch (e) {
      debugPrint('Error loading template: $e');
    }
  }

  Future<void> _updateUiImage() async {
    if (_currentBitmap == null) return;
    
    try {
      final rgbaBytes = _currentBitmap!.getBytes(order: img.ChannelOrder.rgba);
      final descriptor = ui.ImageDescriptor.raw(
        await ui.ImmutableBuffer.fromUint8List(rgbaBytes),
        width: _currentBitmap!.width,
        height: _currentBitmap!.height,
        pixelFormat: ui.PixelFormat.rgba8888,
      );
      final codec = await descriptor.instantiateCodec();
      final frame = await codec.getNextFrame();
      _cachedUiImage = frame.image;
      notifyListeners();
    } catch (e) {
      debugPrint('Error updating UI image: $e');
    }
  }

  void handleTap(Offset localPosition, Size canvasSize) {
    if (_currentBitmap == null) {
      debugPrint('Tap ignored: currentBitmap is null');
      return;
    }

    final double iw = _currentBitmap!.width.toDouble();
    final double ih = _currentBitmap!.height.toDouble();
    final double cw = canvasSize.width;
    final double ch = canvasSize.height;

    final double ir = iw / ih;
    final double cr = cw / ch;

    double scale;
    double dx = 0;
    double dy = 0;

    if (ir > cr) {
      scale = cw / iw;
      dy = (ch - ih * scale) / 2;
    } else {
      scale = ch / ih;
      dx = (cw - iw * scale) / 2;
    }

    final int x = ((localPosition.dx - dx) / scale).toInt();
    final int y = ((localPosition.dy - dy) / scale).toInt();

    debugPrint('Tap at: ${localPosition.dx}, ${localPosition.dy} -> Image pixel: $x, $y');

    if (x < 0 || x >= _currentBitmap!.width || y < 0 || y >= _currentBitmap!.height) {
      debugPrint('Tap out of bounds');
      return;
    }

    // Save state for undo
    _history.add(_currentBitmap!.clone());
    if (_history.length > 20) _history.removeAt(0);

    if (_currentMode == DrawingMode.bucket) {
      _floodFill(x, y, _selectedColor);
    } else {
      _drawCircle(x, y, _strokeWidth.toInt(), _selectedColor);
    }
    _updateUiImage();
  }

  void performStroke(Offset localPosition, Size canvasSize) {
    if (_currentBitmap == null || _currentMode != DrawingMode.brush) return;

    final double iw = _currentBitmap!.width.toDouble();
    final double ih = _currentBitmap!.height.toDouble();
    final double cw = canvasSize.width;
    final double ch = canvasSize.height;

    final double ir = iw / ih;
    final double cr = cw / ch;

    double scale;
    double dx = 0;
    double dy = 0;

    if (ir > cr) {
      scale = cw / iw;
      dy = (ch - ih * scale) / 2;
    } else {
      scale = ch / ih;
      dx = (cw - iw * scale) / 2;
    }

    final int x = ((localPosition.dx - dx) / scale).toInt();
    final int y = ((localPosition.dy - dy) / scale).toInt();

    if (x < 0 || x >= _currentBitmap!.width || y < 0 || y >= _currentBitmap!.height) return;

    _drawCircle(x, y, _strokeWidth.toInt(), _selectedColor);
    _updateUiImage();
  }

  void _drawCircle(int cx, int cy, int radius, Color color) {
    if (_currentBitmap == null) return;
    
    final replacementColor = img.ColorInt32.rgba(color.red, color.green, color.blue, 255);
    
    for (int y = -radius; y <= radius; y++) {
      for (int x = -radius; x <= radius; x++) {
        if (x * x + y * y <= radius * radius) {
          final int px = cx + x;
          final int py = cy + y;
          if (px >= 0 && px < _currentBitmap!.width && py >= 0 && py < _currentBitmap!.height) {
            _currentBitmap!.setPixel(px, py, replacementColor);
          }
        }
      }
    }
  }

  void _floodFill(int x, int y, Color color) {
    if (_currentBitmap == null) return;

    final targetPixel = _currentBitmap!.getPixel(x, y);
    // CRITICAL: Extract the actual color values so we don't compare against the modified pixel
    final int tr = targetPixel.r.toInt();
    final int tg = targetPixel.g.toInt();
    final int tb = targetPixel.b.toInt();
    final int ta = targetPixel.a.toInt();
    
    final replacementColor = img.ColorInt32.rgba(color.red, color.green, color.blue, 255);

    debugPrint('Target Color: R:$tr, G:$tg, B:$tb, A:$ta');

    if (_isBlackLine(targetPixel)) {
      debugPrint('Tapped on black line, fill cancelled');
      return;
    }
    
    if (tr == color.red && tg == color.green && tb == color.blue && ta == 255) {
      debugPrint('Color is already the same, fill cancelled');
      return;
    }

    final int width = _currentBitmap!.width;
    final int height = _currentBitmap!.height;
    
    final List<int> queue = [x, y];
    final Set<int> visited = {y * width + x};

    int filledCount = 0;
    while (queue.isNotEmpty) {
      final int curY = queue.removeLast();
      final int curX = queue.removeLast();

      _currentBitmap!.setPixel(curX, curY, replacementColor);
      filledCount++;

      // Check 4 neighbors
      final List<List<int>> neighbors = [
        [curX + 1, curY],
        [curX - 1, curY],
        [curX, curY + 1],
        [curX, curY - 1],
      ];

      for (var n in neighbors) {
        final nx = n[0];
        final ny = n[1];
        if (nx < 0 || nx >= width || ny < 0 || ny >= height) continue;

        final key = ny * width + nx;
        if (visited.contains(key)) continue;

        final nPixel = _currentBitmap!.getPixel(nx, ny);
        
        // Use the extracted target color values for comparison
        if (!_isBlackLine(nPixel) && _isSimilarToValues(nPixel, tr, tg, tb, ta, tolerance: 100)) {
          visited.add(key);
          queue.add(nx);
          queue.add(ny);
        }
      }
      
      // Safety break to prevent infinite loops or memory issues in very large areas
      if (filledCount > 500000) break; 
    }
    debugPrint('Flood fill completed. Filled $filledCount pixels.');
  }

  bool _isSimilarToValues(img.Pixel p, int r, int g, int b, int a, {int tolerance = 30}) {
    if (p.a < 50 && a < 50) return true;
    if ((p.a < 50) != (a < 50)) return false;

    return (p.r - r).abs() < tolerance &&
           (p.g - g).abs() < tolerance &&
           (p.b - b).abs() < tolerance;
  }

  bool _isBlackLine(img.Color color) {
    // Treat any color with very low luminance and high alpha as a boundary line
    // If alpha is low (transparent), it's not a black line, it's just background.
    if (color.a < 50) return false;
    
    final double r = color.r.toDouble();
    final double g = color.g.toDouble();
    final double b = color.b.toDouble();
    final lum = (0.299 * r + 0.587 * g + 0.114 * b);
    
    return lum < 80; // Black or very dark gray lines
  }

  bool _isSimilar(img.Color c1, img.Color c2, {int tolerance = 30}) {
    // If both are transparent, they are similar
    if (c1.a < 50 && c2.a < 50) return true;
    
    // If one is transparent and other isn't, they are not similar
    if ((c1.a < 50) != (c2.a < 50)) return false;

    return (c1.r - c2.r).abs() < tolerance &&
           (c1.g - c2.g).abs() < tolerance &&
           (c1.b - c2.b).abs() < tolerance;
  }

  void undo() {
    if (_history.isNotEmpty) {
      _currentBitmap = _history.removeLast();
      _updateUiImage();
    }
  }

  void clear() {
    if (_currentTemplate != null) {
      _loadTemplate(_currentTemplate!);
    }
  }

  Future<bool> saveToGallery() async {
    if (_currentBitmap == null) return false;

    try {
      // Encode the image to PNG
      final bytes = Uint8List.fromList(img.encodePng(_currentBitmap!));
      
      // Save to gallery using saver_gallery
      final result = await SaverGallery.saveImage(
        bytes,
        quality: 100,
        name: 'drawing_${DateTime.now().millisecondsSinceEpoch}.png',
        androidRelativePath: 'Pictures/ColoringWorld',
        androidExistNotSave: false,
      );
      
      debugPrint('Image saved result: $result');
      return result.isSuccess;
    } catch (e) {
      debugPrint('Error saving image to gallery: $e');
      return false;
    }
  }

  Future<String?> saveToTempFile() async {
    if (_currentBitmap == null) return null;
    try {
      final bytes = Uint8List.fromList(img.encodePng(_currentBitmap!));
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/temp_drawing_${DateTime.now().millisecondsSinceEpoch}.png');
      await file.writeAsBytes(bytes);
      return file.path;
    } catch (e) {
      debugPrint('Error saving temp file: $e');
      return null;
    }
  }

  bool get canUndo => _history.isNotEmpty;
  
  // Stubs for old methods to avoid breakages if any
  void addPoint(dynamic p) {}
  get points => [];
}
