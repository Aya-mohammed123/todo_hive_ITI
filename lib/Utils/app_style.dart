import 'package:flutter/material.dart';

class AppStyle {
  static const primaryColor = Colors.blueGrey;
  static const secondryColor = Colors.grey;

  static const TextStyle appBar = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  static const TextStyle todoTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle completedTodoTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.lineThrough,
    color: secondryColor,
  );
}
