import 'package:flutter/material.dart';

ListTile _drawerTile(var context, String title, String pageRaute, icon) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(icon),
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.blue[600],
            )
          ),
        ),
      ],
    ),
    onTap: () {
      Navigator.pushNamed(
        context,
        pageRaute,
      );
    },
  );
}
Drawer drawer(var context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Text("Fomula Bank", style: TextStyle(
            fontSize: 30,
            color: Theme.of(context).primaryTextTheme.title.color,
          )),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
        ),
        _drawerTile(context, "Home", "/home", Icons.home),
        _drawerTile(context, "Settings", "/settings", Icons.settings),
      ],
    ),
  );
}

Border bottomBorder() {
  return Border(bottom: BorderSide(color: Colors.grey, width: 1.0));
}