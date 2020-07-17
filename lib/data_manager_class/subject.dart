import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';

import './formula.dart';

class Subject {
  String name;
  late List<formula> formulaList;

  Subject({this.name = "", List<formula>? formulaList}) {
    formulaList ??= [];
    this.formulaList = formulaList;
  }

  Subject.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        formulaList = (json["formulaList"]
            .map((formula) => formula.fromJson(formula))).toList();

  Map<String, dynamic> toJson() => {
        "name": name,
        "formulaList": formulaList,
      };
}

class SubjectPrefarence {
  /// ローカルから科目のリストを取得
  static Future<List<Subject>> getSubjectList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (!pref.containsKey("SubjectList")) {
      pref.setString("SubjectList", "");
      return [];
    }

    if (pref.getString("SubjectList") == "") {
      return [];
    }
    List<dynamic> jsonList = json.decode(pref.getString("SubjectList"));
    List<Subject> subjectList = [];

    for (Map<String, dynamic> json in jsonList) {
      subjectList.add(Subject.fromJson(json));
    }
    return subjectList;
  }

  static Future saveSubjectList(List<Subject> subjectList) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List jsonedSubjectList = [];
    for (Subject subject in subjectList) {
      jsonedSubjectList.add(subject.toJson());
    }
    pref.setString("SubjectList", json.encode(jsonedSubjectList));
  }
}
