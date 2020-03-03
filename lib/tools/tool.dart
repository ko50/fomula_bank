import 'package:flutter/material.dart';

// デバイスの横の長さ取得
double getWidth(context) {
  final Size size = MediaQuery.of(context).size;
  return size.width;
}

// デバイスの縦の長さ取得
double getHeight(context) {
  final Size size = MediaQuery.of(context).size;
  return size.height;
}

// Container下部の線引き
BoxDecoration bottomBorder() => BoxDecoration(border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey),));