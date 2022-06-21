import 'package:flutter_dynamic_render/utils/buffer_stream.dart';
import 'package:flutter_dynamic_render/widgets/dynamic_widget.dart';
import 'package:xml/xml.dart';

WidgetNodeTree buildWidgetNodeTree(
  XmlElement element,
  Map<String, BufferStream<String>> bind,
) {
  return WidgetNodeTree(
    widget: parserName(element.name),
    attrs: Map.fromEntries(
        element.attributes.map((p0) => MapEntry(p0.name.local, p0.value))),
    children: element.childElements.map((e) => buildWidgetNodeTree(e, bind)),
    bind: bind,
  );
}

SupportWidget parserName(XmlName name) {
  switch (name.local) {
    case 'Container':
      return SupportWidget.container;
    case 'SizedBox':
      return SupportWidget.sizedBox;
    case 'TextFormField':
      return SupportWidget.textFormField;
    case 'Column':
      return SupportWidget.column;
    case 'Row':
      return SupportWidget.row;
  }
  throw UnsupportedError('Unsupported tag: $name');
}
