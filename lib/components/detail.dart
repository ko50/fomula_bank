import './_exporter.dart';
import '../models/_exporter.dart';
import '../tools/tool.dart';

class Datail extends StatefulWidget {
  final int parentIndex;
  final Subject parentSubject;
  final int childIndex;
  final Fomula fomula;

  Datail({this.parentIndex, this.parentSubject, this.childIndex, this.fomula});

  @override
  _DatailState createState() => _DatailState(parentIndex, parentSubject, childIndex, fomula);
}
class _DatailState extends State<Datail> {
  int parentIndex;
  Subject parentSubject;
  int childIndex;
  Fomula fomula;

  _DatailState(this.parentIndex, this.parentSubject, this.childIndex, this.fomula);

  List<Subject> subjectList;
  Fomula newFomulaData;
  bool isEditing = false;
  var nameController;
  var describeController;
  var expressionController;
  var tagListController;

  Widget fomulaDataDisplayer({double height, double fontSize, String title, String message}) {
    return Container(
      padding: EdgeInsets.all(12.0),
      height: height,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(title, style: TextStyle(fontSize: 23)),
                ),
              ],
            ),
            decoration: BoxDecoration(border: Border.all(width: 1.0, color: Colors.grey), borderRadius: BorderRadius.circular(4.0)),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(message, style: TextStyle(fontSize: fontSize)),
                ),
              ],
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(border: Border(bottom: greyThinBorder())),
    );
  }

  Widget inputFomulaDataForm({double height, String induction, TextEditingController controller, String hintText}) {
    return Container(
      padding: EdgeInsets.all(12.0),
      height: height,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(induction, style: TextStyle(fontSize: 22,)),
                ),
              ],
            ),
            decoration: BoxDecoration(border: Border.all(width: 1.0, color: Colors.grey), borderRadius: BorderRadius.circular(4.0)),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration.collapsed(
                    hintText: hintText,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      decoration: BoxDecoration(border: Border(bottom: greyThinBorder())),
    );
  }


  Widget saveButton() {
    if(isEditing) {
      return FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () async{
          if([nameController.text.trim(), describeController.text.trim(), expressionController.text.trim(), tagListController.text.trim()].contains("")) {
            await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("無効な値が入力されました"),
                  content: Text("パラメーターは一つも空白が無いようにしてください"),
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
            newFomulaData = Fomula(
              name:       nameController.text,
              describe:   describeController.text,
              expression: expressionController.text,
              tagList:    tagListController.text.split(" "),
            );
            parentSubject.fomulaList[childIndex] = newFomulaData;
            subjectList = await SubjectPrefarence.getSubjectList();
            subjectList[parentIndex] = parentSubject;
            await SubjectPrefarence.saveSubjectList(subjectList);
            setState(() {
              fomula = parentSubject.fomulaList[childIndex];
              isEditing = false;
            });
          }
        },
      );
    }else return null;
  }

  Widget mainWidget() {
    if(isEditing) {
      nameController       = TextEditingController(text: fomula.name);
      describeController   = TextEditingController(text: fomula.describe);
      expressionController = TextEditingController(text: fomula.expression);
      tagListController    = TextEditingController(text: fomula.tagList.join(" "));
      return ListView(
        children: <Widget>[
          inputFomulaDataForm(
            height: 200,
            induction: "1. 公式の名前を入力してください",
            controller: nameController,
            hintText: "Input Fomula Name",
          ),
          inputFomulaDataForm(
            height: 200,
            induction: "2. 公式の式部分を入力してください",
            controller: expressionController,
            hintText: "Input Fomula Part of Expression",
          ),
          inputFomulaDataForm(
            height: 300,
            induction: "3. 公式の説明文や定義を入力してください",
            controller: describeController,
            hintText: "Input Fomula Description"
          ),
          inputFomulaDataForm(
            height: 250,
            induction: "4. この公式に付けるタグを入力してください",
            controller: tagListController,
            hintText: "Input Tags",
          ),
        ],
      );
    }else{
      return ListView(
        children: <Widget>[
          fomulaDataDisplayer(
            height: 200,
            fontSize: 22,
            title: "Expression",
            message: fomula.expression,
          ),
          fomulaDataDisplayer(
            height: 300,
            fontSize: 16,
            title: "Description",
            message: fomula.describe,
          ),
          fomulaDataDisplayer(
            height: 250,
            fontSize: 16,
            title: "Tags",
            message: fomula.tagList.join(" "),
          ),
        ],
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Displaying ${fomula.name} Detail"),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              setState(() {
                isEditing = true;
              });
            },
            icon: Icon(Icons.edit),
          ),
        ],
      ),
      floatingActionButton: saveButton(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: mainWidget(),
          ),
        ],
      ),
    );
  }
}