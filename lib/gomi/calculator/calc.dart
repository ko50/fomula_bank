import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "CalcApp",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

// デバイスの横の長さ取得
double getWidth(context) {
  final Size size = MediaQuery.of(context).size;
  return size.width;
}

// デバイスの縦の長さ取得
double getHeight(context) {
  final Size size = MediaQuery.of(context).size;
  return size.height;
}

// Container下部の線引き
BoxDecoration bottomBorder() => BoxDecoration(border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey),));

// 右
BoxDecoration rightBorder() => BoxDecoration(border: Border(right: BorderSide(width: 1.0, color: Colors.grey),));


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {

  // カーソルから見てどっちか
  List _fomula_left = [""];
  List _fomula_right = ["|"]; // "|"のindexは常に0であらなければならない

  String _labelfomula = "";
  String _result = "0.0";
  List _signs = ["+", "-", "*", "/", "^", "cos", "sin", "tan", "C", "P", "√", "log(", "(", ")",];

  Align _labelMain(String label, double fontSize) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        label,
        style: TextStyle(fontSize: fontSize),
      ),
    );
  }
  Widget _switchLabel(String label, double fontSize) {
    if(label==_labelfomula){
      return _labelMain(label, fontSize);
    }else{
      return MaterialButton(
        child: _labelMain(label, fontSize),
        onPressed: () {
          setState(() {
            _fomula_left.add(label);
            _labelfomula = _fomula_left.join() + _fomula_right.join();
          });
        },
      );
    }
  }
  Widget _buildLabel(String label, String hintText, {int flex, double fontSize}) {
    return Expanded(
      flex: flex,
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey),)),
        child: Center(
          child: Row(
            children: <Widget>[
              Container(
                child: Text(
                  hintText,
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Expanded(
                child: _switchLabel(label, fontSize),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _inputed(var child) {
    String target;
    if(child is Icon){
      setState(() {
        _fomula_left.removeLast();
      });
    }else if(child is int){
      setState(() {
        _fomula_left.add(child.toString());
      });
    }else if(_signs.contains(child) || child=="." || child=="(" || child==")" /* && _signs.contains(_fomula_left[_fomula_left.length-1])*/){
      setState(() {
        _fomula_left.add(child);
      });
    }else if(child=="="){
      calculation();
    }else if(child=="→"){
      if(_fomula_right.length!=0){
        target = _fomula_right[1];
        setState(() {
          _fomula_left.add(target);
          _fomula_right.remove(target);
        });
      }
    }else if(child=="←"){
      target = _fomula_left.last;
      setState(() {
        _fomula_left.removeLast();
        _fomula_right.insert(1, target);
      });
    }else{
      // TODO アラートダイアログを表示する関数 (符号を連続して入力しようとしたカス宛て)
    }
  }

  void calculation() {
    List fomula = _fomula_left + _fomula_right.sublist(1);
    int index;
    num number;
    List numbers;
    List signs;
    List priority = [];
    num result;
    String sign;
    // 計算の準備
    do{
      do{
        number += fomula[index];
        fomula.remove(fomula[index]);
      }while(int.tryParse(fomula[index])!=null);
      numbers.add(number);
      if(_signs.contains(fomula[index])){
        signs.add(fomula[index]);
        if(_signs.contains(fomula[index+1])){
          // TODO アラートダイアログ定期
          fomula = [];
        }
        fomula.remove(fomula[index]);
      }
      index += 1;
    }while(fomula!=[]);
    // 優先順位つける  ^ → () → *, /
    index = 0;
    do{
      index = signs.indexOf("^");
      priority.add(["^", numbers[index]]);
      numbers.removeAt(index);
      signs.remove("^");
    }while(signs.contains("^"));
    int endIndex;
    do{
      index = numbers.indexOf("(");
      endIndex = numbers.indexOf(")");
      number = num.parse(numbers.sublist(index, endIndex).join());
      priority.add(["()", number]);
      numbers.remove("(");
      numbers.remove(number);
      numbers.remove(")");
    }while(signs.contains("(") || signs.contains(")"));
    do{
      sign = signs.firstWhere((_sign) => _sign=="*" || _sign=="/");
      if(sign=="*"){
        index = signs.indexOf("*");
        priority.add(["*", numbers[index]]);
        numbers.remove("*");
        signs.removeAt(index);
      }else if(sign=="/"){
        index = signs.indexOf("/");
        priority.add(["/", numbers[index]]);
        numbers.remove("/");
        signs.removeAt(index);
      }else{print("どうして");}
    }while(signs.contains("*") || signs.contains("/"));
    // 本体


    setState(() {_result = result.toString();});
  }

  Widget _inputButton(var child, {double height}) {
    var label;
    if(child is String){
      if(child=="←" || child=="→"){label = Text(child, style: TextStyle(fontSize: 30),);}
      else{label = Text(child, style: TextStyle(fontSize: 20),);}
    }else if(child is int){
      label = Text(child.toString(), style: TextStyle(fontSize: 20),);
    }else{label = child;}
    double buttonSize = (getWidth(context) / 5);
    double buttonHeight = buttonSize;
    if((getHeight(context)-120)/7<buttonSize){
      buttonHeight = (getHeight(context) - 120) / 8;
    }
    if(height!=null){buttonHeight = 50;}
    if(label==null){
      return Container(
        padding: EdgeInsets.all(buttonHeight / 10),
        width: buttonSize,
        height: buttonHeight,
      );
    }else{
      return MaterialButton(
        padding: EdgeInsets.all(buttonHeight / 10),
        minWidth: buttonSize,
        height: buttonHeight,
        child: label,
        onPressed: () {
          _inputed(child);
          setState(() {_labelfomula = _fomula_left.join() + _fomula_right.join();});
        },
      );
    }
  }

  Widget _buttonRow(var fir, var sec, var thir, var four, var fif, {double height}) {
    double buttonHeight = (getWidth(context) / 5);
    if((getHeight(context)-120)/7<buttonHeight){
      buttonHeight = (getHeight(context) - 120) / 8;
    }
    return Container(
      height: height ??= buttonHeight,
      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.0, color: Colors.black12),),),
      child: Row(
        children: <Widget>[
          _inputButton(fir, height: height),
          _inputButton(sec, height: height),
          _inputButton(thir, height: height),
          _inputButton(four, height: height),
          _inputButton(fif, height: height),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    setState(() {_labelfomula = _fomula_left.join() + _fomula_right.join();});
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Column(
             children: <Widget>[
                _buildLabel(_labelfomula, "fomula :", flex: 10, fontSize: 40),
                _buildLabel(_result, "Result :", flex: 7, fontSize: 20,),
             ],
            ),
          ),
          Column(
            children: <Widget>[
              _buttonRow("←", null, null, null, "→", height: 50),
              _buttonRow("log(",  "(",  ")", null,  null,),
              _buttonRow(   "C",  "P",  "!",  "^",  "√",),
              _buttonRow(     7,    8,    9,  "*",  Icon(Icons.backspace),),
              _buttonRow(     4,    5,    6,  "/",  null,),
              _buttonRow(     1,    2,    3,  "-",  null,),
              _buttonRow(     0,  ".", null,  "+",   "=",),
            ],
          ),
        ],
      ),
    );
  }
}
