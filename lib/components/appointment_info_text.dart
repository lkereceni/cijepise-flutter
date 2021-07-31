import 'package:flutter/material.dart';
import 'package:cijepise/constants.dart';

class AppointmentInfoText extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;

  AppointmentInfoText({@required this.label, @required this.value, @required this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: kDarkGreyTextColor,
            fontSize: 18.0,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 0.0),
          child: Text(
            value,
            style: TextStyle(
              color: valueColor,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
