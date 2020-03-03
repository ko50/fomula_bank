import 'package:flutter/material.dart';
import '../tools/tool.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}
class _CalculatorState extends State<Calculator> {
  
  List _formula = [];
  String _labelFormula = "";

  Widget _buildLabel() {
    return Column(
      children: <Widget>[
        Container(
          decoration: bottomBorder(),
          child: Text(_labelFormula),
        ),
        Container(

        ),
      ],
    );
  }

  Widget _buildInputButton(var child) {
    double buttonSize = (getWidth(context) - 16) / 4;
    return MaterialButton(
      minWidth: buttonSize,
      height: buttonSize,
      child: child,
      onPressed: () {
        setState(() {
          _formula.add(child);
          _labelFormula = _formula.join(" ");
        });
      },
    );
  }

  Widget _inputBody() {
    return Container(
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              // TODO 
            ],
          ),


        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator"),
      ),
      body: Column(
        children: <Widget>[

        ],
      ),
    );
  }
}