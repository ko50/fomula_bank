import 'package:flutter/material.dart';

/// 新しい科目を追加するダイアログを表示します
Future<String> inputSubjectDialog(var context) async{
  var controller = TextEditingController();
  String result = await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("新しく追加する科目の名称を入力してください"),
        content: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(hintText: "Please input new subject name"),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          FlatButton(
            child: Text("cancel"),
            onPressed: () {
              Navigator.of(context).pop(null);
            },
          ),
          FlatButton(
            child: Text("complete"),
            onPressed: () {
              Navigator.of(context).pop(controller.text);
            },
          ),
        ],
      );
    }
  );
  return result;
}

/// 科目を消去するか確認をするダイアログを表示します
Future<bool> confirmDeleteSubjectDialog(var context) async{
  bool result = await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("この科目を削除しますか?"),
        content: Text("本当に削除しますか?"),
        actions: <Widget>[
          FlatButton(
            child: Text("cancel"),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          FlatButton(
            child: Text("yes"),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    }
  );
  return result ??= false;
}

/// 公式を削除するときの確認をとるダイアログを表示します
Future<bool> confirmDeleteFomulaDialog(var context) async{
  bool result = await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("この公式を削除しますか？"),
        content: Text("本当に削除しますか？"),
        actions: <Widget>[
          FlatButton(
            child: Text("cancel"),
            onPressed: () {
              Navigator.of(context).pop(false);
          },
          ),
          FlatButton(
            child: Text("yes"),
            onPressed: () {
              Navigator.of(context).pop(true);
          },
          ),
        ],
      );
    }
  );
  return result ??= false;
}