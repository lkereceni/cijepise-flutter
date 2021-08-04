import 'package:flutter/material.dart';
import 'package:cijepise/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppointmentContainerIcon extends StatelessWidget {
  final String iconAsset;
  final String label;
  final Color iconColor;

  AppointmentContainerIcon({
    @required this.iconAsset,
    @required this.label,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(kDefaultPadding),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconAsset,
              color: iconColor,
              height: 100.0,
              width: 100.0,
            ),
            SizedBox(height: kDefaultPadding),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: kInputTextColor,
                fontFamily: 'UniSans',
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
