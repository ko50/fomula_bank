import '../_exporter.dart';
import '../../models/_exporter.dart';

class AddFomulaPage extends StatelessWidget {
  final int index;

  AddFomulaPage({this.index});

  @override
  Widget build(BuildContext context) {
    Fomula newFomula;
    List<Subject> subjectList;
    var nameController, describeController, expressionController, tagListController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("新しい公式を追加します"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () async{
          if([nameController.text.trim(), describeController.text.trim(), expressionController.text.trim(), tagListController.text.trim()].contains("")) {
            await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("無効な値が入力されました"),
                  content: Text("パラメーターは一つも空白でないようにしてください"),
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
          }else{
            subjectList = await SubjectPrefarence.getSubjectList();
            newFomula = Fomula(
              name: nameController.text,
              describe: describeController.text,
              expression: expressionController.text,
              tagList: tagListController.text.split(" "),
            );
            subjectList[index].fomulaList.add(newFomula);
            await SubjectPrefarence.saveSubjectList(subjectList);
            Navigator.of(context).pop();
          }
        },
      ),
      body: Column(
        children: <Widget>[
          ListView(
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: nameController,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: expressionController,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: describeController,
                        maxLines: null,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 25,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: tagListController,
                        maxLines: null,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}