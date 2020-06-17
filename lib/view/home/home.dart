import 'package:flutter/material.dart';

import '../preview/preview.dart';
import '../widgets/drawer.dart';
import '../widgets/dialogs.dart';
import '../../data_manager_class/subject.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {
  late List<Subject> subjectList;
  late String newSubjectName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: GeneralDrawer(),
      appBar: AppBar(
        title: Text("Home | Subjects"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async{
              newSubjectName = await inputSubjectDialog(context);
              if(newSubjectName!=null) {
                bool isValid = newSubjectName.trim()!="";
                for(Subject subject in subjectList) {
                  if(subject.name==newSubjectName) isValid = false;
                }
                if(isValid){
                  setState(() {
                    subjectList.add(Subject(name: newSubjectName));
                  });
                  await SubjectPrefarence.saveSubjectList(subjectList);
                }else{
                  await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Text("無効な科目名が入力されました"),
                        actions: <Widget>[
                          FlatButton(
                            child: Text("ok"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    }
                  );
                }
              }
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          FutureBuilder(
            future: SubjectPrefarence.getSubjectList(),
            builder: (BuildContext context, AsyncSnapshot<List<Subject>> snapshot) {
              if(!snapshot.hasData) {
                return Text("データがありません\nデータの通信に失敗した可能性があります");
              }else{
                subjectList = snapshot.data;
                if(subjectList.length==0) {
                  return Padding(
                    padding: EdgeInsets.only(top: 12.0),
                    child: Center(
                      child: Text(
                        "科目が一つもありません\n画面上部のボタンから追加してください",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black54,
                        )
                      ),
                    ),
                  );
                }else{
                  return Expanded(
                    child: ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        Subject subject = subjectList[index];
                        return Container(
                          child: ListTile(
                            title: Text(subject.name),
                            trailing: Text("This Subject has\n${subject.fomulaList.length} Fomulas"),
                            onTap: () {
                              List fomulaList = subject.fomulaList;
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) => Preview(subject: subject, fomulaList: fomulaList, parentIndex: index)
                                ),
                              );
                            },
                            onLongPress: () async{
                              bool isDelete = await confirmDeleteSubjectDialog(context);
                              if(isDelete) {
                                setState(() {
                                  subjectList.removeAt(index);
                                });
                                await SubjectPrefarence.saveSubjectList(subjectList);
                              }
                            },
                          ),
                          decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
                        );
                      },
                      itemCount: subjectList.length,
                    ),
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }
}