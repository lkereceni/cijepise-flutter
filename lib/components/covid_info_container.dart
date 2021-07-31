import 'package:flutter/material.dart';
import 'package:cijepise/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CovidInfoContainer extends StatelessWidget {
  final String text;
  final String label;
  final String iconAsset;

  CovidInfoContainer({@required this.text, @required this.label, this.iconAsset});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(left: kDefaultPadding * 0.8, right: kDefaultPadding * 0.8),
      height: 90.0,
      width: size.width * 0.42,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          bottomLeft: Radius.circular(10.0),
          bottomRight: Radius.circular(10.0),
          topRight: Radius.circular(40.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(
                  color: kDarkGreyTextColor,
                  fontFamily: 'UniSans',
                  fontSize: 34.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  color: kHintTextColor,
                  fontFamily: 'UniSans',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SvgPicture.asset(
            iconAsset,
            color: kDarkGreyTextColor,
            width: 45.0,
            height: 45.0,
          ),
        ],
      ),
    );
  }
}
