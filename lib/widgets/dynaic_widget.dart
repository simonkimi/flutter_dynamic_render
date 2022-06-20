import 'package:flutter/material.dart';
import 'package:flutter_dynamic_render/css/style.dart';
import 'package:flutter_dynamic_render/utils/buffer_stream.dart';

enum SupportWidget {
  sizedBox,
  container,
  textFormField,
}

class DynamicWidget {
  DynamicWidget({
    required this.style,
    required this.widget,
    required this.children,
    required this.bind,
  });

  final Map<String, BufferStream<String>> bind;
  final SupportWidget widget;
  final WidgetStyle? style;
  final List<DynamicWidget> children;

  Widget build(BuildContext context) {
    switch (widget) {
      case SupportWidget.sizedBox:
        return SizedBox(
          width: style?.width,
          height: style?.height,
        );
      case SupportWidget.container:
        return Container(
          width: style?.width,
          height: style?.height,
          decoration: BoxDecoration(
            color: style?.color,
            borderRadius: style?.borderRadius,
            border: style?.border,
          ),
        );
      case SupportWidget.textFormField:
        if (style?.bind != null) {
          bind[style!.bind!] ??= BufferStream<String>(initData: '');
          return StreamBuilder<String>(
            initialData: bind[style!.bind!]!.buffer,
            builder: (context, snapshot) =>
                _textFormBuilder(context, snapshot.data!),
          );
        } else {
          return _textFormBuilder(context, '');
        }
    }
  }

  Widget _textFormBuilder(BuildContext context, String data) => TextFormField(
        initialValue: data,
        onChanged: (value) {
          bind[style?.bind]?.add(value);
        },
      );
}
