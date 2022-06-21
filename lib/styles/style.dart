import 'package:flutter/material.dart';

abstract class WidgetBaseStyle {}

class WidgetStyle {
  WidgetStyle({
    this.backgroundColor,
    this.isCollapsed = false,
    this.color,
    this.direction,
    this.fontStyle,
    this.width,
    this.height,
    this.borderRadius,
    this.border,
  });

  Color? backgroundColor;
  Color? color;
  TextDirection? direction;
  FontStyle? fontStyle;

  double? width;
  double? height;

  BorderRadius? borderRadius;
  BoxBorder? border;
  InputBorder? inputBorder;

  String? bind;

  /// TextFormField
  String? hintText;
  bool isCollapsed;
}
