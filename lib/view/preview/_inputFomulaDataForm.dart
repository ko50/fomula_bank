import 'package:flutter/material.dart';

class InputFomulaDataForm extends StatelessWidget{
  final int maxLine;
  final String induction;
  final TextEditingController controller;
  final String hintText;
  final double hintSize;

  InputFomulaDataForm({this.maxLine=2, this.induction, this.controller, this.hintText, this.hintSize});

  @override
  Widget build(BuildContext context) {
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
          maxLines: maxLine,
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
}
