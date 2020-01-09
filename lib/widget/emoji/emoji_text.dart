import 'package:flutter/material.dart';

class TextWithEmoji extends CustomPainter {
  String text;
  TextStyle textStyle;

  TextWithEmoji({@required this.text, @required this.textStyle});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = new Paint();
    paint.color = textStyle.color;
    double offsetY = 0;
    double maxWidth = 0;

    maxWidth = findMaxWidth(text, textStyle);

    text.runes.forEach((rune) {
      String str = new String.fromCharCode(rune);
      TextSpan span = new TextSpan(style: textStyle, text: str);
      TextPainter tp = new TextPainter(
          text: span,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr);
      tp.layout();

      tp.paint(canvas, new Offset(0, offsetY));
      offsetY += tp.height;
    });
  }

  double findMaxWidth(String text, TextStyle style) {
    double maxWidth = 0;

    text.runes.forEach((rune) {
      String str = new String.fromCharCode(rune);
      TextSpan span = new TextSpan(style: style, text: str);
      TextPainter tp = new TextPainter(
          text: span,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr);
      tp.layout();
      maxWidth = max(maxWidth, tp.width);
    });

    return maxWidth;
  }

  double max(double a, double b) {
    if (a > b) {
      return a;
    } else {
      return b;
    }
  }

  @override
  bool shouldRepaint(TextWithEmoji oldDelegate) {
    return oldDelegate.text != text || oldDelegate.textStyle != textStyle;
  }
}
