import 'package:cijepise/constants.dart';
import 'package:flutter/material.dart';

class AboutTitle extends StatelessWidget {
  const AboutTitle({
    Key key,
    @required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: kDarkBlueColor,
        fontFamily: 'UniSans',
        fontSize: 22.0,
      ),
    );
  }
}
