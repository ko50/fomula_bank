// 式のプレビュー表示   式のボディやプロパティを設定する
import 'package:flutter/material.dart';
import '../datail/datail.dart';

class Preview extends StatefulWidget {
  @override
  _PreviewState createState() => _PreviewState();
}
class _PreviewState extends State<Preview> { // TODO クラス分割


  var _objectSavecontroller = TextEditingController();
  var _propetySavecontroller = TextEditingController();

  // こいつらは入力待機かプレビュー表示か切り替えてる
  static bool _waitingInputBody = false;
  static bool _waitingInputPropety = false;
  List<bool> _stateList = [_waitingInputBody, _waitingInputPropety];

  // 右側にあるボタン二つを設定
  MaterialButton _buildButton(int index , TextEditingController controller, String target) {
    // 入力待機時
    if(_stateList[index]) {
      return MaterialButton(
        height: 40,
        minWidth: 40,
        child: Icon(Icons.save),
        onPressed: () {setState(() {
          components[target] = controller.text;
          _stateList[index] = false; // ボタン押したら切り替え
        });},
      );
    }
    // プレビュー表示時
    else{
      return MaterialButton(
        height: 40,
        minWidth: 40,
        child: Icon(Icons.settings),
        onPressed: () {setState(() {
          controller = TextEditingController(text: components[target]); // 現在の式を保持
          _stateList[index] = true; // ボタン押したら切り替え
        });},
      );
    }
  }

  // 左側のスペースの設定
  Widget _buildField(int index, double fontSize, String labelText, TextEditingController controller, int maxline, String target) {
    // 入力時
    if(_stateList[index]){
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
    // プレビュー表示時
    else{
      return Expanded(
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            components[target] ??= "value = null",
            style: TextStyle(fontSize: fontSize),
          ),
        ),
      );
    }
  }

  // 引数長くね？誰だよこんなの書いたの
  // 全体の設定
  Widget _bodyChild(int flex, double fontSize, int index, String labelText, TextEditingController controller, int maxline, String target) {
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
            _buildField(index, fontSize, labelText, controller, maxline, target),
            _buildButton(index, controller, target),
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
          _bodyChild(1, 25, 0, "Formula Body", _objectSavecontroller, 2, "body"),
          _bodyChild(5, 20, 1, "Formula Propety", _propetySavecontroller, null, "propety"),
        ],
      ),
    );
  }
}