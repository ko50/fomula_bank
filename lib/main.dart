import 'package:flutter/material.dart';

import './components/home.dart';
import './components/settings.dart';

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
        '/settings': (BuildContext context) => Settings(),
      },
    );
  }
}