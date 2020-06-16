import 'package:flutter/material.dart';

import './tag.dart';

/// 公式の名前、本体、説明を格納するクラス
class Fomula {
  String name;
  String expression;
  String describe;
  bool liked;
  TagList tagList;

  Fomula({this.name, this.expression, this.describe, this.liked, this.tagList}) {
    this.describe ??= "";
    this.liked    ??= false;
    this.tagList  ??=  TagList();
  }

  void update({String newName, String newExpression, String newDescribe, TagList newTagList}) {
    this.name       = newName;
    this.expression = newExpression;
    this.describe   = newDescribe;
    this.tagList    = newTagList.sort();
  }

  void changeLike(bool value) => this.liked = !value;

  Fomula.fromJson(Map<String, dynamic> json)
    : name       = json["name"],
      expression = json["expression"],
      describe   = json["describe"],
      liked      = json["liked"],
      tagList    = TagList.fromJson(json["tagList"]);

  Map<String, dynamic> toJson() => {
    "name"       : name,
    "expression" : expression,
    "describe"   : describe,
    "liked"      : liked,
    "tagList"    : tagList.toJson(),
  };
}


class Variable {
  String name;
  String definition;
}