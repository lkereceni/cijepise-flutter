import 'package:flutter/material.dart';
import 'package:cijepise/constants.dart';
import 'package:cijepise/components/appointment_container_icon.dart';

class AppointmentContainer extends StatelessWidget {
  final String iconAsset;
  final String label;
  final Object onTapScreen;

  AppointmentContainer({
    @required this.iconAsset,
    @required this.label,
    this.onTapScreen,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => onTapScreen));
      },
      child: Container(
        height: 220.0,
        width: size.width / 2.4,
        decoration: BoxDecoration(
          color: kLightBlueColor,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: AppointmentContainerIcon(
          iconAsset: iconAsset,
          label: label,
        ),
      ),
    );
  }
}
