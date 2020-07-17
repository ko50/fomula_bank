import 'package:flutter/material.dart';

class GeneralDrawer extends StatelessWidget {
  Widget _drawerTile(var context, String title, String pageRaute, icon) {
    return Container(
        height: 65,
        padding: EdgeInsets.all(4.0),
        child: ListTile(
          title: Row(
            children: <Widget>[
              Icon(icon),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(title,
                    style: TextStyle(
                      color: Colors.blue[600],
                    )),
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
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 1.0, color: Colors.white))));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Padding(
              padding: EdgeInsets.only(top: 4.0),
              child: Text("formula Bank",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  )),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          _drawerTile(context, "Home", "/home", Icons.home),
          _drawerTile(context, "Search", "/search", Icons.search),
          _drawerTile(context, "Settings", "/settings", Icons.settings),
        ],
      ),
    );
  }
}
