// 
import 'package:flutter/material.dart';
import '../datail/datail.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}
class _SearchState extends State<Search> {
  var _searchBarcontroller = TextEditingController();
  int _cache = 0;
  List _searchKeys;
  List _results;
  List _tagResults;
  List _mothersKeys;
  List _mothersTags;
  String _labelText;
  String _labelTag;
  List _labelTags= [];

  void _search(String subj, String item) {if(formulaListMap[subj].contains(item)){if(_results.contains(item)==false){_results.add(item);}}}
  Container _searchBar() {
    return Container(
      height: 62,
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              enabled: true,
              decoration: InputDecoration(
                labelText: "Search formula...",
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
                _mothersKeys = tagMap.keys.toList();
                _mothersTags = tagMap.values.toList();
              });
              for(int i=0; i<_searchKeys.length; i++){
                _search("Math", _searchKeys[i]);     // 式名検索 数学
                _search("Physics", _searchKeys[i]);  // 式名検索 物理
                _search("Chemical", _searchKeys[i]); // 式名検索 化学
                // タグ検索
                for(int n=0; n<tagMap.values.length; n++){
                  for(int a=0; a<tagMap.values.toList()[n].length; a++){
                    if(tagMap.values.toList()[n][a].contains(_searchKeys[i])){
                      _tagResults.add(_searchKeys[i]);
                    }
                  }
                }
              }
              for(int j=0; j<_tagResults.length; j++){
                for(int t=0; t<tagMap.values.length; t++){
                  _cache = 0;
                  if(_mothersTags[t].contains(_tagResults[j])){
                    _cache = _mothersTags.indexOf(_mothersTags[t]);
                    if (_cache == -1){_cache = 0;}
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
    paint = componentsMap[name]["paint"];
    if(paint==false){
      return IconButton(
        icon: Icon(Icons.star),
        color: Colors.grey,
        onPressed: () {
          setState(() {
            paint = true;
            componentsMap[name]["paint"] = paint;
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
            componentsMap[name]["paint"] = paint;
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
            _labelTags = tagMap[_labelText] ??= ["null"];
            _labelTag = _labelTags.join("/");
            return GestureDetector(
              onTap: () {
                setState(() {
                  formulaName = _results[index];
                  tags = tagMap[formulaName];
                  tags = tags ??= ["null"];
                  body = componentsMap[formulaName]["body"];
                  propety = componentsMap[formulaName]["propety"];
                  paint = componentsMap[formulaName]["paint"];
                });
                Navigator.of(context).pushNamed("/search/preview");
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