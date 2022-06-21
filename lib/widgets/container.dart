import 'package:flutter/material.dart';
import 'package:flutter_dynamic_render/styles/style.dart';
import 'package:flutter_dynamic_render/styles/style_mixin.dart';

import 'dynamic_widget.dart';

class ContainerStyle extends WidgetBaseStyle
    with SizedStyleMixin, BorderStyleMixin {
  ContainerStyle(super.attrs) {
    setSize(attrs);
    setBorder(attrs);
  }
}

class DynamicContainer extends DynamicWidget {
  DynamicContainer(super.node) : style = ContainerStyle(node.attrs);

  final ContainerStyle style;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: style.width,
      height: style.height,
      decoration: BoxDecoration(
        border: style.border,
        borderRadius: style.borderRadius,
      ),
      child: node.child?.buildWidget().build(context),
    );
  }
}
