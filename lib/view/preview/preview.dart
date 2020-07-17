import 'package:flutter/material.dart';

import '../input_formula_data/input_formula_data.dart';
import '../datail/detail.dart';
import '../widgets/dialogs.dart';
import '../widgets/drawer.dart';

import '../../data_manager_class/subject.dart';
import '../../data_manager_class/formula.dart';

class Preview extends StatefulWidget {
  final Subject subject;
  final int parentIndex;
  late final List formulaList;

  Preview({required this.subject, required this.parentIndex}) {
    this.formulaList = subject.formulaList;
  }

  @override
  _PreviewState createState() =>
      _PreviewState(subject, formulaList, parentIndex);
}

class _PreviewState extends State<Preview> {
  Subject subject;
  List formulaList;
  int parentIndex;

  _PreviewState(this.subject, this.formulaList, this.parentIndex);

  Widget formulaListView() {
    if (formulaList.length == 0) {
      return Center(child: Text("公式が一つもありません"));
    } else {
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          formula formula = formulaList[index];
          Color color = formula.liked ? Colors.yellow : Colors.grey;
          bool isDelete;
          return Container(
            child: ListTile(
              title: Text("${formula.name}"),
              subtitle: Text(
                "${formula.expression}\ntag: ${formula.tagList}",
                style: TextStyle(fontSize: 12),
              ),
              trailing: IconButton(
                color: color,
                onPressed: () {
                  formula.changeLike(formula.liked);
                  setState(() {
                    color = formula.liked ? Colors.yellow : Colors.grey;
                  });
                },
                icon: Icon(Icons.star),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute<Widget>(
                    builder: (BuildContext context) => Datail(
                          childIndex: index,
                          parentIndex: parentIndex,
                          parentSubject: subject,
                          formula: formula,
                        )));
              },
              onLongPress: () async {
                isDelete = await confirmDeleteformulaDialog(context);
                if (isDelete && !formula.liked) {
                  List<Subject> subjectList =
                      await SubjectPrefarence.getSubjectList();
                  setState(() {
                    subject.formulaList.removeAt(index);
                  });
                  subjectList[parentIndex] = subject;
                  await SubjectPrefarence.saveSubjectList(subjectList);
                }
              },
            ),
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
          );
        },
        itemCount: formulaList.length,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: GeneralDrawer(),
      appBar: AppBar(
        title: Text("Preview formulas in ${subject.name}"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              formula newformula = await Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        AddformulaPage(subjectIndex: parentIndex)),
              );
              if (newformula != null) {
                setState(() {
                  subject.formulaList.add(newformula);
                });
                List<Subject> subjectList =
                    await SubjectPrefarence.getSubjectList();
                subjectList[parentIndex] = subject;
                SubjectPrefarence.saveSubjectList(subjectList);
              }
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: formulaListView(),
          ),
        ],
      ),
    );
  }
}
