import 'package:flutter/material.dart';

import './tag.dart';

/// 公式の名前、本体、説明を格納するクラス
class formula {
  String name;
  String expression;
  String description;
  bool liked;
  late TagList tagList;

  formula(
      {this.name = "",
      this.expression = "",
      this.description = "",
      this.liked = false,
      TagList? tagList}) {
    tagList ??= TagList();
    this.tagList = tagList;
  }

  void update(String newName, String newExpression, String newDescribe,
      TagList newTagList) {
    this.name = newName;
    this.expression = newExpression;
    this.description = newDescribe;
    this.tagList = newTagList.sort();
  }

  void changeLike(bool value) => this.liked = !value;

  formula.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        expression = json["expression"],
        description = json["description"],
        liked = json["liked"],
        tagList = TagList.fromJson(json["tagList"]);

  Map<String, dynamic> toJson() => {
        "name": name,
        "expression": expression,
        "description": description,
        "liked": liked,
        "tagList": tagList.toJson(),
      };
}

/*
class Variable {
  String name;
  String definition;
}
*/
