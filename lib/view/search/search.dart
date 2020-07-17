import 'package:flutter/material.dart';

import '../home/home.dart';
import '../datail/detail.dart';
import '../widgets/drawer.dart';
import '../../data_manager_class/subject.dart';
import '../../data_manager_class/formula.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late List<Subject> subjectList;
  late List<String> searchKeys;
  List result = [];

  List search() {
    List _result = [];
    subjectList.forEach((subject) {
      searchKeys.forEach((key) {
        for (formula formula in subject.formulaList) {
          if (key == formula.name) {
            _result.add(formula);
            continue;
          }
          if (formula.tagList.contains(key)) _result.add(formula);
        }
      });
    });
    return _result;
  }

  Widget searchedResultListView() {
    if (result.length == 0) {
      return Text("検索結果は一つもありませんでした");
    } else {
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          formula formula = result[index];
          Color color = formula.liked ? Colors.yellow : Colors.grey;
          return Container(
            child: ListTile(
              title: Text("${formula.name}"),
              trailing: IconButton(
                color: color,
                onPressed: () {
                  formula.changeLike(!formula.liked);
                  setState(() {
                    color = formula.liked ? Colors.yellow : Colors.grey;
                  });
                },
                icon: Icon(Icons.star),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute<Widget>(
                    builder: (BuildContext context) => Home()));
              },
            ),
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
          );
        },
        itemCount: result.length,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController();
    return Scaffold(
      drawer: GeneralDrawer(),
      appBar: AppBar(
        title: Text("全体検索"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: EdgeInsets.all(4.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration.collapsed(
                            hintText: "Search your formula"),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        searchKeys = controller.text.split(" ");
                        setState(() {
                          result = search();
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
          ),
          FutureBuilder(
              future: SubjectPrefarence.getSubjectList(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Subject>> snapshot) {
                if (!snapshot.hasData) {
                  return Text("データがありません");
                } else {
                  subjectList = snapshot.data;
                  return Expanded(
                    child: searchedResultListView(),
                  );
                }
              }),
        ],
      ),
    );
  }
}
