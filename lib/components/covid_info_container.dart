import 'package:flutter/material.dart';
import 'package:cijepise/utilities/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CovidInfoContainer extends StatelessWidget {
  final String text;
  final String label;
  final String iconAsset;

  CovidInfoContainer({@required this.text, @required this.label, this.iconAsset});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.0,
      width: 170.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          bottomLeft: Radius.circular(10.0),
          bottomRight: Radius.circular(10.0),
          topRight: Radius.circular(40.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 16.0, top: 8.0),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      color: Color(kDarkGreyFontColor),
                      fontFamily: 'UniSans',
                      fontSize: 34.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    label,
                    style: TextStyle(
                      color: Color(kHintTextColor),
                      fontWeight: FontWeight.w500,
                      fontFamily: 'UniSans',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 20.0),
            Expanded(
              child: SvgPicture.asset(
                iconAsset,
                color: Color(kDarkGreyFontColor),
                width: 45.0,
                height: 45.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
