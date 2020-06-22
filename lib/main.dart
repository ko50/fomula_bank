import 'package:flutter/material.dart';

import './view/home/home.dart';
import './view/search/search.dart';
import './view/settings/settings.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Fomula Bank",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => Home(),
        '/search': (BuildContext context) => Search(),
        '/settings': (BuildContext context) => Settings(),
      },
    );
  }
}
