import 'package:flutter/material.dart';

Widget _drawerTile(var context, String title, String pageRaute, icon) {
  return Container(
    padding: EdgeInsets.all(8.0),
    child: ListTile(
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
    ),
    decoration: BoxDecoration(border: Border(bottom: greyThinBorder())),
  );
}
Drawer drawer(var context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 4.0),
                child: Text("Fomula Bank", style: TextStyle(
                  fontSize: 30,
                  color: Theme.of(context).primaryTextTheme.title.color,
                )),
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
        ),
        _drawerTile(context, "Home",     "/home",     Icons.home),
        _drawerTile(context, "Search",   "/search",   Icons.search),
        _drawerTile(context, "Settings", "/settings", Icons.settings),
      ],
    ),
  );
}

BorderSide greyThinBorder() {
  return BorderSide(color: Colors.grey, width: 1.0);
}