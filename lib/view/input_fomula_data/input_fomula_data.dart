import 'package:flutter/material.dart';

import './_form.dart';
import './_tag_listview.dart';

import '../../data_manager_class/formula.dart';
import '../../data_manager_class/tag.dart';

class AddformulaPage extends StatelessWidget {
  final int subjectIndex;
  late final formula formula;
  late final TagList tagList;

  AddformulaPage({required this.subjectIndex, formula? formula}) {
    formula ??= formula();
    this.formula = formula;
    this.tagList = formula.tagList;
  }

  /// 何か無効なパラメーターが合った場合表示されるダイアログ
  void showFailedToSaveformulaDialog(context) async {
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    formula _inputtedformula;

    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    TextEditingController _nameController = TextEditingController();
    TextEditingController _descriptionController = TextEditingController();
    TextEditingController _expressionController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("公式の情報を入力してください"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            _inputtedformula = formula(
              name: _nameController.text,
              description: _descriptionController.text,
              expression: _expressionController.text,
              tagList: tagList,
            );
            Navigator.of(context).pop(_inputtedformula);
          } else {
            showFailedToSaveformulaDialog(context);
          }
        },
      ),
      body: Column(
        children: <Widget>[
          InputformulaDataForm(
            maxCharCount: 15,
            labelText: "公式の名前を入力してください",
            controller: _nameController,
            hintText: "Input formula Name",
            formKey: _formKey,
          ),
          InputformulaDataForm(
            maxCharCount: 100,
            labelText: "公式に説明を追加してください",
            controller: _descriptionController,
            hintText: "Describe this Formula",
            formKey: _formKey,
          ),
          InputformulaDataForm(
            maxCharCount: 30,
            labelText: "公式の式部分を入力してください",
            controller: _expressionController,
            hintText: "Input formula Part of Expression",
            formKey: _formKey,
          ),
          TagListView(
            tagList: tagList,
          ),
        ],
      ),
    );
  }
}
