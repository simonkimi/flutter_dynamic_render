import 'package:flutter/material.dart';
import 'package:flutter_dynamic_render/styles/style_parser.dart';
import 'package:flutter_dynamic_render/utils/num.dart';

mixin SizedStyleMixin {
  double? width;
  double? height;

  void setSize(Map<String, String> attrs) {
    width = attrs['width']?.toDouble() ?? width;
    height = attrs['height']?.toDouble() ?? width;
  }
}

mixin BorderStyleMixin {
  Border? border;
  BorderRadius? borderRadius;

  void setBorder(Map<String, String> attrs) {
    borderRadius = attrs['borderRadius']?.toDouble() != null
        ? BorderRadius.circular(attrs['borderRadius']!.toDouble()!)
        : null;
    border = StyleParser.parseBorder(attrs);
  }
}

mixin ColorStyleMixin {
  Color? color;

  void setColor(Map<String, String> attrs) {
    color = StyleParser.parseColor(attrs['color']);
  }
}
