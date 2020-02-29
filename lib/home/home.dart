// 最初の画面   /datailまたは/searchに飛ぶ
import 'package:flutter/material.dart';

String subject;
String datailtitle;

class Home extends StatelessWidget {

  Widget _titleContainer(String text) { // 画面遷移ボタンのタイトル分け
    return Container(
      height: 60,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey),),
      ),
      child: Center(child: Text(text, style: TextStyle(fontSize: 30),),),
    );
  }

  Widget _buildButton(String labels, context) { // 画面遷移ボタン
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey))
      ),
      height: 50,
      width: 160,
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
            Container(
              height: 250, // TODO デバイス依存の設定
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey),),
                ),
              child: Column(
                children: <Widget>[
                  _titleContainer("Select Subject"),
                  _buildButton("Math", context),
                  _buildButton("Physics", context),
                  _buildButton("Chemical", context),
                ],
              ),
            ),
            Container(
              height: 300,
              child: Column(
                children: <Widget>[
                  _titleContainer("Others"),
                  _buildButton("Search", context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}