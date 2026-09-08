import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

const Color usAccent = Color(0xFFD32F2F);
const Color usDark = Color(0xFF121212);
const Color usDisplay = Color(0xFF0A0A0A);
const Color usCanvas = Color(0xFFF8F9FA);
const Color usGrid = Color(0xFFE2E8F0);
const Color usText = Color(0xFF1A1A1A);
const Color usMargin = Color(0xFFE53935);

TextStyle _usFont({double? size, FontWeight? weight, double? letterSpacing, double? height, Color? color}) =>
    GoogleFonts.jetBrainsMono(fontSize: size, fontWeight: weight, letterSpacing: letterSpacing, height: height, color: color);

const MethodChannel _widgetChannel = MethodChannel('ido1note/widget');

void main() {
  runApp(const QuickNoteApp());
}

class QuickNoteApp extends StatelessWidget {
  const QuickNoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IDO1NOTE',
      debugShowCheckedModeBanner: false,
      theme: _lightTheme,
      darkTheme: _darkTheme,
      themeMode: ThemeMode.system,
      home: const NoteScreen(),
    );
  }

  ThemeData get _lightTheme => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: usCanvas,
        colorScheme: const ColorScheme.light(
          primary: usAccent,
          onPrimary: Colors.white,
          surface: usCanvas,
          onSurface: usText,
          onSurfaceVariant: Color(0xFF525252),
          outline: usGrid,
          outlineVariant: usGrid,
          surfaceContainerHighest: Color(0xFFF0F0F0),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: usCanvas,
          contentPadding: const EdgeInsets.all(16),
          hintStyle: _usFont(size: 13, color: const Color(0xFF888888)),
          border: _border(),
          enabledBorder: _border(),
          focusedBorder: _border(usAccent, 2),
          errorBorder: _border(usMargin),
          focusedErrorBorder: _border(usMargin, 2),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: usCanvas,
          foregroundColor: usText,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: _usFont(size: 18, weight: FontWeight.w700, letterSpacing: 0.08, color: usText),
          iconTheme: const IconThemeData(color: usText, size: 22),
        ),
        textTheme: TextTheme(
          bodyLarge: _usFont(size: 16, height: 1.5, color: usText),
          bodyMedium: _usFont(size: 14, height: 1.5, color: usText),
          labelLarge: _usFont(size: 11, weight: FontWeight.w500, letterSpacing: 0.08),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: usAccent,
            foregroundColor: Colors.white,
            side: const BorderSide(color: usAccent),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            textStyle: _usFont(size: 11, weight: FontWeight.w500, letterSpacing: 0.08),
            minimumSize: const Size(0, 38),
            elevation: 0,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: usText,
            side: const BorderSide(color: usText),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            textStyle: _usFont(size: 11, weight: FontWeight.w500, letterSpacing: 0.08),
            minimumSize: const Size(0, 38),
          ),
        ),
        cardTheme: CardTheme(
          color: usCanvas,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: usGrid),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        dividerTheme: const DividerThemeData(
          color: usGrid,
          thickness: 1,
        ),
      );

  ThemeData get _darkTheme => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: usDisplay,
        colorScheme: const ColorScheme.dark(
          primary: usAccent,
          onPrimary: Colors.white,
          surface: Color(0xFF1A1A1A),
          onSurface: Color(0xFFE2E8F0),
          onSurfaceVariant: Color(0xFFA0A0A0),
          outline: Color(0xFF2A2A2A),
          outlineVariant: Color(0xFF2A2A2A),
          surfaceContainerHighest: Color(0xFF222222),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF1A1A1A),
          contentPadding: const EdgeInsets.all(16),
          hintStyle: _usFont(size: 13, color: const Color(0xFF666666)),
          border: _border(const Color(0xFF2A2A2A)),
          enabledBorder: _border(const Color(0xFF2A2A2A)),
          focusedBorder: _border(usAccent, 2),
          errorBorder: _border(usMargin),
          focusedErrorBorder: _border(usMargin, 2),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: usDark,
          foregroundColor: const Color(0xFFE2E8F0),
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: _usFont(size: 18, weight: FontWeight.w700, letterSpacing: 0.08, color: const Color(0xFFE2E8F0)),
          iconTheme: const IconThemeData(color: Color(0xFFE2E8F0), size: 22),
        ),
        textTheme: TextTheme(
          bodyLarge: _usFont(size: 16, height: 1.5, color: const Color(0xFFE2E8F0)),
          bodyMedium: _usFont(size: 14, height: 1.5, color: const Color(0xFFE2E8F0)),
          labelLarge: _usFont(size: 11, weight: FontWeight.w500, letterSpacing: 0.08, color: const Color(0xFFE2E8F0)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: usAccent,
            foregroundColor: Colors.white,
            side: const BorderSide(color: usAccent),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            textStyle: _usFont(size: 11, weight: FontWeight.w500, letterSpacing: 0.08),
            minimumSize: const Size(0, 38),
            elevation: 0,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFFE2E8F0),
            side: const BorderSide(color: Color(0xFFE2E8F0)),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            textStyle: _usFont(size: 11, weight: FontWeight.w500, letterSpacing: 0.08),
            minimumSize: const Size(0, 38),
          ),
        ),
        cardTheme: CardTheme(
          color: const Color(0xFF1A1A1A),
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Color(0xFF2A2A2A)),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        dividerTheme: const DividerThemeData(
          color: Color(0xFF2A2A2A),
          thickness: 1,
        ),
      );

  OutlineInputBorder _border([Color? color, double width = 1]) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: color ?? usGrid, width: width),
      );
}

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = true;
  late AnimationController _knobController;
  bool _hasContent = false;

  @override
  void initState() {
    super.initState();
    _knobController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _loadNote();
  }

  Future<void> _loadNote() async {
    try {
      final content = await _widgetChannel.invokeMethod<String>('loadNote');
      _controller.text = content ?? '';
      _hasContent = (content ?? '').isNotEmpty;
    } catch (e) {
      _controller.text = '';
      _hasContent = false;
    }
    setState(() => _isLoading = false);
  }

  Future<void> _saveNote() async {
    try {
      await _widgetChannel.invokeMethod('saveNote', {'content': _controller.text});
    } catch (e) {
      // Fallback: ignore widget channel errors
    }
    final hasContent = _controller.text.isNotEmpty;
    if (hasContent != _hasContent) {
      setState(() => _hasContent = hasContent);
      if (hasContent) {
        _knobController.forward();
      } else {
        _knobController.reverse();
      }
    }
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('NOTA GUARDADA', style: _usFont(size: 11, weight: FontWeight.w500)),
          duration: const Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
          backgroundColor: usAccent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          margin: const EdgeInsets.all(16),
        ),
      );
    }
  }

  void _clearNote() {
    _controller.clear();
    _saveNote();
    _knobController.reverse();
    HapticFeedback.lightImpact();
  }

  @override
  void dispose() {
    _saveNote();
    _controller.dispose();
    _knobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? usDisplay : usCanvas;
    final cardColor = isDark ? const Color(0xFF1A1A1A) : usCanvas;
    final borderColor = isDark ? const Color(0xFF2A2A2A) : usGrid;
    final textColor = isDark ? const Color(0xFFE2E8F0) : usText;
    final mutedColor = isDark ? const Color(0xFF888888) : const Color(0xFF888888);

    if (_isLoading) {
      return Scaffold(
        backgroundColor: bgColor,
        body: Center(
          child: _UsKnob(controller: _knobController, size: 64),
        ),
      );
    }

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: _HeaderKnob(controller: _knobController, hasContent: _hasContent),
        actions: [
          _UsIconButton(
            icon: Icons.delete_outline,
            tooltip: 'LIMPIAR',
            onPressed: _clearNote,
            isDestructive: true,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          _DisplayBar(
            charCount: _controller.text.length,
            hasContent: _hasContent,
            isDark: isDark,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  color: cardColor,
                  border: Border.all(color: borderColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: _controller,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  style: _usFont(size: 15, height: 1.6, color: textColor),
                  decoration: InputDecoration(
                    hintText: _hasContent ? null : 'ESCRIBE TU NOTA...',
                    hintStyle: _usFont(size: 13, letterSpacing: 0.04, color: mutedColor),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(16),
                  ),
                  onChanged: (_) => _saveNote(),
                ),
              ),
            ),
          ),
          _FooterStats(charCount: _controller.text.length, isDark: isDark),
        ],
      ),
    );
  }
}

class _HeaderKnob extends StatelessWidget {
  final AnimationController controller;
  final bool hasContent;

  const _HeaderKnob({required this.controller, required this.hasContent});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _UsKnob(controller: controller, size: 36),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'IDO1NOTE',
              style: _usFont(size: 14, weight: FontWeight.w700, letterSpacing: 0.08),
            ),
            Text(
              hasContent ? 'ACTIVO' : 'VACÍO',
              style: _usFont(
                size: 9,
                weight: FontWeight.w500,
                letterSpacing: 0.12,
                color: hasContent ? usAccent : Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _UsKnob extends AnimatedWidget {
  final double size;

  const _UsKnob({required AnimationController controller, required this.size})
      : super(listenable: controller);

  @override
  Widget build(BuildContext context) {
    final progress = listenable as AnimationController;
    final value = progress.value;

    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _KnobPainter(progress: value),
      ),
    );
  }
}

class _KnobPainter extends CustomPainter {
  final double progress;

  _KnobPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final bgPaint = Paint()
      ..color = usDark
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = usGrid
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.drawCircle(center, radius, bgPaint);
    canvas.drawCircle(center, radius, borderPaint);

    if (progress > 0) {
      final spiralPaint = Paint()
        ..color = usAccent.withOpacity(0.3 + 0.2 * progress)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5;

      for (int i = 0; i < 3; i++) {
        final path = Path();
        final startAngle = (i * 2 * math.pi / 3) + (progress * math.pi);
        for (double t = 0; t < 2 * math.pi; t += 0.1) {
          final r = radius * 0.3 + radius * 0.35 * (t / (2 * math.pi));
          final x = center.dx + r * math.cos(t + startAngle);
          final y = center.dy + r * math.sin(t + startAngle);
          if (t == 0) {
            path.moveTo(x, y);
          } else {
            path.lineTo(x, y);
          }
        }
        canvas.drawPath(path, spiralPaint);
      }

      final notchPaint = Paint()..color = usAccent;
      final notchAngle = -math.pi / 2 + progress * math.pi * 2;
      final notchStart = Offset(
        center.dx + (radius * 0.15) * math.cos(notchAngle),
        center.dy + (radius * 0.15) * math.sin(notchAngle),
      );
      final notchEnd = Offset(
        center.dx + (radius * 0.45) * math.cos(notchAngle),
        center.dy + (radius * 0.45) * math.sin(notchAngle),
      );
      canvas.drawLine(notchStart, notchEnd, notchPaint..strokeWidth = 2);

      final centerPaint = Paint()..color = usAccent;
      canvas.drawCircle(center, radius * 0.12, centerPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is _KnobPainter && oldDelegate.progress != progress;
  }
}

class _DisplayBar extends StatelessWidget {
  final int charCount;
  final bool hasContent;
  final bool isDark;

  const _DisplayBar({
    required this.charCount,
    required this.hasContent,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isDark ? usDark : usDisplay;
    final textColor = isDark ? const Color(0xFFE2E8F0) : usCanvas;
    final labelColor = isDark ? const Color(0xFF888888) : const Color(0xFF888888);
    final borderColor = isDark ? const Color(0xFF1A1A1A) : usText;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: bgColor,
        border: Border(
          bottom: BorderSide(color: borderColor),
        ),
      ),
      child: Row(
        children: [
          _DisplayItem(
            label: 'CHARS',
            value: charCount.toString(),
            valueColor: usAccent,
            labelColor: labelColor,
            bgColor: bgColor,
            borderColor: borderColor,
          ),
          const SizedBox(width: 12),
          _DisplayItem(
            label: 'LINES',
            value: _estimateLines(charCount).toString(),
            valueColor: hasContent ? usAccent : labelColor,
            labelColor: labelColor,
            bgColor: bgColor,
            borderColor: borderColor,
          ),
          const Spacer(),
          if (hasContent)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: usAccent,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                'LIVE',
                style: _usFont(size: 8, weight: FontWeight.w700, letterSpacing: 0.1, color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }

  int _estimateLines(int chars) => (chars / 45).ceil().clamp(1, 999);
}

class _DisplayItem extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;
  final Color labelColor;
  final Color bgColor;
  final Color borderColor;

  const _DisplayItem({
    required this.label,
    required this.value,
    required this.valueColor,
    required this.labelColor,
    required this.bgColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 80),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: _usFont(size: 8, letterSpacing: 0.14, color: labelColor),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: _usFont(size: 16, weight: FontWeight.w700, letterSpacing: 0.06, color: valueColor),
          ),
        ],
      ),
    );
  }
}

class _FooterStats extends StatelessWidget {
  final int charCount;
  final bool isDark;

  const _FooterStats({required this.charCount, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final textColor = isDark ? const Color(0xFF888888) : const Color(0xFF888888);
    final borderColor = isDark ? const Color(0xFF2A2A2A) : usGrid;
    final accentText = usAccent;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: borderColor)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'AUTO-SAVE',
            style: _usFont(size: 8, letterSpacing: 0.1, color: textColor),
          ),
          Text(
            'IDOTIZA',
            style: _usFont(size: 8, weight: FontWeight.w700, letterSpacing: 0.1, color: accentText),
          ),
        ],
      ),
    );
  }
}

class _UsIconButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;
  final bool isDestructive;

  const _UsIconButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = isDestructive ? usAccent : (isDark ? const Color(0xFFE2E8F0) : usText);

    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(6),
          onTap: () {
            HapticFeedback.lightImpact();
            onPressed();
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Icon(icon, color: color, size: 22),
          ),
        ),
      ),
    );
  }
}