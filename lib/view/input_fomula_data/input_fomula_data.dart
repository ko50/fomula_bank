import 'package:flutter/material.dart';

import './_form.dart';

import '../../data_manager_class/fomula.dart';
import '../../data_manager_class/tag.dart';

import '../widgets/tag_card_matrix.dart';

class AddFomulaPage extends StatelessWidget {
  final int subjectIndex;
  late final Fomula fomula;
  late final TagList tagList;

  AddFomulaPage({required this.subjectIndex, Fomula? fomula}) {
    fomula ??= Fomula();
    this.fomula = fomula;
    this.tagList = fomula.tagList;
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _expressionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Fomula _inputedFomula;
    TagList _tagList = fomula.tagList;
    return Scaffold(
      appBar: AppBar(
        title: Text("新しい公式を追加します"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            _inputedFomula = Fomula(
              name: _nameController.text,
              description: _descriptionController.text,
              expression: _expressionController.text,
            );
            Navigator.of(context).pop(_inputedFomula);
          } else {
            await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("無効な値が入力されました"),
                  content: Text(
                      "パラメーターは一つも空白が無いようにしてください"), // TODO このページをちゃんとつくる(特にTag関連)
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
                  formKey: _formKey,
                  validation: (v) {
                    if (v.isEmpty)
                      return "空白は不可です";
                    else if (v.length > 15) return "長すぎます 15文字以下にして下さい";
                  },
                ),
                InputFomulaDataForm(
                  labelText: "公式に説明を追加してください",
                  controller: _descriptionController,
                  hintText: "Describe this Formula",
                  formKey: _formKey,
                  validation: (v) {
                    if (v.isEmpty)
                      return "空白は不可です";
                    else if (v.length > 100) return "長すぎます 100文字以下にして下さい";
                  },
                ),
                InputFomulaDataForm(
                  labelText: "公式の式部分を入力してください",
                  controller: _expressionController,
                  hintText: "Input Fomula Part of Expression",
                  formKey: _formKey,
                  validation: (v) {
                    if (v.isEmpty)
                      return "空白は不可です";
                    else if (v.length > 30) return "長すぎます 30文字以下にして下さい";
                  },
                ),
                TagCardMatrix(_tagList), // ここをDialog方式にして、ボタン二つだけの表示にする
              ],
            ),
          ),
        ],
      ),
    );
  }
}
