import 'package:flutter/material.dart';

import './addTagDialog.dart';
import '../../datamanageclass/fomula.dart';

class AddFomulaPage extends StatelessWidget {
  final int subjectIndex;

  AddFomulaPage({this.subjectIndex});

  Widget _inputFomulaDataForm({int line=2, String induction, TextEditingController controller, String hintText, double hintSize}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            induction,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 20),
          ),
        ),
        TextField(
          controller: controller,
          maxLines: line,
          decoration: InputDecoration.collapsed(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 2.0),
              borderRadius: BorderRadius.circular(4.0),
            ),
            hintText: hintText,
            hintStyle: TextStyle(fontSize: hintSize)
          ),
        ),
      ],
    );
  }

  Widget tagInputter() {
    return Column(
      children: <Widget>[
        
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Fomula newFomula;
    var nameController = TextEditingController();
    var describeController = TextEditingController();
    var expressionController = TextEditingController();
    var tagListController = TextEditingController();
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
              tagList: tagListController.text.split(" "),
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
                _inputFomulaDataForm(
                  induction: "公式の名前を入力してください",
                  controller: nameController,
                  hintText: "Input Fomula Name",
                ),
                _inputFomulaDataForm(
                  induction: "公式の式部分を入力してください",
                  controller: expressionController,
                  hintText: "Input Fomula Part of Expression",
                  hintSize: 20,
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () async{
                    await showDialog(
                      context: context,
                      child: AddTagDialog(
                        
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}