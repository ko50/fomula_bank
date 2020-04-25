import '.././_exporter.dart';
import '../../models/_exporter.dart';
import '../../tools/_exporter.dart';
import './_addfomula.dart';

class Preview extends StatefulWidget {
  final Subject subject;
  final List fomulaList;
  final int index;

  Preview({this.subject, this.fomulaList, this.index});

  @override
  _PreviewState createState() => _PreviewState(subject, fomulaList, index);
}
class _PreviewState extends State<Preview> {
  Subject subject;
  List fomulaList;
  int index;

  _PreviewState(this.subject, this.fomulaList, this.index);

  Widget fomulaListView() {
    if(fomulaList.length==0) {
      return Center(child: Text("公式が一つもありません"));
    }else{
      ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          Fomula fomula = fomulaList[index];
          Color color = fomula.liked ? Colors.yellow : Colors.grey;
          return Container(
            child: ListTile(
              title: Text("${fomula.name}"),
              subtitle: Text("${fomula.expression}\ntag: ${fomula.tagList}", style: TextStyle(fontSize: 8),),
              trailing: IconButton(
                color: color,
                onPressed: () {
                  fomula.changeLike(fomula.liked);
                  setState(() {
                    color = fomula.liked ? Colors.yellow : Colors.grey;
                  });
                },
                icon: Icon(Icons.star),
              ),
            ),
            decoration: BoxDecoration(border: Border(bottom: greyThinBorder())),
          );
        },
        itemCount: fomulaList.length,
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(context),
      appBar: AppBar(
        title: Text("Preview Fomulas in ${subject.name}"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => AddFomulaPage(index: index)
                ),
              );
            },
          ),
        ],
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