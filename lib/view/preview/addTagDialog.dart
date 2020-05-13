import 'package:flutter/material.dart';

import '../../datamanageclass/tag.dart';

class AddTagDialog extends StatefulWidget {
  @override
  _AddTagDialogState createState() => _AddTagDialogState();
}
class _AddTagDialogState extends State<AddTagDialog> {
  String name;
  Color color = Colors.white;

  FocusNode nameFocus = FocusNode();
  var nameFormKey = GlobalKey<FormState>();
  var nameContoroller = TextEditingController();

  FocusNode colorFocusR = FocusNode();
  FocusNode colorFocusG = FocusNode();
  FocusNode colorFocusB = FocusNode();
  var colorFormKey = GlobalKey<FormState>();
  var colorControllerR = TextEditingController(text: "255");
  var colorControllerG = TextEditingController(text: "255");
  var colorControllerB = TextEditingController(text: "255");

  /// setColorFormの内容をカラーコードに変換してcolorを更新します
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

  /// "タグ名を設定してください"
  Widget nameSetterTitle() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text("━━━タグ名を設定してください━━━", style: TextStyle(fontSize: 15),),
    );
  }

  /// タグの名前を入力するフォーム lengthの範囲が 1..10 じゃないと怒ります
  Widget setNameForm() {
    return Container(
      padding: EdgeInsets.all(4.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextFormField(
              textInputAction: TextInputAction.done,
              focusNode: nameFocus,
              controller: nameContoroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.0),
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 2.0,
                  ),
                ),
                labelText: "タグの名前を入力",
                hintText: "Tag",
              ),
              validator: (value) {
                if(value.length > 10) return ("タグ名が長すぎます。\n10文字以内で設定してください");
                else if(value.length == 0) return ("タグ名を入力してください");
                else return null;
              },
              onFieldSubmitted: (v) {
                if(nameFormKey.currentState.validate()) {
                  nameFocus.unfocus();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  /// "色を設定してください"
  Widget colorSetterTitle() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text("━━━━色を設定してください━━━━", style: TextStyle(fontSize: 15),),
    );
  }

  /// 色の数値を入力するフォーム 入力が数字じゃないと怒ります
  Widget setColorForm(TextEditingController controller, FocusNode focusNode, String labelText) {
    return Expanded(
      flex: 1,
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.done,
        focusNode: focusNode,
        onFieldSubmitted: (v) {
          focusNode.unfocus();
        },
        validator: (value) {
          if(value.length == 0 || int.tryParse(value) == null || !(int.parse(value) >= 0 && int.parse(value) <= 255)) return ("異常な値");
          else return null;
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

  /// 現在の色を表示し、押すと色を更新するボタン
  Widget colorPreviewButton() {
    return Column(
      children: <Widget>[
        Text("現在の色", style: TextStyle(fontSize: 13)),
        MaterialButton(
          height: 50,
          minWidth: 50,
          color: color,
          child: Container(
            height: 20,
            width: 20,
            color: Colors.white70,
            child: Center(child: Icon(Icons.sync, size: 15,)),
          ),
          onPressed: () {
            if(colorFormKey.currentState.validate()) {
              changeColor();
            }
          },
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("タグを追加"),
      content: Container(
        height: 250,
        child: Flex(
          direction: Axis.vertical,
          children: <Widget>[
            Form(
              key: nameFormKey,
              child: Column(
                children: <Widget>[
                  nameSetterTitle(),
                  setNameForm(),
                ],
              ),
            ),
            SizedBox(height: 20),
            Form(
              key: colorFormKey,
              child: Column(
                children: <Widget>[
                  colorSetterTitle(),
                  Flex(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      colorPreviewButton(),
                      SizedBox(width: 10),
                      setColorForm(colorControllerR, colorFocusR, "R"),
                      SizedBox(width: 10),
                      setColorForm(colorControllerG, colorFocusG, "G"),
                      SizedBox(width: 10),
                      setColorForm(colorControllerB, colorFocusB, "B"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text("cancel"),
          onPressed: () => Navigator.of(context).pop(),
        ),
        FlatButton(
          child: Text("complete"),
          onPressed: () {
            if(nameFormKey.currentState.validate() && colorFormKey.currentState.validate()) {
              Navigator.of(context).pop(Tag(name: name, color: color));
            }
          }
        ),
      ],
    );
  }
}