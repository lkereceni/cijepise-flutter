import 'package:flutter/material.dart';
import 'package:cijepise/constants.dart';

double width;

class RoundedButton extends StatelessWidget {
  final String text;
  final Function onClick;

  RoundedButton({this.text, @required this.onClick});

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width * .64,
      height: 70,
      child: ElevatedButton(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20.0,
            fontFamily: 'UniSans',
            letterSpacing: 1.5,
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(kDarkBlueColor),
          alignment: Alignment.center,
          elevation: MaterialStateProperty.all(0.0),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
          ),
        ),
        onPressed: onClick,
      ),
    );
  }
}
