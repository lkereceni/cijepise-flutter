import 'package:cijepise/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

//Components
import 'package:cijepise/components/appointment_container.dart';

class AppointmentScreen extends StatefulWidget {
  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Stack(
              fit: StackFit.loose,
              children: [
                Positioned(
                  top: 2.0,
                  left: -10.0,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Color(kDarkBlueColor),
                      size: 36.0,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Positioned(
                  top: 60.0,
                  child: Padding(
                    padding: EdgeInsets.only(left: 8.0, top: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Narudžba',
                          style: TextStyle(
                            fontFamily: 'UniSans',
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                        Text(
                          'Izaberite vrstu narudžbe',
                          style: TextStyle(
                            fontFamily: 'UniSans',
                            fontSize: 20.0,
                            letterSpacing: 1.5,
                            color: Color(kInputTextColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 200.0,
                  left: 0.0,
                  child: AppointmentContainer(
                    padding: EdgeInsets.only(left: 8.0),
                    iconAsset: 'assets/icons/syringe_1.svg',
                    label: 'COVID-19 cjepivo\n(prva doza)',
                  ),
                ),
                Positioned(
                  top: 200.0,
                  right: 0.0,
                  child: AppointmentContainer(
                    padding: EdgeInsets.only(right: 8.0),
                    iconAsset: 'assets/icons/syringe_2.svg',
                    label: 'COVID-19 cjepivo\n(druga doza)',
                  ),
                ),
                Positioned(
                  top: 440.0,
                  left: 0.0,
                  child: AppointmentContainer(
                    padding: EdgeInsets.only(left: 8.0),
                    iconAsset: 'assets/icons/microscope.svg',
                    label: 'RT-PCR test',
                  ),
                ),
                Positioned(
                  top: 440.0,
                  right: 0.0,
                  child: Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Container(
                      height: 220.0,
                      width: 180.0,
                      decoration: BoxDecoration(
                        color: Color(kLightBlueColor),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/coronavirus.svg',
                                height: 100.0,
                                width: 100.0,
                                color: Color(kDarkBlueColor),
                              ),
                              SizedBox(height: 30.0),
                              Text(
                                'Brzi antigenski\ntest',
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
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
