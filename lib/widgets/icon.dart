import 'package:flutter/material.dart';
import 'package:flutter_dynamic_render/styles/style.dart';
import 'package:flutter_dynamic_render/styles/style_mixin.dart';
import 'package:flutter_dynamic_render/utils/icon_map.dart';
import 'package:flutter_dynamic_render/utils/num.dart';

import 'dynamic_widget.dart';

class IconStyle extends WidgetBaseStyle with ColorStyleMixin {
  IconStyle(super.attrs) {
    setColor(attrs);
    icon = builtinIcon[attrs['icon']];
    size = attrs['size']?.toDouble() ?? size;
  }

  IconData? icon;
  double? size;
}

class DynamicIcon extends DynamicWidget {
  DynamicIcon(super.node) : style = IconStyle(node.attrs);

  final IconStyle style;

  @override
  Widget build(BuildContext context) {
    return style.icon != null
        ? Icon(
            style.icon!,
            color: style.color,
            size: style.size,
          )
        : const SizedBox();
  }
}
