import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final TextAlign? textAlign;
  final Color? glowColor;
  final Color? outlineColor;

  const AppText({
    Key? key,
    required this.text,
    this.fontSize = 18,
    this.fontWeight = FontWeight.normal,
    this.color = Colors.black,
    this.textAlign,
    this.glowColor,
    this.outlineColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );

    if (glowColor != null) {
      textStyle = textStyle.copyWith(
        shadows: [
          Shadow(
            color: glowColor!.withOpacity(1),
            blurRadius: 0.8,
          ),
        ],
      );
    }

    if (outlineColor != null) {
      textStyle = textStyle.copyWith(
        foreground: Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3
          ..color = outlineColor!,
      );
    }

    return Text(text,
        textAlign: textAlign == null ? null : TextAlign.center,
        style: textStyle);
  }
}
