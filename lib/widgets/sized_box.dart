import 'package:flutter/material.dart';
import 'package:flutter_dynamic_render/styles/style.dart';
import 'package:flutter_dynamic_render/styles/style_mixin.dart';

import 'dynamic_widget.dart';

class SizedBoxStyle extends WidgetBaseStyle with SizedStyleMixin {
  SizedBoxStyle(super.attrs) {
    setSize(attrs);
  }
}

class DynamicSizedBox extends DynamicWidget {
  DynamicSizedBox(super.node) : style = SizedBoxStyle(node.attrs);

  final SizedBoxStyle style;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: style.width,
      height: style.height,
      child: node.child?.buildWidget().build(context),
    );
  }
}
