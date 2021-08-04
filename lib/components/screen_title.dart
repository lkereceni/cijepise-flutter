import 'package:cijepise/constants.dart';
import 'package:flutter/material.dart';

class ScreenTitle extends StatelessWidget {
  const ScreenTitle({
    Key key,
    this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: kInputTextColor,
        fontFamily: 'UniSans',
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
