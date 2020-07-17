import 'package:flutter/material.dart';

import './_form.dart';
import './_tag_listview.dart';

import '../../data_manager_class/fomula.dart';
import '../../data_manager_class/tag.dart';

class AddFomulaPage extends StatelessWidget {
  final int subjectIndex;
  late final Fomula fomula;
  late final TagList tagList;

  AddFomulaPage({required this.subjectIndex, Fomula? fomula}) {
    fomula ??= Fomula();
    this.fomula = fomula;
    this.tagList = fomula.tagList;
  }

  /// 何か無効なパラメーターが合った場合表示されるダイアログ
  void showFailedToSaveFomulaDialog(context) async {
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
    Fomula _inputedFomula;

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
            _inputedFomula = Fomula(
              name: _nameController.text,
              description: _descriptionController.text,
              expression: _expressionController.text,
              tagList: tagList,
            );
            Navigator.of(context).pop(_inputedFomula);
          } else
            showFailedToSaveFomulaDialog(context);
        },
      ),
      body: Column(
        children: <Widget>[
          InputFomulaDataForm(
            maxCharCount: 15,
            labelText: "公式の名前を入力してください",
            controller: _nameController,
            hintText: "Input Fomula Name",
            formKey: _formKey,
          ),
          InputFomulaDataForm(
            maxCharCount: 100,
            labelText: "公式に説明を追加してください",
            controller: _descriptionController,
            hintText: "Describe this Formula",
            formKey: _formKey,
          ),
          InputFomulaDataForm(
            maxCharCount: 30,
            labelText: "公式の式部分を入力してください",
            controller: _expressionController,
            hintText: "Input Fomula Part of Expression",
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
