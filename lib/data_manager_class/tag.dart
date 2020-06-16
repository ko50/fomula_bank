import 'package:flutter/material.dart';

/// 公式に付属するタグのクラス
class Tag {
  String name;
  Color color;

  Tag({this.name, this.color}) {
    color ??= Colors.blue;
  }

  Tag.fromJson(Map<String, dynamic> json)
    : name  = json["name"],
      color = Color(json["color"]); 

  Map<String, dynamic> toJson() => {
    "name" : name,
    "color": color.value,
  };
}

/// Tagクラスをまとめるクラス Tagクラスに対応させたListっぽい関数を実装している
class TagList {
  List<Tag> list;
  int length;

  TagList({this.list}) {
    list ??= [];
    this.length = list.length;
  }

  // 疑似的にListっぽい関数を実装する

  /// Tagのnameを基準に、50音順にソートする
  sort() => this.list.sort((a, b) => a.name.compareTo(b.name));
  /// キーワードを受け取り、TagList内のTagのnameに一致するか調べる
  contains(String key) {
    List<String> nameList = list.map((tag) => tag.name).toList();
    return nameList.contains(key);
  }
  /// indexを受け取り要素を消去する (普通の List.removeAt() と同じ)
  // TODO 無限再帰になってないかこれ？
  removeAt(int index) => this.list.removeAt(index);

  TagList.fromJson(Map<String, dynamic> json)
    : list = (json["list"].map((tag) => Tag.fromJson(tag))).toList(); 

  Map<String, dynamic> toJson() => {
    "list" : list.map((tag) => tag.toJson()),
  };
}