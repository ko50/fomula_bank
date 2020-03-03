import 'package:flutter/material.dart';
import 'home/home.dart';
import 'datail/datail.dart';
import 'search/search.dart';
import 'preview/preview.dart';

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
      routes: <String, WidgetBuilder>{
        "/home": (BuildContext context) => Home(),
        "/datail": (BuildContext context) => Datail(),
        "/search": (BuildContext context) => Search(),
        "/preview": (BuildContext context) => Preview(),
      },
    );
  }
}