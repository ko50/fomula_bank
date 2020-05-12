import 'package:flutter/material.dart';

import '../../datamanageclass/tag.dart';

class AddTagDialog extends StatefulWidget {
  @override
  _AddTagDialogState createState() => _AddTagDialogState();
}
class _AddTagDialogState extends State<AddTagDialog> {
  String name;
  Color color;

  Key formKey = GlobalKey<FormState>();
  FocusNode tagFocus = FocusNode();
  FocusNode colorFocusR = FocusNode();
  FocusNode colorFocusG = FocusNode();
  FocusNode colorFocusB = FocusNode();
  var nameContoroller = TextEditingController();
  var colorControllerR = TextEditingController(text: "255");
  var colorControllerG = TextEditingController(text: "255");
  var colorControllerB = TextEditingController(text: "255");

  void changeColor() {
    int r = int.parse(colorControllerR.text);
    int g = int.parse(colorControllerG.text);
    int b = int.parse(colorControllerB.text);
    String rS = r.toRadixString(16);
    String gS = g.toRadixString(16);
    String bS = b.toRadixString(16);
    if (r < 10) {
      rS = "0$rS";
    }
    if (g < 10) {
      gS = "0$gS";
    }
    if (b < 10) {
      bS = "0$bS";
    }
    String colorCode = "0xff$rS$gS$bS";
    setState(() {
      color = Color(int.parse(colorCode));
    });
  }

  /// 色の数値を入力するフォーム 入力が数字じゃないと怒ります
  Expanded setColorForm(TextEditingController controller, FocusNode focusNode, String labelText) {
    return Expanded(
      flex: 1,
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.done,
        focusNode: focusNode,
        onFieldSubmitted: (v) {
          changeColor();
          focusNode.unfocus();
        },
        validator: (value) {
          if(value.length == 0 || int.tryParse(value) != null || (int.parse(value) >= 0 && int.parse(value) <= 255)) {
            return ("0～255の間の数値のみ入力可能です");
          }else{
            return ("");
          }
        },
        decoration: InputDecoration(
          labelText: labelText,
          hintText: "0～255",
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2.0),
            borderSide: BorderSide(width: 2.0, color: Colors.blue),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    color = Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("新しいタグの名前と色を設定してください"),
      content: Form(
        key: formKey,
        child: Container(
          height: 400,
          child: Column(
            children: <Widget>[/*
              TextField(
                controller: nameContoroller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2.0),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                  labelText: "タグの名前を入力してください",
                  hintText: "Tag",
                ),
              ),*/
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("━━━色を設定してください━━━", style: TextStyle(fontSize: 20),),
              ),
              Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(8.0),
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: color,
                      border: Border.all(
                        width: 1.0,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  setColorForm(colorControllerR, colorFocusR, "R"),
                  SizedBox(width: 10,),
                  setColorForm(colorControllerG, colorFocusG, "G"),
                  SizedBox(width: 10,),
                  setColorForm(colorControllerB, colorFocusB, "B"),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text("cancel"),
          onPressed: () => Navigator.of(context).pop(),
        ),
        FlatButton(
          child: Text("complete"),
          onPressed: () => Navigator.of(context).pop(
            Tag(name: name, color: color)
          ),
        ),
      ],
    );
  }
}