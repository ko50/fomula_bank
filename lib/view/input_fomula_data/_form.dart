import 'package:flutter/material.dart';

class InputFomulaDataForm extends StatelessWidget{
  final int maxLine;
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final GlobalKey<FormState> formKey;
  final Function(String) validation;

  InputFomulaDataForm({this.maxLine=1, required this.labelText, required this.hintText, required this.controller, required this.formKey, required this.validation});

  Widget _body(FocusNode focusNode, TextEditingController controller) {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextFormField(
            textInputAction: TextInputAction.done,
            focusNode: focusNode,
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2.0),
                borderSide: BorderSide(
                  color: Colors.blue,
                  width: 2.0,
                ),
              ),
              labelText: labelText,
              hintText: hintText,
            ),
            validator: (v) => validation(v),
            onFieldSubmitted: (v) {
              if(formKey.currentState.validate()) focusNode.unfocus();
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    FocusNode _focusNode = FocusNode();
    TextEditingController _controller = TextEditingController();
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: _body(_focusNode, _controller)
      ),
    );
  }
}
