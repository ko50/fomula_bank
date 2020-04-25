import './_exporter.dart';
import '../models/_exporter.dart';

class Preview extends StatefulWidget {
  final Fomula fomula;
  final Subject subject;

  Preview({this.fomula, this.subject});

  @override
  _PreviewState createState() => _PreviewState(fomula, subject);
}

class _PreviewState extends State<Preview> {
  Fomula fomula;
  Subject pearentSubject;

  _PreviewState(this.fomula, this.pearentSubject);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Displaying ${fomula.name} Detail"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () async{

        },
      ),
      body: Column(

      ),
    );
  }
}