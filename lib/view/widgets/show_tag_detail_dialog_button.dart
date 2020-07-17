import 'package:flutter/material.dart';

import '../../data_manager_class/tag.dart';

import './general_dialogs/disp_tag_dialog.dart';

class ShowTagDatailDialogButton extends StatelessWidget {
  final TagList tagList;

  ShowTagDatailDialogButton(this.tagList);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () async {
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => DisplayTagDialog(
            tagList: tagList,
          ),
        );
      },
    );
  }
}
