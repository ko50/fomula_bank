import 'package:flutter/material.dart';

import './_addTagDialog.dart';
import './_tagMatrix.dart';
import './_inputFomulaDataForm.dart';
import '../../datamanageclass/fomula.dart';
import '../../datamanageclass/tag.dart';

class AddFomulaPage extends StatelessWidget {
  final int subjectIndex;

  AddFomulaPage({this.subjectIndex});

  @override
  Widget build(BuildContext context) {
    Fomula newFomula;
    TagList tagList;
    var nameController       = TextEditingController();
    var describeController   = TextEditingController();
    var expressionController = TextEditingController();
    var tagListController    = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("新しい公式を追加します"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () async{
          if([nameController.text.trim(), describeController.text.trim(), expressionController.text.trim(), tagListController.text.trim()].contains("")) {
            await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("無効な値が入力されました"),
                  content: Text("パラメーターは一つも空白が無いようにしてください"),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("ok"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              }
            );
          }else{
            newFomula = Fomula(
              name: nameController.text,
              describe: describeController.text,
              expression: expressionController.text,
            );
            Navigator.of(context).pop(newFomula);
          }
        },
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                InputFomulaDataForm(
                  induction: "公式の名前を入力してください",
                  controller: nameController,
                  hintText: "Input Fomula Name",
                ),
                InputFomulaDataForm(
                  induction: "公式の式部分を入力してください",
                  controller: expressionController,
                  hintText: "Input Fomula Part of Expression",
                  hintSize: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}