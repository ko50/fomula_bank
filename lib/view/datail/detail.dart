import 'package:flutter/material.dart';

import '../../data_manager_class/fomula.dart';
import '../../data_manager_class/subject.dart';

class Datail extends StatefulWidget {
  final int parentIndex;
  final Subject parentSubject;
  final int childIndex;
  final Fomula fomula;

  Datail({required this.parentIndex, required this.parentSubject, required this.childIndex, required this.fomula});

  @override
  _DatailState createState() => _DatailState(parentIndex, parentSubject, childIndex, fomula);
}
class _DatailState extends State<Datail> {
  int parentIndex;
  Subject parentSubject;
  int childIndex;
  Fomula fomula;

  _DatailState(this.parentIndex, this.parentSubject, this.childIndex, this.fomula);

  late List<Subject> subjectList;
  late Fomula newFomulaData;
  late bool isEditing = false;
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController expressionController;

  Widget fomulaDataDisplayer({double height, double fontSize, String title, String message}) {
    return Container(
      padding: EdgeInsets.all(12.0),
      height: height,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(title, style: TextStyle(fontSize: 23)),
                ),
              ],
            ),
            decoration: BoxDecoration(border: Border.all(width: 1.0, color: Colors.grey), borderRadius: BorderRadius.circular(4.0)),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(message, style: TextStyle(fontSize: fontSize)),
                ),
              ],
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
    );
  }

  Widget inputFomulaDataForm({double height=200, String induction, TextEditingController controller, String hintText}) {
    return Container(
      padding: EdgeInsets.all(12.0),
      height: height,
      child: Column(
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
          Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration.collapsed(
                    hintText: hintText,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
    );
  }


  Widget saveButton() {
    if(isEditing) {
      return FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () async{
          if([nameController.text.trim(), descriptionController.text.trim(), expressionController.text.trim(), tagListController.text.trim()].contains("")) {
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
            newFomulaData = Fomula(
              name:       nameController.text,
              description:   descriptionController.text,
              expression: expressionController.text,
              tagList:    tagListController.text.split(" "),
            );
            parentSubject.fomulaList[childIndex] = newFomulaData;
            subjectList = await SubjectPrefarence.getSubjectList();
            subjectList[parentIndex] = parentSubject;
            await SubjectPrefarence.saveSubjectList(subjectList);
            setState(() {
              fomula = parentSubject.fomulaList[childIndex];
              isEditing = false;
            });
          }
        },
      );
    }else return null;
  }

  Widget mainWidget() {
    if(isEditing) {
      nameController       = TextEditingController(text: fomula.name);
      descriptionController   = TextEditingController(text: fomula.description);
      expressionController = TextEditingController(text: fomula.expression);
      return ListView(
        children: <Widget>[
          inputFomulaDataForm(
            induction: "1. 公式の名前を入力してください",
            controller: nameController,
            hintText: "Input Fomula Name",
          ),
          inputFomulaDataForm(
            induction: "2. 公式の式部分を入力してください",
            controller: expressionController,
            hintText: "Input Fomula Part of Expression",
          ),
          inputFomulaDataForm(
            height: 300,
            induction: "3. 公式の説明文や定義を入力してください",
            controller: descriptionController,
            hintText: "Input Fomula Description"
          ),
        ],
      );
    }else{
      return ListView(
        children: <Widget>[
          fomulaDataDisplayer(
            height: 200,
            fontSize: 22,
            title: "Expression",
            message: fomula.expression,
          ),
          fomulaDataDisplayer(
            height: 300,
            fontSize: 16,
            title: "Description",
            message: fomula.description,
          ),
          fomulaDataDisplayer(
            height: 250,
            fontSize: 16,
            title: "Tags",
            message: fomula.tagList.list.join(" "),
          ),
        ],
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Displaying ${fomula.name} Detail"),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              setState(() {
                isEditing = true;
              });
            },
            icon: Icon(Icons.edit),
          ),
        ],
      ),
      floatingActionButton: saveButton(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: mainWidget(),
          ),
        ],
      ),
    );
  }
}