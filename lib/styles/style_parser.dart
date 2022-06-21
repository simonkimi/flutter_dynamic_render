import 'package:flutter/material.dart';

class StyleParser {
  static Border? parseBorder(Map<String, String> attrs) {
    final hasBorder = ['border'];
    final direction = ['left', 'right', 'top', 'bottom'];
    hasBorder.addAll(direction.map((e) => 'border-$e'));
    hasBorder.addAll(direction.map((e) => 'border-$e-color'));
    hasBorder.addAll(direction.map((e) => 'border-$e-style'));
    hasBorder.addAll(direction.map((e) => 'border-$e-width'));

    if (!hasBorder.any((e) => attrs.containsKey(e))) {
      return null;
    }

    var left = const BorderSide(style: BorderStyle.none);
    var right = const BorderSide(style: BorderStyle.none);
    var top = const BorderSide(style: BorderStyle.none);
    var bottom = const BorderSide(style: BorderStyle.none);

    return Border(top: top, right: right, left: left, bottom: bottom);
  }

  static Color? parseColor(String color) {
    if (color.startsWith('#') || color.startsWith('0x')) {
      final hexColor =
          color.startsWith('#') ? color.substring(1) : color.substring(2);
      final h = int.tryParse(hexColor, radix: 16);
      if (h == null) return null;
      if (hexColor.length == 3) {
        final r = (h >> 8 & 0xF) << 4 ^ (h >> 8 & 0xF);
        final g = (h >> 4 & 0xF) << 4 ^ (h >> 4 & 0xF);
        final b = (h & 0xF) << 4 ^ (h & 0xF);
        return Color.fromARGB(0xff, r, g, b);
      } else if (hexColor.length == 6) {
        return Color(0xFF000000 | h);
      }
    }
    return null;
  }
}
