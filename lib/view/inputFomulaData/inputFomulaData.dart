import 'package:flutter/material.dart';

import './_form.dart';

import '../../datamanageclass/fomula.dart';
import '../../datamanageclass/tag.dart';

import '../widgets/tagCardMatrix.dart';
import '../widgets/dialogs/inputTagDataDialog.dart';

class AddFomulaPage extends StatelessWidget {
  final int subjectIndex;

  AddFomulaPage({this.subjectIndex});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Fomula _newFomula;
    TagList _tagList;
    var _nameController       = TextEditingController();
    var _describeController   = TextEditingController();
    var _expressionController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("新しい公式を追加します"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () async{
          if(formKey.currentState.validate()) {
            _newFomula = Fomula(
              name:       _nameController.text,
              describe:   _describeController.text,
              expression: _expressionController.text,
            );
            Navigator.of(context).pop(_newFomula);
          }else{
            await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("無効な値が入力されました"),
                  content: Text("パラメーターは一つも空白が無いようにしてください"), // TODO このページをちゃんとつくる(特にTag関連)
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
          }
        },
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                InputFomulaDataForm(
                  labelText: "公式の名前を入力してください",
                  controller: _nameController,
                  hintText: "Input Fomula Name",
                ),
                InputFomulaDataForm(
                  labelText: "公式に説明を追加してください",
                  controller: _describeController,
                  hintText: "Describe this Formula",
                ),
                InputFomulaDataForm(
                  labelText: "公式の式部分を入力してください",
                  controller: _expressionController,
                  hintText: "Input Fomula Part of Expression",
                ),
                TagCardMatrix(_tagList),
              ],
            ),
          ),
        ],
      ),
    );
  }
}