import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Function Bank",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

String subject = " ";
String datailtitle;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {
  Widget _buildButton(String labels) {
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
          setState(() {
            datailtitle = labels;
            subject = labels;
          });
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => Datail()
            ),
          );
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
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey),),
                    ),
                    child: Center(child: Text("Select Subject", style: TextStyle(fontSize: 30,),),),
                  ),
                  _buildButton("Math"),
                  _buildButton("Physics"),
                  _buildButton("Chemical"),
                ],
              ),
            ),
            Container(
              height: 300,
/*              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey),),
              ),
*/              child: Column(
                children: <Widget>[
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey),),
                    ),
                    child: Center(child: Text("Others", style: TextStyle(fontSize: 30),),),
                  ),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey),),
                    ),
                    height: 50,
                    width: 160,
                    child: MaterialButton(
                      child: Text(
                        "Search",
                        style: TextStyle(fontSize: 25),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => Search()
                          ),
                        );
                      }
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List itemListOfMath = <String>[];
List itemListOfPhysics = <String>[];
List itemListOfChemical = <String>[];
Map mapOfitemList = {"Math": itemListOfMath, "Physics": itemListOfPhysics, "Chemical": itemListOfChemical};
String fomulaName = " ";
Map mapOfNameOfFomula = {};
String nameOfFomula;
Map mapOfPropeties = {};
String propeties = " ";
Map mapOfTags = {};
List tags;
String tag = " ";
Map mapOfBool = {};
bool bools = false;
Map mapOfPaint = {};
bool paint;

class Datail extends StatefulWidget {
  @override
  _DatailState createState() => _DatailState();
}
class _DatailState extends State<Datail> {
  int _targetter = 0;
  String _labelText = " ";
  String _labelTag = " ";
  String _e = " ";
  String _t = " ";
  String _stateOfAdd = "false";
  String _nameValue = " ";
  String _propetyValue = " ";
  bool _boolValue;
  List _labelTags = [];
  List _itemList = mapOfitemList[subject];
  int _fieldCounts = 1;
  var _addingFomulacontroller = TextEditingController();
  var _addingTagcontroller= TextEditingController();
  bool _paintValue = false;

  Widget _starIcon(int index, String name) {
    paint = mapOfPaint[name];
    if(paint==false){
      return IconButton(
        icon: Icon(Icons.star),
        color: Colors.grey,
        onPressed: () {
          setState(() {
            paint = true;
            mapOfPaint[name] = paint;
          });
        },
      );
    }
    else{
      return IconButton(
        icon: Icon(Icons.star),
        color: Colors.yellow,
        onPressed: () {
          setState(() {
            paint = false;
            mapOfPaint[name] = paint;
          });
        },
    );
    }
  }
  Widget _buildListView() {
    if(_itemList.length==0){
      return Expanded(
        child: Container(
          child: Center(
            child: Text(
              "Please Add Some Function",
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      );
    }
    else{
      return Expanded(
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            _labelText = _itemList[index];
            _labelTags = mapOfTags[_labelText] ??= ["null"];
            _labelTag = _labelTags.join("/");
            return GestureDetector(
              onTap: () {
                setState(() {
                  fomulaName = _itemList[index];
                  nameOfFomula = mapOfNameOfFomula[fomulaName];
                  propeties = mapOfPropeties[fomulaName];
                  tags = mapOfTags[fomulaName] ??= ["null"];
                  tag = tags.join("/");
                  paint = mapOfPaint[fomulaName];
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => FomulaPrev()
                  ),
                );
              },
              child: Container(
                height: 70,
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey))
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                _labelText,
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 35,
                                  child: Text(
                                    "Tag:",
                                    style: TextStyle(fontSize: 12,color: Colors.grey),
                                  ),
                                ),
                                Container(
                                  width: 90,
                                  child: Text(
                                    _labelTag ??= "null",
                                    style: TextStyle(fontSize: 15,color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    _starIcon(index, _itemList[index]),
                    MaterialButton(
                      child: Icon(Icons.settings),
                      onPressed: () {
                        setState(() {
                          fomulaName = _itemList[index];
                          _addingFomulacontroller = TextEditingController(text: fomulaName);
                          _addingTagcontroller = TextEditingController(text: _labelTag ??= "null");
                          _nameValue = mapOfNameOfFomula[fomulaName];
                          _propetyValue = mapOfPropeties[fomulaName];
                          _boolValue = mapOfBool[fomulaName];
                          _paintValue = mapOfPaint[fomulaName];
                          _targetter = index;
                          _fieldCounts = 2;
                          _stateOfAdd = "true";
                        });
                      },
                    ),
                  ],
                ),
              ),
            );
          },
          itemCount: _itemList.length,
        ),
      );
    }
  }
  Widget _textFields() {
    if(_fieldCounts==1){
      return Expanded(
          child: TextField(
            enabled: true,
            decoration: InputDecoration(
              labelText: "add a fomula",
              hintText: "(only space, remove)"
            ),
            controller: _addingFomulacontroller,
          ),
        );
      }
      else{
        return Expanded(
        child: Row(
          children: <Widget>[
            Expanded( // 式追加テキストボックス
              flex: 1,
              child: TextField(
                enabled: true,
                decoration: InputDecoration(
                  labelText: "add a fomula",
                  hintText: "(only space, remove)",
                ),
                controller: _addingFomulacontroller,
              ),
            ),
            Expanded(
              flex: 1,
              child: TextField(
                enabled: true,
                decoration: InputDecoration(
                  labelText: "edit tag",
                  hintText: "(separate with '/')"
                ),
                controller: _addingTagcontroller,
              ),
            ),
          ],
        ),
      );
    }
  }
  MaterialButton _difineSaveOrChange(int index) {
    if(_stateOfAdd=="false"){
      return MaterialButton(
        height: 20,
        minWidth: 20,
        child: Icon(Icons.add),
        onPressed: () { // 式の追加
          _e = _addingFomulacontroller.text;
          setState(() {
            if(_e.trim()!="")
              _itemList.add(_e);
              mapOfNameOfFomula.addAll({_e: null});
              mapOfPropeties.addAll({_e: null});
              mapOfTags.addAll({_e: null});
              mapOfBool.addAll({_e: false});
              tag = mapOfTags[_e];
              mapOfPaint.addAll({_e: false});
              _addingFomulacontroller.text = "";
          });
        },
      );
    }
    else{
      return MaterialButton(
        height: 20,
        minWidth: 20,
        child: Icon(Icons.save),
        onPressed: () {
          setState(() {
              mapOfNameOfFomula.remove(fomulaName);
              mapOfPropeties.remove(fomulaName);
              mapOfTags.remove(fomulaName);
              mapOfBool.remove(fomulaName);
              mapOfPaint.remove(fomulaName);
              fomulaName = _addingFomulacontroller.text;
              _t = _addingTagcontroller.text;
              mapOfNameOfFomula.addAll({fomulaName: _nameValue});
              mapOfPropeties.addAll({fomulaName: _propetyValue});
              mapOfTags.addAll({fomulaName: _t.split("/")});
              mapOfBool.addAll({fomulaName: _boolValue});
              tags = mapOfTags[fomulaName] ??= ["null"];
              tag = tags.join("/");
              mapOfPaint.addAll({fomulaName: _paintValue});
              _itemList[index] = fomulaName;
              if(fomulaName.trim()=="" && paint==false){
                _itemList.remove(fomulaName);
                mapOfNameOfFomula.remove(fomulaName);
                mapOfPropeties.remove(fomulaName);
                mapOfTags.remove(fomulaName);
                mapOfBool.remove(fomulaName);
                mapOfPaint.remove(fomulaName);
              }
              if(fomulaName.trim()=="" && paint==true){
                _itemList[index] = _nameValue ??= "null";
              }
              tags = mapOfTags[fomulaName] ??= ["null"];
              if(tags.length==0){tags=["null"];} 
              tag = tags.join("/");
              _addingFomulacontroller.text = "";
              _addingTagcontroller.text = "";
              _fieldCounts = 1;
              _stateOfAdd = "false";
          });
        },
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(datailtitle),
      ),
      body: Column(
        children: <Widget>[
          _buildListView(), // リスト
          Container(
            decoration: BoxDecoration(
              border: Border(top: BorderSide(width: 1.0,color: Colors.grey)),
            ),
            child: Row(
              children: <Widget>[
                _textFields(),
                _difineSaveOrChange(_targetter), // ボタン
              ],
            ),
          ),
        ],
      ),
    );
  }
}



class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}
class _SearchState extends State<Search> {
  var _searchBarcontroller = TextEditingController();
  int _cache = 0;
  List _searchKeys = <String>[];
  List _results = <String>[];
  List _tagResults = <String>[];
  List _mothersKeys = <String>[];
  List _mothersTags = <String>[];
  String _labelText = " ";
  String _labelTag = " ";
  List _labelTags= [];

  void _search(String subj, String item) {if(mapOfitemList[subj].contains(item)){if(_results.contains(item)==false){_results.add(item);}}}
  Container _searchBar() {
    return Container(
      height: 62,
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              enabled: true,
              decoration: InputDecoration(
                labelText: "Search Fomula...",
                hintText: "(separate with space)",
              ),
              controller: _searchBarcontroller,
            ),
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              setState(() {
                _results = <String>[];
                _searchKeys = _searchBarcontroller.text.split(" ");
                _tagResults = <String>[];
                _mothersKeys = mapOfTags.keys.toList();
                _mothersTags = mapOfTags.values.toList();
              });
              for(int i=0; i<_searchKeys.length; i++){
                _search("Math", _searchKeys[i]);     // 式名検索 数学
                _search("Physics", _searchKeys[i]);  // 式名検索 物理
                _search("Chemical", _searchKeys[i]); // 式名検索 化学
                // タグ検索
                for(int n=0; n<mapOfTags.values.length; n++){
                  for(int a=0; a<mapOfTags.values.toList()[n].length; a++){
                    if(mapOfTags.values.toList()[n][a].contains(_searchKeys[i])){
                      _tagResults.add(_searchKeys[i]);
                    }
                  }
                }
              }
              for(int j=0; j<_tagResults.length; j++){
                for(int t=0; t<mapOfTags.values.length; t++){
                  _cache = 0;
                  if(_mothersTags[t].contains(_tagResults[j])){
                    _cache = _mothersTags.indexOf(_mothersTags[t]);
                    _cache==-1 ? _cache = 0 : _cache = _cache;
                    _mothersTags.remove(_mothersTags[_cache]);
                    _results.add(_mothersKeys[_cache]);
                    _mothersKeys.remove(_mothersKeys[_cache]);
                  }
                }
              }
            }
          ),
        ],
      ),
    );
  }
  Widget _starIcon(int index, String name) {
    paint = mapOfPaint[name];
    if(paint==false){
      return IconButton(
        icon: Icon(Icons.star),
        color: Colors.grey,
        onPressed: () {
          setState(() {
            paint = true;
            mapOfPaint[name] = paint;
          });
        },
      );
    }
    else{
      return IconButton(
        icon: Icon(Icons.star),
        color: Colors.yellow,
        onPressed: () {
          setState(() {
            paint = false;
            mapOfPaint[name] = paint;
          });
        },
      );
    }
  }
  Widget _resultsList() {
    if(_results.length==0){
      return Expanded(
        child: Container(
          child: Center(
            child: Text(
              "No result",
              style: TextStyle(
                fontSize: 25,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      );
    }
    else{
      return Expanded(
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            _labelText = _results[index];
            _labelTags = mapOfTags[_labelText];
            _labelTags = _labelTags ??= ["null"];
            _labelTag = _labelTags.join("/");
            return GestureDetector(
              onTap: () {
                setState(() {
                  fomulaName = _results[index];
                  nameOfFomula = mapOfNameOfFomula[fomulaName];
                  propeties = mapOfPropeties[fomulaName];
                  tags = mapOfTags[fomulaName];
                  tags = tags ??= ["null"];
                  tag = tags.join("/");
                  paint = mapOfPaint[fomulaName];
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => FomulaPrev()
                  ),
                );
              },
              child: Container(
                height: 70,
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey),),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                _labelText,
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 35,
                                  child: Text(
                                    "Tag:",
                                    style: TextStyle(fontSize: 12,color: Colors.grey),
                                  ),
                                ),
                                Container(
                                  width: 90,
                                  child: Text(
                                    _labelTag ??= "null",
                                    style: TextStyle(fontSize: 15,color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    _starIcon(index, _results[index]),
                  ],
                ),
              ),
            );
          },
          itemCount: _results.length,
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
      ),
      body: Column(
        children: <Widget>[
          _searchBar(),
          _resultsList(),
        ]
      ),
    );
  }
}
class FomulaPrev extends StatefulWidget {
  @override
  _FomulaPrevState createState() => _FomulaPrevState();
}
class _FomulaPrevState extends State<FomulaPrev> {
  String _propetyLabelState = "text";
  String _nameLabelState = "text";
  String _stateOfSaveButtonOfFomula = "set";
  String _stateOfSaveButtonOfPropety = "set";
  var _fomulaSavecontroller = TextEditingController(text: nameOfFomula);
  var _propetySavecontroller = TextEditingController(text: propeties);

  Widget _buildFomulaName() { // 式名の表示を切り替える
    if(_nameLabelState=="text"){
      return Expanded(
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            nameOfFomula ??= "value = null",
            style: TextStyle(fontSize: 25),
          ),
        ),
      );
    }
    else{
      return Expanded(
          child: TextField(
          enabled: true,
          keyboardType: TextInputType.multiline,
          maxLines: 2,
          decoration: InputDecoration(
            labelText: "Fomula Body",
          ),
          controller: _fomulaSavecontroller,
        ),
      );
    }
  }
  MaterialButton _buildSaveButtonOfFomula() { // 式名横のボタン切り替える
    if(_stateOfSaveButtonOfFomula=="set"){
      return MaterialButton(
        height: 40,
        minWidth: 40,
        child: Icon(Icons.settings),
        onPressed: () {
          setState(() {
            _nameLabelState = "form";
            _stateOfSaveButtonOfFomula = "save";
          });
        },
      );
    }
    else{
      return MaterialButton(
        height: 40,
        minWidth: 40,
        child: Icon(Icons.save),
        onPressed: () {
          setState(() {
            nameOfFomula = _fomulaSavecontroller.text;
            mapOfNameOfFomula[fomulaName] = nameOfFomula;
            _nameLabelState = "text";
            _stateOfSaveButtonOfFomula = "set";
          });
        },
      );
    }
  }
  Widget _buildPropetyField() { // プロパティの表示を切り替える
    if(_propetyLabelState=="text"){
      return Expanded(
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            propeties ??= "value = null",
            style: TextStyle(fontSize: 20,),
          ),
        ),
      );
    }
    else{
      return Expanded(
        child: TextField(
          enabled: true,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          decoration: InputDecoration(
            labelText: "Fomula Explain",
          ),
          controller: _propetySavecontroller,
        )
      );
    }
  }
  MaterialButton _buildSaveButtonOfPropety() { // プロパティの横のボタンを切り替える
    if(_stateOfSaveButtonOfPropety=="set"){
      return MaterialButton(
        height: 40,
        minWidth: 40,
        child: Icon(Icons.settings),
        onPressed: () {
          setState(() {
            _propetyLabelState = "form";
            _stateOfSaveButtonOfPropety = "save";
          });
        },
      );
    }
    else{
      return MaterialButton(
        height: 40,
        minWidth: 40,
        child: Icon(Icons.save),
        onPressed: () {
          setState(() {
            propeties = _propetySavecontroller.text;
            mapOfPropeties[fomulaName] = propeties;
            _propetyLabelState = "text";
            _stateOfSaveButtonOfPropety = "set";
          });
        },
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(fomulaName ??= "null title"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              height: 50,
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1.0,
                    color: Colors.grey,
                  ),
                ),
              ),
              child: Row(
                children: <Widget>[
                  _buildFomulaName(),
                  _buildSaveButtonOfFomula(),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1.0,
                    color: Colors.grey,
                  ),
                ),
              ),
              child: Row(
                children: <Widget>[
                  _buildPropetyField(),
                  _buildSaveButtonOfPropety(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}