// 式のプレビュー表示   式のボディやプロパティを設定する
import 'package:flutter/material.dart';
import '../datail/datail.dart';

class Preview extends StatefulWidget {
  @override
  _PreviewState createState() => _PreviewState();
}
class _PreviewState extends State<Preview> { // TODO クラス分割

  final String formulaName;
  _PreviewState({this.formulaName}): super();

  var _objectSavecontroller = TextEditingController();
  var _propetySavecontroller = TextEditingController();

  // こいつらは入力待機かプレビュー表示か切り替えてる
  bool _waitingInputObject = false;
  bool _waitingInputPropety = false;

  // 右側にあるボタン二つを設定
  MaterialButton _buildButton(bool state, TextEditingController controller, String target) {
    // 入力待機時
    if(state) {
      return MaterialButton(
        height: 40,
        minWidth: 40,
        child: Icon(Icons.settings),
        onPressed: () {setState(() {
          controller = TextEditingController(text: componentsMap[formulaName][target]); // 現在の式を保持
          state = !state; // ボタン押したら切り替え
        });},
      );
    }
    // プレビュー表示時
    else{
      return MaterialButton(
        height: 40,
        minWidth: 40,
        child: Icon(Icons.save),
        onPressed: () {setState(() {
          componentsMap[formulaName][target] = controller.text;
          state = !state; // ボタン押したら切り替え
        });},
      );
    }
  }

  // 左側のスペースの設定
  Widget _buildField(bool state, double fontSize, String labelText, TextEditingController controller, int maxline, String target) {
    // 入力時
    if(state){
      return Expanded(
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            componentsMap[formulaName][target] ??= "value = null",
            style: TextStyle(fontSize: fontSize),
          ),
        ),
      );
    }
    // プレビュー表示時
    else{
      return Expanded(
        child: TextField(
          enabled: true,
          keyboardType: TextInputType.multiline,
          maxLines: maxline,
          decoration: InputDecoration(labelText: labelText),
          controller: controller,
        ),
      );
    }
  }

  // 引数長くね？誰だよこんなの書いたの
  // 全体の設定
  Widget _bodyChild(int flex, double fontSize, bool state, String labelText, TextEditingController controller, int maxline, String target) {
    return Expanded(
      flex: flex,
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1.0,
              color: Colors.grey,
            ),
          ),
        ),
        child: Row(
          children: <Widget>[
            _buildField(state, fontSize, labelText, controller, maxline, target),
            _buildButton(state, controller, target),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(formulaName),
      ),
      body: Column(
        children: <Widget>[
          _bodyChild(1, 25, _waitingInputObject, "Formula Body", _objectSavecontroller, 2, "body"),
          _bodyChild(5, 20, _waitingInputPropety, "Formula Propety", _propetySavecontroller, null, "propety"),
        ],
      ),
    );
  }
}