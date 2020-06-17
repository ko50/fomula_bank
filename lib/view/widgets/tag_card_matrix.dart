import 'package:flutter/material.dart';

import '../../data_manager_class/tag.dart';

import '../widgets/tag_card.dart';

import '../widgets/dialogs/confirm_delete_tag_dialog.dart';
import '../widgets/dialogs/input_tag_data_dialog.dart';

class TagCardMatrix extends StatefulWidget {
  final TagList tagList;

  TagCardMatrix(this.tagList);

  @override
  _TagCardMatrixState createState() => _TagCardMatrixState(tagList);
}
class _TagCardMatrixState extends State<TagCardMatrix> {
  TagList tagList;
  List<Widget> cardMatrix = [];

  _TagCardMatrixState(this.tagList);

  Future showAddNewTagDialog() async{
    Tag? newTag = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => InputTagDataDialog(),
    );
    if(newTag == null) return;
    setState(() {
      tagList.list.add(newTag);
    });
  }

  Future showConfirmDeleteTag(context, int index) async{
    bool? isDelete = await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => ConfirmDeleteTagDialog()
    );
    isDelete ??= false;
    if(isDelete) {
      setState(() {
        tagList.removeAt(index);
      });
    }
  }

  List<List<Tag>> constructTagCardMatrix() {
    List<List<Tag>> matrixOfTag = [[]];
    double width = 0;
    tagList.list.forEach((tag) {
      width += (tag.name.length * 8) + 10;
      // 横の長さが50以上になったら折り返しする
      if(width == 50) {
        matrixOfTag.last.add(tag);
        matrixOfTag.add([]);
        width = 0;
      }else if(width > 50) {
        matrixOfTag.add([tag]);
        width = 0;
      }else{
        matrixOfTag.last.add(tag);
      }
    });
    return matrixOfTag;
  }

  Future showEditTagDialog(context, int index, Tag tag) async{
    Tag? editedTag = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => InputTagDataDialog(
        name:  tag.name,
        color: tag.color,
      )
    );
    if(editedTag == null) return;
    setState(() {
      tagList[index] = editedTag;
    });
  }

  Row buildRowOfTagCard(List<Tag> rowOfTag) {
    List<TagCard> _rowOfTtagCard = rowOfTag.map((tag) {
      TagCard tc = TagCard(
        title: tag.name,
        color: tag.color,
      );
      return tc;
    }).toList();
    return Row(children: _rowOfTtagCard);
  }

  Widget buildTagCardMatrix(List<List<Tag>> matrix) {
    List<Widget> matrixOfTagCard = [];
    matrix.map((rowOfTag) => buildRowOfTagCard(rowOfTag));
    if(matrixOfTagCard.isEmpty) {
      return Text("タグはありません", style: TextStyle(color: Colors.grey));
    }else{
      return Column(children: matrixOfTagCard);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<List<Tag>> matrix = constructTagCardMatrix();
    double height = (matrix.length * 15).toDouble(); if(height==0) height = 15;
    return Container(
      height: height,
      child: Column(
        children: <Widget>[
          RaisedButton(
            child: Icon(Icons.add),
            onPressed: showAddNewTagDialog,
          ),
          buildTagCardMatrix(matrix),
        ],
      ),
    );
  }
}