import 'package:flutter/material.dart';
import '../tools/tool.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}
class _CalculatorState extends State<Calculator> {
  

  // カーソルから見てどっちか
  List _formula_left = [""];
  List _formula_right = ["|"]; // "|"のindexは常に0であらなければならない

  String _labelFormula = "";
  String _result = "0.0";
  List _signs = ["+", "-", "*", "/", "^", "cos", "sin", "tan", "C", "P", "√", "log(",];

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
    if(label==_labelFormula){
      return _labelMain(label, fontSize);
    }else if(label==_result){
      return MaterialButton(
        child: _labelMain(label, fontSize),
        onPressed: () {
          setState(() {
            _formula_left.add(label);
            _labelFormula = _formula_left.join() + _formula_right.join();
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
        _formula_left.removeLast();
      });
    }else if(child is int){
      setState(() {
        _formula_left.add(child.toString());
      });
    }else if(_signs.contains(child) || child=="." || child=="(" || child==")" /* && _signs.contains(_formula_left[_formula_left.length-1])*/){
      setState(() {
        _formula_left.add(child);
      });
    }else if(child=="="){
      calculation();
    }else if(child=="→"){
      if(_formula_right.length!=0){
        target = _formula_right[1];
        setState(() {
          _formula_left.add(target);
          _formula_right.remove(target);
        });
      }
    }else if(child=="←"){
      target = _formula_left.last;
      setState(() {
        _formula_left.removeLast();
        _formula_right.insert(1, target);
      });
    }else{
      // TODO アラートダイアログを表示する関数 (符号を連続して入力しようとしたカス宛て)
    }
  }

  void calculation() {
    final List formula = _formula_left.sublist(0, _formula_left.length) + _formula_right;
    double leftNum = 0;
    List priority;
    String waitingSign;

/*
    formula.forEach((element){
      if(element is num){
        if(waitingSign==null){
          victim = element;
        }else{
          // ここ、ウンコードだな
          switch(waitingSign){
            case "+":
              leftNum += victim + element;
              break;
            case "-":
              leftNum += victim - element;
              break;
            case "/":
              leftNum += victim / element;
              break;
            case "*":
              leftNum += victim + element;
              break;
            
          }
          waitingSign = null;
        }
      }else if(_signs.contains(element)){waitingSign = element;}
    });
*/
    setState(() {_result = leftNum.toString();});
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
          setState(() {_labelFormula = _formula_left.join() + _formula_right.join();});
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
    setState(() {_labelFormula = _formula_left.join() + _formula_right.join();});
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Column(
             children: <Widget>[
                _buildLabel(_labelFormula, "Formula :", flex: 10, fontSize: 40),
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
