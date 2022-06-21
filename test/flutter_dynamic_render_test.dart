import 'dart:io';

import 'package:xml/xml.dart';


void main() {
  // final file = File('./test/test.xml').readAsStringSync();
  //
  // final doc = XmlDocument.parse(file).rootElement;
  //
  // print(doc.childElements.toList()[0].name.local);

  final hasBorder = ['border'];
  final direction = ['left', 'right', 'top', 'bottom'];
  hasBorder.addAll(direction.map((e) => 'border-$e'));
  hasBorder.addAll(direction.map((e) => 'border-$e-color'));
  hasBorder.addAll(direction.map((e) => 'border-$e-style'));
  hasBorder.addAll(direction.map((e) => 'border-$e-width'));

  print(hasBorder);

}