import 'package:expressions/expressions.dart';

export 'package:expressions/expressions.dart';

class MyEvaluator extends ExpressionEvaluator {
  @override
  dynamic evalMemberExpression(
    MemberExpression expression,
    Map<String, dynamic> context,
  ) {
    var object = eval(expression.object, context);
    return (object is List)
        ? object.contains
        : getMember(object, expression.property.name);
  }
}
