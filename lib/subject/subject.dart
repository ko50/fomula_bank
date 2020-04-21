import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';

import '../fomula/fomula.dart';

class Subject {
  String name;
  List<Fomula> fomulaList;

  Subject({this.name, this.fomulaList});

  Subject.fromJson(Map<String, dynamic> json)
    : name       = json["name"],
      fomulaList = (json["fomulaList"].map((fomula) => Fomula.fromJson(fomula))).toList();

  Map<String, dynamic> toJson() => {
    "name"      : name,
    "fomulaList": fomulaList,
  };
}

class SubjectPrefarence {
  Subject subject;

  /// ローカルから科目のリストを取得
  static Future<List<Subject>> getSubjectList() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    if(!pref.containsKey("SubjectList")){
      pref.setString("SubjectList", "");
      return [];
    }

    if(pref.getString("SubjectList")=="") {
      return [];
    }
    List<dynamic> jsonList = json.decode(pref.getString("SubjectList"));
    List<Subject> subjectList = [];

    for(Map<String, dynamic> json in jsonList) {
      subjectList.add(Subject.fromJson(json));
    }
    return subjectList;
  }

  static Future saveSubjectList(List<Subject> subjectList) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    List jsonedSubjectList = [];
    for(Subject subject in subjectList) {
      jsonedSubjectList.add(subject.toJson());
    }
    pref.setString("SubjectList", json.encode(jsonedSubjectList));
  }
}
