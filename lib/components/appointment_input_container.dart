import 'package:flutter/material.dart';
import 'package:cijepise/utilities/constants.dart';

class AppointmentInputContainer extends StatelessWidget {
  final String label;
  final double width;
  final TextEditingController controller;

  AppointmentInputContainer({@required this.label, @required this.width, @required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 24.0),
          child: Text(
            label,
            style: TextStyle(
              color: Color(kHintTextColor),
              fontSize: 14.0,
            ),
          ),
        ),
        SizedBox(height: 2.0),
        Container(
          decoration: BoxDecoration(
            color: Color(kLightBlueColor),
            borderRadius: BorderRadius.circular(50.0),
          ),
          width: width,
          height: 50.0,
          child: Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: TextField(
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.sentences,
              controller: controller,
              style: TextStyle(
                color: Color(kInputTextColor),
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 14.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
