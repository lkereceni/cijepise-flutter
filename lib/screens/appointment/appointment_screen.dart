import 'package:cijepise/constants.dart';
import 'package:flutter/material.dart';

//Widgets
import 'package:cijepise/components/appointment_container.dart';

//Screens
import 'package:cijepise/screens/appointment/first_dose_screen.dart';
import 'package:cijepise/screens/appointment/second_dose_screen.dart';
import 'package:cijepise/screens/appointment/antigenic_test_screen.dart';

import 'pcr_test_screen.dart';

class AppointmentScreen extends StatefulWidget {
  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: kDarkBlueColor,
            size: 28.0,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: kDefaultPadding, right: kDefaultPadding, top: kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Narudžba',
                style: TextStyle(
                  color: kDarkGreyTextColor,
                  fontFamily: 'UniSans',
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              Text(
                'Izaberite vrstu narudžbe',
                style: TextStyle(
                  color: kInputTextColor,
                  fontFamily: 'UniSans',
                  fontSize: 20.0,
                ),
              ),
              //SizedBox(height: kDefaultPadding),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 0),
                  child: Center(
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 10.0,
                      runSpacing: 15.0,
                      children: <Widget>[
                        AppointmentContainer(
                          iconAsset: 'assets/icons/syringe_1.svg',
                          label: 'COVID-19 cjepivo\n(prva doza)',
                          onTapScreen: FirstDoseScreen(),
                        ),
                        AppointmentContainer(
                          iconAsset: 'assets/icons/syringe_2.svg',
                          label: 'COVID-19 cjepivo\n(druga doza)',
                          onTapScreen: SecondDoseScreen(),
                        ),
                        AppointmentContainer(
                          iconAsset: 'assets/icons/microscope.svg',
                          label: 'RT-PCR test',
                          onTapScreen: PcrTestScreen(),
                        ),
                        AppointmentContainer(
                          iconAsset: 'assets/icons/coronavirus.svg',
                          iconColor: kDarkBlueColor,
                          label: 'Brzi antigenski test',
                          onTapScreen: AntigenicTestScreen(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
