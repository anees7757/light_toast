import 'package:flutter/material.dart';
import 'package:light_toast/light_toast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'light_toast Demo',
      navigatorKey: Toast.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6C63FF)),
        useMaterial3: true,
      ),
      home: const ToastDemoPage(),
    );
  }
}

class ToastDemoPage extends StatelessWidget {
  const ToastDemoPage({super.key});

  // ─── Helper ──────────────────────────────────────────────────────────────
  void _show(
    String message, {
    ToastPosition position = ToastPosition.bottomCenter,
    ToastDirection direction = ToastDirection.ltr,
    IconData? icon,
    Color? backgroundColor,
  }) {
    Toast.show(
      message,
      position: position,
      direction: direction,
      showLeading: icon != null,
      icon: icon,
      backgroundColor: backgroundColor ?? Colors.black87,
      duration: const Duration(seconds: 2),
    );
  }

  // ─── Build ────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FA),
      appBar: AppBar(
        title: const Text(
          'light_toast  Demo',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF6C63FF),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ── 1. Basic ──────────────────────────────────────────────────────
          _SectionCard(
            title: '1. Basic Toast',
            subtitle: 'The simplest way to show a message.',
            color: const Color(0xFF6C63FF),
            child: _DemoButton(
              label: 'Show Basic Toast',
              icon: Icons.chat_bubble_outline,
              onTap: () => _show('Hello, Flutter! 👋'),
            ),
          ),

          // ── 2. With Icon ──────────────────────────────────────────────────
          _SectionCard(
            title: '2. Toast with Icon',
            subtitle: 'Pass an icon and set showLeading: true.',
            color: const Color(0xFF43AA8B),
            child: Column(
              children: [
                _DemoButton(
                  label: 'Success',
                  icon: Icons.check_circle_outline,
                  color: const Color(0xFF43AA8B),
                  onTap: () => _show(
                    'Saved successfully!',
                    icon: Icons.check_circle,
                    backgroundColor: const Color(0xFF43AA8B),
                  ),
                ),
                const SizedBox(height: 8),
                _DemoButton(
                  label: 'Error',
                  icon: Icons.error_outline,
                  color: const Color(0xFFE63946),
                  onTap: () => _show(
                    'Something went wrong!',
                    icon: Icons.error,
                    backgroundColor: const Color(0xFFE63946),
                  ),
                ),
                const SizedBox(height: 8),
                _DemoButton(
                  label: 'Info',
                  icon: Icons.info_outline,
                  color: const Color(0xFF457B9D),
                  onTap: () => _show(
                    'New update available.',
                    icon: Icons.info,
                    backgroundColor: const Color(0xFF457B9D),
                  ),
                ),
              ],
            ),
          ),

          // ── 3. Position ───────────────────────────────────────────────────
          _SectionCard(
            title: '3. Toast Position',
            subtitle:
                'Use the position: parameter to control where the toast appears.',
            color: const Color(0xFFF4A261),
            child: _PositionGrid(onTap: _show),
          ),

          // ── 4. RTL ────────────────────────────────────────────────────────
          _SectionCard(
            title: '4. RTL Direction',
            subtitle:
                'Pass direction: ToastDirection.rtl for right-to-left languages.',
            color: const Color(0xFF9B2226),
            child: Column(
              children: [
                _DemoButton(
                  label: 'LTR  →  Hello World',
                  icon: Icons.format_textdirection_l_to_r,
                  onTap: () => _show(
                    'Hello World',
                    direction: ToastDirection.ltr,
                    icon: Icons.language,
                  ),
                ),
                const SizedBox(height: 8),
                _DemoButton(
                  label: 'RTL  ←  مرحبا بالعالم',
                  icon: Icons.format_textdirection_r_to_l,
                  onTap: () => _show(
                    'مرحبا بالعالم',
                    direction: ToastDirection.rtl,
                    icon: Icons.language,
                  ),
                ),
              ],
            ),
          ),

          // ── 5. Hide manually ──────────────────────────────────────────────
          _SectionCard(
            title: '5. Hide Manually',
            subtitle:
                'Call Toast.hide() to dismiss the toast before it expires.',
            color: const Color(0xFF6D6875),
            child: Row(
              children: [
                Expanded(
                  child: _DemoButton(
                    label: 'Show (5 s)',
                    icon: Icons.timer_outlined,
                    onTap: () => Toast.show(
                      'I will stay for 5 seconds…',
                      duration: const Duration(seconds: 5),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _DemoButton(
                    label: 'Hide now',
                    icon: Icons.close,
                    color: const Color(0xFF6D6875),
                    onTap: Toast.hide,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

// ─── Position grid ──────────────────────────────────────────────────────────

class _PositionGrid extends StatelessWidget {
  final void Function(String, {ToastPosition position}) onTap;

  const _PositionGrid({required this.onTap});

  @override
  Widget build(BuildContext context) {
    const positions = [
      ('↖', 'Top Left', ToastPosition.topLeft),
      ('↑', 'Top Center', ToastPosition.topCenter),
      ('↗', 'Top Right', ToastPosition.topRight),
      ('←', 'Center Left', ToastPosition.centerLeft),
      ('●', 'Center', ToastPosition.center),
      ('→', 'Center Right', ToastPosition.centerRight),
      ('↙', 'Bottom Left', ToastPosition.bottomLeft),
      ('↓', 'Bottom Center', ToastPosition.bottomCenter),
      ('↘', 'Bottom Right', ToastPosition.bottomRight),
    ];

    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 6,
      crossAxisSpacing: 6,
      childAspectRatio: 2.2,
      children: [
        for (final (arrow, label, pos) in positions)
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF4A261),
              foregroundColor: Colors.white,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () => onTap(label, position: pos),
            child: Text(
              '$arrow\n$label',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10, height: 1.4),
            ),
          ),
      ],
    );
  }
}

// ─── Reusable widgets ────────────────────────────────────────────────────────

class _SectionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;
  final Widget child;

  const _SectionCard({
    required this.title,
    required this.subtitle,
    required this.color,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.12),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Coloured header strip
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.85),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          // Content
          Padding(padding: const EdgeInsets.all(14), child: child),
        ],
      ),
    );
  }
}

class _DemoButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final Color? color;

  const _DemoButton({
    required this.label,
    required this.icon,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final c = color ?? const Color(0xFF6C63FF);
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: c,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        icon: Icon(icon, size: 18),
        label: Text(label),
        onPressed: onTap,
      ),
    );
  }
}
