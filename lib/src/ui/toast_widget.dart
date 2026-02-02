import 'package:flutter/material.dart';

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
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: MediaQuery.of(context).size.height * 0.05,
      width: MediaQuery.of(context).size.width,
      child: Material(
        color: Colors.transparent,
        child: Center(
          child: Container(
            padding:
            const EdgeInsets.symmetric(horizontal: 18.0, vertical: 13.0),
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
                  style: TextStyle(
                    color: textColor ?? Colors.white,
                    fontSize: fontSize ?? 13.0,
                  ),
                ),
              ],
            ),
          ),
        ),
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