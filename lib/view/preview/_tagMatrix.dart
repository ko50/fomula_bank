import 'package:flutter/material.dart';

import '../widgets/tagCard.dart';
import '../widgets/dialogs/confirmDeleteTagDialog.dart';
import '../widgets/dialogs/inputTagDataDialog.dart';
import '../../datamanageclass/tag.dart';

class TagMatrix extends StatefulWidget {
  final TagList tagList;

  TagMatrix(this.tagList);

  @override
  _TagMatrixState createState() => _TagMatrixState(tagList);
}
class _TagMatrixState extends State<TagMatrix> {
  TagList tagList;
  List<Widget> cardMatrix;

  _TagMatrixState(this.tagList);

  Future showConfirmDeleteTag(context, int index) async{
    bool isDelete = await showDialog(
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

  List<List> constructTagMatrix() {
    List<List> matrixOfTag = [[]];
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
    Tag editedTag = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => InputTagDataDialog(
        name:  tag.name,
        color: tag.color,
      )
    );
    if(editedTag == null) return;

    tagList.list[index] = editedTag;
  }

  Row buildRowOfTagCard(List rowOfTag) {
    rowOfTag.forEach((tag) => TagCard(
      title: tag.name,
      color: tag.color,
    ));
    return Row(children: rowOfTag);
  }

  Widget buildBody(List<List> matrix) {
    List<Widget> matrixOfTagCard = [];
    matrix.map((rowOfTag) => buildRowOfTagCard(rowOfTag));
    if(matrixOfTagCard.length == 0) {
      return Text("タグはありません", style: TextStyle(color: Colors.grey));
    }else{
      return Column(children: matrixOfTagCard);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<List> matrix = constructTagMatrix();
    double height = (matrix.length * 15).toDouble(); if(height==0) height = 15;
    return Container(
      height: height,
      child: buildBody(matrix),
    );
  }
}