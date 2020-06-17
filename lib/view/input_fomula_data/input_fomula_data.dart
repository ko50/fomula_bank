import 'package:flutter/material.dart';

import './_form.dart';

import '../../data_manager_class/fomula.dart';
import '../../data_manager_class/tag.dart';

import '../widgets/tag_card_matrix.dart';

import '../widgets/dialogs/input_tag_data_dialog.dart';

class AddFomulaPage extends StatelessWidget {
  final int subjectIndex;
  late Fomula fomula;

  AddFomulaPage({required this.subjectIndex, fomula}) {
    fomula ??= Fomula();
    this.fomula = fomula;
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TagList _tagList = fomula.tagList;
  TextEditingController _nameController        = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _expressionController  = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Fomula _fomula;
    TagList _tagList = fomula.tagList;
    TextEditingController _nameController       = TextEditingController();
    TextEditingController _descriptionController   = TextEditingController();
    TextEditingController _expressionController = TextEditingController();
    GlobalKey<FormState> _nameFormKey = GlobalKey<FormState>();
    GlobalKey<FormState> _descriptionFormKey = GlobalKey<FormState>();
    GlobalKey<FormState> _expressionFormKey = GlobalKey<FormState>();
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
              description:   _descriptionController.text,
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
                  formKey: _formKey,
                  validation: (v) {

                  },
                ),
                InputFomulaDataForm(
                  labelText: "公式に説明を追加してください",
                  controller: _descriptionController,
                  hintText: "Describe this Formula",
                  formKey: _formKey,
                  validation: (v) {

                  },
                ),
                InputFomulaDataForm(
                  labelText: "公式の式部分を入力してください",
                  controller: _expressionController,
                  hintText: "Input Fomula Part of Expression",
                  formKey: _formKey,
                  validation: (v) {

                  },
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