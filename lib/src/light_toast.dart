import 'dart:async';
import 'package:flutter/material.dart';
import 'package:light_toast/src/ui/toast_widget.dart';

/// A lightweight Flutter package for displaying customizable toast messages.
abstract class Toast {
  /// Shows a toast message with customizable options.
  ///
  /// [message] The message to display in the toast.
  /// [context] The build context (optional if navigatorKey is set).
  /// [backgroundColor] The background color of the toast.
  /// [textColor] The text color of the toast message.
  /// [fontSize] The font size of the toast message.
  /// [borderRadius] The border radius of the toast container.
  /// [icon] The icon to display in the toast (optional).
  /// [iconColor] The color of the icon (optional).
  /// [image] The image URL or asset path to display in the toast (optional).
  /// [showLeading] Whether to show the leading icon or image in the toast.
  /// [duration] The duration for which the toast will be visible.
  static OverlayEntry? _overlayEntry;
  static bool _isVisible = false;
  static final GlobalKey<NavigatorState> _navigatorKey =
      GlobalKey<NavigatorState>();

  /// Get the navigator key to be used in MaterialApp.
  ///
  /// Usage:
  /// ```dart
  /// MaterialApp(
  ///   navigatorKey: Toast.navigatorKey,
  ///   // ... rest of your app
  /// )
  /// ```
  static GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  /// Shows a toast message with customizable options.
  ///
  /// [message] The message to display in the toast.
  static void show(
    String message, {
    Color backgroundColor = Colors.black87,
    Color textColor = Colors.white,
    double fontSize = 16.0,
    double borderRadius = 10.0,
    IconData? icon,
    Color? iconColor,
    String? image,
    bool showLeading = false,
    Duration duration = const Duration(seconds: 2),
  }) {
    if (_isVisible) return;

    final overlay = _navigatorKey.currentState?.overlay;

    if (overlay == null) {
      throw StateError(
        'Toast error: Overlay not available. '
        'Add Toast.navigatorKey to MaterialApp.',
      );
    }

    _overlayEntry = OverlayEntry(
      builder: (_) => ToastWidget(
        message: message,
        backgroundColor: backgroundColor,
        textColor: textColor,
        fontSize: fontSize,
        borderRadius: borderRadius,
        icon: showLeading ? icon : null,
        iconColor: iconColor,
        image: image,
        showLeading: showLeading,
      ),
    );

    overlay.insert(_overlayEntry!);
    _isVisible = true;

    Timer(duration, hide);
  }

  static void hide() {
    if (_isVisible && _overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
      _isVisible = false;
    }
  }
}
