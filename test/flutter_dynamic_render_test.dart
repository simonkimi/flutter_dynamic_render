import 'package:csslib/parser.dart';
import 'package:csslib/visitor.dart' as css;

class DeclarationVisitor extends css.Visitor {
  final Map<String, Map<String, List<css.Expression>>> _result = {};
  final Map<String, List<css.Expression>> _properties = {};
  late String _selector;
  late String _currentProperty;

  Map<String, Map<String, List<css.Expression>>> getDeclarations(
      css.StyleSheet sheet) {
    for (var element in sheet.topLevels) {
      if (element.span != null) {
        _selector = element.span!.text;
        element.visit(this);
        if (_result[_selector] != null) {
          _properties.forEach((key, value) {
            if (_result[_selector]![key] != null) {
              _result[_selector]![key]!
                  .addAll(List<css.Expression>.from(value));
            } else {
              _result[_selector]![key] = List<css.Expression>.from(value);
            }
          });
        } else {
          _result[_selector] =
              Map<String, List<css.Expression>>.from(_properties);
        }
        _properties.clear();
      }
    }
    return _result;
  }

  @override
  void visitDeclaration(css.Declaration node) {
    _currentProperty = node.property;
    _properties[_currentProperty] = <css.Expression>[];
    node.expression!.visit(this);
  }

  @override
  void visitExpressions(css.Expressions node) {
    if (_properties[_currentProperty] != null) {
      _properties[_currentProperty]!.addAll(node.expressions);
    } else {
      _properties[_currentProperty] = node.expressions;
    }
  }
}

main() {
  var stylesheet = parse(
      '.foo #bar #trst>.hello { color: red; left: 20px; top: 20px; width: 100px; height:200px }');

  final declarations = DeclarationVisitor().getDeclarations(stylesheet);

  print(declarations);
}
