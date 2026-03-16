import 'package:flutter/material.dart';
import 'package:light_toast/src/constants/constants.dart';

class ToastWidget extends StatelessWidget {
  final String message;
  final Color? backgroundColor;
  final Color? textColor;
  final double? fontSize;
  final double? borderRadius;
  final IconData? icon;
  final Color? iconColor;
  final String? image;
  final bool showLeading;
  final ToastPosition position;
  final ToastDirection direction;

  const ToastWidget({
    super.key,
    required this.message,
    this.backgroundColor,
    this.textColor,
    this.fontSize,
    this.borderRadius,
    this.icon,
    this.iconColor,
    this.image,
    required this.showLeading,
    this.position = ToastPosition.bottomCenter,
    this.direction = ToastDirection.ltr,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;

    // Vertical offsets – respect system bars
    final double vOffset = size.height * 0.05;
    final double hOffset = size.width * 0.04;

    // Resolve top / bottom / left / right for Positioned
    double? top, bottom, left, right;

    switch (position) {
      case ToastPosition.topLeft:
      case ToastPosition.topCenter:
      case ToastPosition.topRight:
        top = padding.top + vOffset;
      case ToastPosition.centerLeft:
      case ToastPosition.center:
      case ToastPosition.centerRight:
        top = (size.height - padding.top - padding.bottom) / 2;
      case ToastPosition.bottomLeft:
      case ToastPosition.bottomCenter:
      case ToastPosition.bottomRight:
        bottom = padding.bottom + vOffset;
    }

    switch (position) {
      case ToastPosition.topLeft:
      case ToastPosition.centerLeft:
      case ToastPosition.bottomLeft:
        left = hOffset;
      case ToastPosition.topRight:
      case ToastPosition.centerRight:
      case ToastPosition.bottomRight:
        right = hOffset;
      case ToastPosition.topCenter:
      case ToastPosition.center:
      case ToastPosition.bottomCenter:
        // Full-width so Center() can centre it
        left = 0;
        right = 0;
    }

    // Horizontal alignment of the pill inside the row
    final bool isCentered = position == ToastPosition.topCenter ||
        position == ToastPosition.center ||
        position == ToastPosition.bottomCenter;

    final bool isRightAligned = position == ToastPosition.topRight ||
        position == ToastPosition.centerRight ||
        position == ToastPosition.bottomRight;

    final textDir =
        direction == ToastDirection.rtl ? TextDirection.rtl : TextDirection.ltr;

    final pill = Directionality(
      textDirection: textDir,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 13.0),
        decoration: BoxDecoration(
          color: backgroundColor ?? const Color(0xff141510),
          borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null && showLeading) ...[
              Icon(
                icon,
                size: 27,
                color: iconColor ?? Colors.white,
              ),
              const SizedBox(width: 8.0),
            ],
            if (image != null && showLeading) ...[
              _buildImageWidget(image!),
              const SizedBox(width: 8.0),
            ],
            Text(
              message,
              textAlign: TextAlign.center,
              textDirection: textDir,
              style: TextStyle(
                color: textColor ?? Colors.white,
                fontSize: fontSize ?? 13.0,
              ),
            ),
          ],
        ),
      ),
    );

    // Align pill inside the Positioned slot
    Widget aligned;
    if (isCentered) {
      aligned = Center(child: pill);
    } else if (isRightAligned) {
      aligned = Align(alignment: Alignment.centerRight, child: pill);
    } else {
      aligned = Align(alignment: Alignment.centerLeft, child: pill);
    }

    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Material(
        color: Colors.transparent,
        child: aligned,
      ),
    );
  }

  Widget _buildImageWidget(String imageUrl) {
    if (imageUrl.startsWith('http')) {
      return CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 12,
        backgroundImage: NetworkImage(imageUrl),
      );
    } else {
      return CircleAvatar(
        radius: 12,
        backgroundColor: Colors.transparent,
        backgroundImage: AssetImage(imageUrl),
      );
    }
  }
}
