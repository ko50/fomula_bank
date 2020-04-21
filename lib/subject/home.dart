import 'package:flutter/material.dart';

import './subject.dart';
import '../tools/tool.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {
  List<Subject> subjectList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(context),
      appBar: AppBar(
        title: Text("Home"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async{
              // TODO showDialog
            },
          ),
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: () async{
              // TODO showDialog
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8.0),
            child: Text("Subjects List"),
            decoration: BoxDecoration(border: bottomBorder()),
          ),
          FutureBuilder(
            future: SubjectPrefarence.getSubjectList(),
            builder: (BuildContext context, AsyncSnapshot<List<Subject>> snapshot) {
              if(snapshot.hasData) {
                return Text("データがありません\nデータの通信に失敗した可能性があります");
              }else if(snapshot.data.length==0) {
                return Text("科目が一つもありません\n画面上部のボタンから追加してください");
              }else{
                return Expanded(
                  child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      Subject subject = subjectList[index];
                      return ListTile(
                        title: Text(subject.name),
                        trailing: Text("This Subject has\n${subject.fomulaList.length} Fomulas"),
                        onTap: () async{
                          // TODO 画面遷移
                        },
                        onLongPress: () async{
                          // TODO showDialog 削除機能
                        },
                      );
                    },
                    itemCount: snapshot.data.length,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}