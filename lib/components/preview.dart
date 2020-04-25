import './_exporter.dart';
import '../models/_exporter.dart';
import '../tools/_exporter.dart';

class Datail extends StatefulWidget {
  final Subject subject;
  final List fomulaList;

  Datail({this.subject, this.fomulaList});

  @override
  _DatailState createState() => _DatailState(subject, fomulaList);
}
class _DatailState extends State<Datail> {
  Subject subject;
  List fomulaList;

  _DatailState(this.subject, this.fomulaList);

  Widget fomulaListView() {
    if(fomulaList.length==0) {
      return Center(child: Text("公式が一つもありません"));
    }else{
      ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          Fomula fomula = fomulaList[index];
          Color color = fomula.liked ? Colors.yellow : Colors.grey;
          return ListTile(
            title: Text("${fomula.name}"),
            trailing: IconButton(
              color: color,
              onPressed: () {
                
              },
              icon: Icon(Icons.star),
            ),
          );
        },
        itemCount: fomulaList.length,
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Preview Fomulas in ${subject.name}"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: fomulaListView(),
          ),
        ],
      ),
    );
  }
}