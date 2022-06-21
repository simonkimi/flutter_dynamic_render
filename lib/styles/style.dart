import 'package:flutter/material.dart';

abstract class WidgetBaseStyle {}

class CustomBorderSide {
  CustomBorderSide({
    Color color = const Color(0xFF000000),
    double width = 1.0,
  })  : _color = color,
        _width = width;

  Color? _color;

  double _width;

  BorderSide toBorderSide() {
    return BorderSide(
      width: _width,
      color: _color ?? const Color(0xFF000000),
      style: _width >= 0 ? BorderStyle.solid : BorderStyle.none,
    );
  }

  void copyFrom(CustomBorderSide? another) {
    if (another != null) {
      _color = another._color ?? _color;
      _width = another._width;
    }
  }

  set color(Color? value) {
    _color = value ?? _color;
  }

  set width(double? value) {
    _width = value ?? _width;
  }

  Color? get color => _color;

  double? get width => _width;
}
