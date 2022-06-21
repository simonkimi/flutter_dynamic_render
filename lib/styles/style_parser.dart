import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dynamic_render/styles/style.dart';
import 'package:flutter_dynamic_render/utils/num.dart';

class StyleParser {
  static Border? parseBorder(Map<String, String> attrs) {
    final hasBorder = ['border'];
    final direction = ['left', 'right', 'top', 'bottom'];
    hasBorder.addAll(direction.map((e) => 'border-$e'));
    hasBorder.addAll(direction.map((e) => 'border-$e-color'));
    hasBorder.addAll(direction.map((e) => 'border-$e-width'));

    if (!hasBorder.any((e) => attrs.containsKey(e))) {
      return null;
    }

    var left = CustomBorderSide();
    var right = CustomBorderSide();
    var top = CustomBorderSide();
    var bottom = CustomBorderSide();

    if (attrs.containsKey('border')) {
      final border = parseBorderSide(attrs['border']!);
      top.copyFrom(border);
      left.copyFrom(border);
      right.copyFrom(border);
      bottom.copyFrom(border);
    }
    if (attrs.containsKey('border-left')) {
      left.copyFrom(parseBorderSide(attrs['border-left']!));
    }
    if (attrs.containsKey('border-right')) {
      right.copyFrom(parseBorderSide(attrs['border-right']!));
    }
    if (attrs.containsKey('border-top')) {
      top.copyFrom(parseBorderSide(attrs['border-top']!));
    }
    if (attrs.containsKey('border-bottom')) {
      bottom.copyFrom(parseBorderSide(attrs['border-bottom']!));
    }
    if (attrs.containsKey('border-color')) {
      final borderColor =
          attrs['border-color']!.split(' ').where((e) => e.isNotEmpty).toList();
      if (borderColor.length == 1) {
        top.color = bottom.color =
            left.color = right.color = parseColor(attrs['border-color']!);
      } else if (borderColor.length == 2) {
        top.color = bottom.color = parseColor(borderColor[0]);
        left.color = right.color = parseColor(borderColor[1]);
      } else if (borderColor.length == 3) {
        top.color = parseColor(borderColor[0]);
        right.color = left.color = parseColor(borderColor[1]);
        bottom.color = parseColor(borderColor[2]);
      } else {
        top.color = parseColor(borderColor[0]);
        right.color = parseColor(borderColor[1]);
        bottom.color = parseColor(borderColor[2]);
        right.color = parseColor(borderColor[3]);
      }
    }
    if (attrs.containsKey('border-top-color')) {
      top.color = parseColor(attrs['border-top-color']!);
    }
    if (attrs.containsKey('border-right-color')) {
      right.color = parseColor(attrs['border-right-color']!);
    }
    if (attrs.containsKey('border-bottom-color')) {
      bottom.color = parseColor(attrs['border-bottom-color']!);
    }
    if (attrs.containsKey('border-left-color')) {
      left.color = parseColor(attrs['border-left-color']!);
    }

    return Border(
      top: top.toBorderSide(),
      right: right.toBorderSide(),
      left: left.toBorderSide(),
      bottom: bottom.toBorderSide(),
    );
  }

  static CustomBorderSide? parseBorderSide(String style) {
    final border = style.split(' ').where((e) => e.isNotEmpty).toList();
    if (border.length == 2) {
      final width = border[0].toDouble();
      final color = parseColor(border[1]);
      if (width == null) return null;
      return CustomBorderSide(
        width: width,
        color: color ?? const Color(0xFF000000),
      );
    }
    if (border.length == 1) {
      final attr = border.first;
      if (double.tryParse(attr) != null) {
        return CustomBorderSide(width: double.parse(attr));
      } else if (parseColor(attr) != null) {
        return CustomBorderSide(
            color: parseColor(attr) ?? const Color(0xFF000000));
      }
    }
    return null;
  }

  static Color? parseColor(String? color) {
    if (color == null) return null;
    if (color.startsWith('#') || color.startsWith('0x')) {
      final hexColor =
          color.startsWith('#') ? color.substring(1) : color.substring(2);
      final h = int.tryParse(hexColor, radix: 16);
      if (h == null) return null;
      if (hexColor.length == 3) {
        // #FFF
        final r = (h >> 8 & 0xF) << 4 ^ (h >> 8 & 0xF);
        final g = (h >> 4 & 0xF) << 4 ^ (h >> 4 & 0xF);
        final b = (h & 0xF) << 4 ^ (h & 0xF);
        return Color.fromARGB(0xff, r, g, b);
      } else if (hexColor.length == 6) {
        // #FFFFFF
        return Color(0xFF000000 | h);
      }
    } else if (color.startsWith('rgb')) {
      // rgb(r, g, b)
      final reg = RegExp(r'rgb\((?<r>\d+),(?<g>\d+),(?<b>\d+)\)');
      final match = reg.firstMatch(color.replaceAll(' ', ''));
      if (match == null) return null;
      return Color.fromARGB(0xff, int.parse(match.namedGroup('r')!),
          int.parse(match.namedGroup('g')!), int.parse(match.namedGroup('b')!));
    } else if (color.startsWith('rgba')) {
      // rgba(r, g, b, a)
      final reg = RegExp(r'rgba\((?<r>\d+),(?<g>\d+),(?<b>\d+),(?<z>\d+)\)');
      final match = reg.firstMatch(color.replaceAll(' ', ''));
      if (match == null) return null;
      return Color.fromARGB(
          int.parse(match.namedGroup('a')!),
          int.parse(match.namedGroup('r')!),
          int.parse(match.namedGroup('g')!),
          int.parse(match.namedGroup('b')!));
    } else if (color.startsWith('hsl')) {
      // hsl(h, s, l)
      final reg = RegExp(r'hsl\((?<h>\d+),(?<s>\d+)%,(?<l>\d+)%\)');
      final match = reg.firstMatch(color.replaceAll(' ', ''));
      if (match == null) return null;
      return HSLColor.fromAHSL(
        1,
        double.parse(match.namedGroup('h')!),
        int.parse(match.namedGroup('s')!) / 100,
        int.parse(match.namedGroup('l')!) / 100,
      ).toColor();
    } else if (builtinColor.containsKey(color)) {
      return builtinColor[color];
    }
    return null;
  }
}

const builtinColor = <String, Color>{
  'blue': Colors.blue,
  'red': Colors.red,
  'green': Colors.green,
  'yellow': Colors.yellow,
  'orange': Colors.orange,
  'purple': Colors.purple,
  'pink': Colors.pink,
  'cyan': Colors.cyan,
  'teal': Colors.teal,
  'black': Colors.black,
  'white': Colors.white,
  'grey': Colors.grey,
  'deepPurple': Colors.deepPurple,
  'indigo': Colors.indigo,
  'lightBlue': Colors.lightBlue,
  'lightGreen': Colors.lightGreen,
  'lime': Colors.lime,
  'amber': Colors.amber,
  'brown': Colors.brown,
  'blueGrey': Colors.blueGrey,
  'activeBlue': CupertinoColors.activeBlue,
  'activeGreen': CupertinoColors.activeGreen,
  'activeOrange': CupertinoColors.activeOrange,
  'systemBlue': CupertinoColors.systemBlue,
  'systemGreen': CupertinoColors.systemGreen,
  'systemOrange': CupertinoColors.systemOrange,
  'systemRed': CupertinoColors.systemRed,
  'systemYellow': CupertinoColors.systemYellow,
  'systemGrey': CupertinoColors.systemGrey,
  'systemPink': CupertinoColors.systemPink,
  'systemTeal': CupertinoColors.systemTeal,
  'systemIndigo': CupertinoColors.systemIndigo,
  'systemGrey2': CupertinoColors.systemGrey2,
  'systemGrey3': CupertinoColors.systemGrey3,
  'systemGrey4': CupertinoColors.systemGrey4,
  'systemGrey5': CupertinoColors.systemGrey5,
  'systemGrey6': CupertinoColors.systemGrey6,
  'link': CupertinoColors.link,
};
