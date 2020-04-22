
/// 公式の名前、本体、説明を格納するクラス
class Fomula {
  String name;
  String expression;
  String describe;

  Fomula({this.name, this.expression, this.describe});

  void update(String newName, String newExpression, String newDescribe) {
    this.name =       newName;
    this.expression = newExpression;
    this.describe   = newDescribe;
  }

  Fomula.fromJson(Map<String, dynamic> json)
    : name       = json["name"],
      expression = json["expression"],
      describe   = json["describe"];

  Map<String, dynamic> toJson() => {
    "name"       : name,
    "expression" : expression,
    "describe"   : describe,
  };
}