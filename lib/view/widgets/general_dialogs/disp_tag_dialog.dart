import 'package:flutter/material.dart';

import '../../../data_manager_class/tag.dart';
import '../tag_card.dart';

class DisplayTagDialog extends StatelessWidget {
  final TagList tagList;

  DisplayTagDialog({required this.tagList});

  @override
  Widget build(BuildContext context) {
    if (tagList.isEmpty()) {
      return Center(
        child: Text("この公式に登録されたタグがありません"),
      );
    } else {
      return AlertDialog(
        content: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            Tag tag = tagList[index];
            return TagCard(
              index: index,
              tag: tag,
            );
          },
          itemCount: tagList.length,
        ),
      );
    }
  }
}
