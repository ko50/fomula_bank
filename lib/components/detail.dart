import './_exporter.dart';
import '../models/_exporter.dart';

class Datail extends StatefulWidget {
  final int index;
  final Fomula fomula;
  final Subject subject;

  Datail({this.index, this.fomula, this.subject});

  @override
  _DatailState createState() => _DatailState(index, fomula, subject);
}
class _DatailState extends State<Datail> {
  int index;
  Fomula fomula;
  Subject pearentSubject;

  _DatailState(this.index, this.fomula, this.pearentSubject);

  bool isEditing = false;
  var nameController;
  var describeController;
  var expressionController;
  var tagListController;

  Widget saveButton() {
    if(isEditing) {
      return FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () async{
          if([nameController.text.trim(), describeController.text.trim(), expressionController.text.trim(), tagListController.text.trim()].contains("")) {
            // TODO 無効な値
          }else{
            // TODO 保存処理
            setState(() {
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
      );
    }else{
      return ListView(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Text("Expression:", style: TextStyle(fontSize: 20)),
                Text("${fomula.expression}"),
              ],
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Text("Describe: ", style: TextStyle(fontSize: 20)),
                Text("${fomula.describe}"),
              ],
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Text("tags: ", style: TextStyle(fontSize: 20)),
                Text("${fomula.tagList}"),
              ],
            ),
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