
/// 公式の名前、本体、説明を格納するクラス
class Fomula {
  String name;
  String expression;
  String describe;
  bool liked;
  List<String> tagList;

  Fomula({this.name, this.expression, this.describe, this.liked, this.tagList}) {
    this.describe ??= "";
    this.liked ??= false;
    this.tagList ??=  [];
  }

  void update({String newName, String newExpression, String newDescribe, List<String> newTagList}) {
    this.name       = newName;
    this.expression = newExpression;
    this.describe   = newDescribe;
    this.tagList    = newTagList;
  }

  void changeLike(bool value) => this.liked = value;

  Fomula.fromJson(Map<String, dynamic> json)
    : name       = json["name"],
      expression = json["expression"],
      describe   = json["describe"],
      liked      = json["liked"],
      tagList    = json["tagList"];

  Map<String, dynamic> toJson() => {
    "name"       : name,
    "expression" : expression,
    "describe"   : describe,
    "liked"      : liked,
    "tagList"    : tagList,
  };
}