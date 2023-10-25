import 'package:flutter/cupertino.dart';

class TextUtils {
  static List<double> getTextWidth(String text, TextStyle style) {
    InlineSpan span = TextSpan(text: text, style: style);
    final painter = TextPainter(text: span, maxLines: 1, textDirection: TextDirection.ltr);
    painter.layout();
    return [painter.width, painter.height];
  }
}
