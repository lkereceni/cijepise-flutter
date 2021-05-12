import 'package:flutter/material.dart';
import 'package:cijepise/utilities/constants.dart';

class InputContainer extends StatelessWidget {
  final String hintText;
  final double width;
  final bool obscureText;

  InputContainer({@required this.hintText, @required this.width, @required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50.0),
      ),
      width: width,
      height: 50.0,
      child: TextField(
        obscureText: obscureText,
        style: TextStyle(
          color: Color(kInputTextColor),
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(left: 14.0),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Color(kHintTextColor),
            fontFamily: 'UniSans',
          ),
        ),
      ),
    );
  }
}
