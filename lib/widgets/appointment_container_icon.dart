import 'package:flutter/material.dart';
import 'package:cijepise/utilities/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppointmentContainerIcon extends StatelessWidget {
  final String iconAsset;
  final String label;
  final Color iconColor;

  AppointmentContainerIcon({@required this.iconAsset, @required this.label, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24.0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconAsset,
              height: 100.0,
              width: 100.0,
            ),
            SizedBox(height: 25.0),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'UniSans',
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
                color: Color(kInputTextColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
