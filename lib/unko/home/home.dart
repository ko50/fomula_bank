// 最初の画面
import 'package:flutter/material.dart';

String subject;
String datailtitle;

class Home extends StatelessWidget {

  Widget _buildButton(String labels, double width, context) { // 画面遷移ボタン
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey))
      ),
      height: 50,
      width: width,
      child: MaterialButton(
        child: Text(
          labels,
          style: TextStyle(fontSize: 25),
        ),
        onPressed: () {
          datailtitle = labels;
          subject = labels;
          if(labels=="Search"){Navigator.of(context).pushNamed("/search");}
          else{Navigator.of(context).pushNamed("/datail");}
        }
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Fanction Bank",
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            // 教科選択
            Column(
              children: <Widget>[
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey),),
                  ),
                  child: Center(child: Text("Select Subject", style: TextStyle(fontSize: 26),),),
                ),
                _buildButton("Math", 140, context),
                _buildButton("Physics", 140, context),
                _buildButton("Chemical", 140, context),
              ],
            ),
            // 検索
            _buildButton("Search", 160, context),
          ],
        ),
      ),
    );
  }
}