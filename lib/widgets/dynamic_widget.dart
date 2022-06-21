library dynamic_widget;

import 'package:flutter/material.dart';
import 'package:flutter_dynamic_render/utils/buffer_stream.dart';
import 'package:flutter_dynamic_render/widgets/sized_box.dart';

import 'container.dart';

enum SupportWidget {
  sizedBox,
  container,
  textFormField,
  column,
  row,
  icon,
  text,
}

abstract class DynamicWidget {
  DynamicWidget(this.node);

  final WidgetNodeTree node;

  Widget build(BuildContext context);
}

class WidgetNodeTree {
  WidgetNodeTree({
    required this.attrs,
    required this.widget,
    required this.children,
    required this.bind,
  });

  final Map<String, BufferStream<String>> bind;
  final SupportWidget widget;
  final Map<String, String> attrs;
  final Iterable<WidgetNodeTree> children;

  WidgetNodeTree? get child => children.isNotEmpty ? children.first : null;

  DynamicWidget buildWidget() {
    switch (widget) {
      case SupportWidget.sizedBox:
        return DynamicSizedBox(this);
      case SupportWidget.container:
        return DynamicContainer(this);
      case SupportWidget.textFormField:
        // TODO: Handle this case.
        break;
      case SupportWidget.column:
        // TODO: Handle this case.
        break;
      case SupportWidget.row:
        // TODO: Handle this case.
        break;
      case SupportWidget.icon:
        // TODO: Handle this case.
        break;
      case SupportWidget.text:
        // TODO: Handle this case.
        break;
    }
    throw UnsupportedError('Unsupported tag: $widget');
  }

// Widget build(BuildContext context) {
//   switch (widget) {
//     case SupportWidget.sizedBox:
//       return SizedBox(
//         width: style?.width,
//         height: style?.height,
//       );
//     case SupportWidget.container:
//       return Container(
//         width: style?.width,
//         height: style?.height,
//         decoration: BoxDecoration(
//           color: style?.color,
//           borderRadius: style?.borderRadius,
//           border: style?.border,
//         ),
//       );
//     case SupportWidget.textFormField:
//       if (style?.bind != null) {
//         bind[style!.bind!] ??= BufferStream<String>(initData: '');
//         final stream = bind[style!.bind!]!;
//         return StreamBuilder<String>(
//           initialData: stream.buffer,
//           stream: stream.stream,
//           builder: (context, snapshot) => _textFormBuilder(
//             context,
//             snapshot.data!,
//           ),
//         );
//       } else {
//         return _textFormBuilder(context, bind[style!.bind!]!.buffer);
//       }
//   }
// }
//
// Widget _textFormBuilder(BuildContext context, String data) => TextFormField(
//       controller: TextEditingController.fromValue(TextEditingValue(
//         text: data,
//         selection: TextSelection.fromPosition(TextPosition(
//           offset: data.length,
//           affinity: TextAffinity.downstream,
//         )),
//       )),
//       decoration: InputDecoration(
//         border: style?.inputBorder,
//         hintText: style?.hintText,
//         isCollapsed: style?.isCollapsed ?? false,
//       ),
//       onChanged: (value) {
//         bind[style?.bind]?.add(value);
//       },
//     );
}
