import 'package:flutter/material.dart';

class TagCard extends StatelessWidget {
  final String title;
  final Color color;
  final Function onTap;
  final Function onLongPress;

  TagCard({this.title, this.color, this.onTap, this.onLongPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (title.length*8 + 10).toDouble(),
      child: Card(
        shadowColor: color,
        margin: EdgeInsets.all(8.0),
        child: GestureDetector(
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.radio_button_checked,
                  size: 13,
                  color: color,
                ),
              ),
              Text(
                title,
                style: TextStyle(fontSize: 8.0),
              )
            ],
          ),
          onTap: onTap,
          onLongPress: onLongPress,
        ),
      ),
    );
  }
}