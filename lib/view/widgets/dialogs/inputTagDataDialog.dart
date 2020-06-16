import 'package:flutter/material.dart';

import '../../../datamanageclass/tag.dart';

/// Tagを追加するDialog
class InputTagDataDialog extends StatefulWidget {
  final String name;
  final Color color;

  InputTagDataDialog({this.name, this.color});

  @override
  _InputTagDataDialogState createState() => _InputTagDataDialogState(name, color);
}
class _InputTagDataDialogState extends State<InputTagDataDialog> {
  String name;
  Color color;

  _InputTagDataDialogState(this.name, this.color) {
    name ??= "";
    color ??= Colors.white;
  }

  // 正しい定義場所がわからないので誰か教えてください
  FocusNode nameFocus   = FocusNode();
  FocusNode colorFocusR = FocusNode();
  FocusNode colorFocusG = FocusNode();
  FocusNode colorFocusB = FocusNode();

  GlobalKey<FormState> nameFormKey  = GlobalKey<FormState>();
  GlobalKey<FormState> colorFormKey = GlobalKey<FormState>();

  TextEditingController nameContoroller = TextEditingController();
  TextEditingController colorCtrlerR    = TextEditingController();
  TextEditingController colorCtrlerG    = TextEditingController();
  TextEditingController colorCtrlerB    = TextEditingController();

  /// 16進数で与えられるカラーコードを10進数に置き換えます 命名
  String decodeColorCode(String code) {
    // TODO tryParseにして
    int decimalCode = int.parse("0x$code");

    return decimalCode.toString();
  }

  /// ColorController.textから値を取り込み16進数にします
  String encodeColorCode() {
    int r = int.parse(colorCtrlerR.text);
    int g = int.parse(colorCtrlerG.text);
    int b = int.parse(colorCtrlerB.text);
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

    return colorCode;
  }

  /// setColorFormの内容をカラーコードに変換してcolorを更新します
  void upDateColor() {
    String colorCode = encodeColorCode();
    setState(() {
      color = Color(int.parse(colorCode));
    });
  }

  Widget nameSetterTitle() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text("━━━タグ名を設定してください━━━", style: TextStyle(fontSize: 15),),
    );
  }

  /// タグの名前を入力するフォーム 五文字以内じゃないと怒ります
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
                if(value.length > 5) return ("5文字以内で入力してください");
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
              upDateColor();
            }
          },
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    String colorCode = encodeColorCode();
    String r, g, b;
    r = decodeColorCode(colorCode.substring(3, 5));
    g = decodeColorCode(colorCode.substring(5, 7));
    b = decodeColorCode(colorCode.substring(7));
    colorCtrlerR.text = r;
    colorCtrlerG.text = g;
    colorCtrlerB.text = b;
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
                      setColorForm(colorCtrlerR, colorFocusR, "R"),
                      SizedBox(width: 10),
                      setColorForm(colorCtrlerG, colorFocusG, "G"),
                      SizedBox(width: 10),
                      setColorForm(colorCtrlerB, colorFocusB, "B"),
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