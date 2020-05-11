import 'package:flutter/material.dart';

import '../../datamanageclass/fomula.dart';

class AddFomulaPage extends StatelessWidget {
  final int index;

  AddFomulaPage({this.index});

  Widget inputFomulaDataForm({double height, String induction, TextEditingController controller, String hintText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(induction, style: TextStyle(fontSize: 22,)),
              ),
            ],
          ),
          decoration: BoxDecoration(border: Border.all(width: 1.0, color: Colors.grey), borderRadius: BorderRadius.circular(4.0)),
        ),
          TextField(
            controller: controller,
            decoration: InputDecoration.collapsed(
              hintText: hintText,
            ),
          ),
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
                inputFomulaDataForm(
                  height: 200,
                  induction: "1. 公式の名前を入力してください",
                  controller: nameController,
                  hintText: "Input Fomula Name",
                ),
                inputFomulaDataForm(
                  height: 200,
                  induction: "2. 公式の式部分を入力してください",
                  controller: expressionController,
                  hintText: "Input Fomula Part of Expression",
                ),
                inputFomulaDataForm(
                  height: 300,
                  induction: "3. 公式の説明文や定義を入力してください",
                  controller: describeController,
                  hintText: "Input Fomula Description"
                ),
                inputFomulaDataForm(
                  height: 250,
                  induction: "4. この公式に付けるタグを入力してください",
                  controller: tagListController,
                  hintText: "Input Tags",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}