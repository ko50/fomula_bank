import 'package:flutter/material.dart';

import '../../data_manager_class/tag.dart';

import '../widgets/tag_card.dart';

class TagListView extends StatelessWidget {
  final TagList tagList;

  TagListView({required this.tagList});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 600,
        width: 400,
        child: Column(children: <Widget>[
          Expanded(
              child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              Tag tag = tagList[index];
              return TagCard(
                index: index,
                tag: tag,
              );
            },
            itemCount: tagList.length,
          ))
        ]));
  }
}
