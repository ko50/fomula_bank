import 'package:flutter/material.dart';

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

class TagList {
  List<Tag> list;

  TagList(this.list);

  sort() => this.list.sort((a, b) => a.name.compareTo(b.name));

  TagList.fromJson(Map<String, dynamic> json)
    : list = (json["list"].map((tag) => Tag.fromJson(tag))).toList(); 

  Map<String, dynamic> toJson() => {
    "list" : list.map((tag) => tag.toJson()),
  };
}