import 'package:flutter/material.dart';

import '../../data_manager_class/tag.dart';

class TagCard extends StatelessWidget {
  final int index;
  final Tag tag;
  late final String title;
  late final Color color;

  TagCard({required this.index, required this.tag}) {
    this.title = tag.name;
    this.color = tag.color;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (title.length * 8 + 10).toDouble(),
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
          onTap: () {},
          onLongPress: () {},
        ),
      ),
    );
  }
}
