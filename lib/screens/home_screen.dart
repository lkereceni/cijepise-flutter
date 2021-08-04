import 'package:cijepise/screens/about/about_test_screen.dart';
import 'package:cijepise/screens/about/basic_info_screen.dart';
import 'package:cijepise/screens/about/preventing_screen.dart';
import 'package:flutter/material.dart';
import 'package:cijepise/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

//Networking
import 'package:cijepise/services/networking.dart';
import 'package:http/http.dart' as http;

//Components
import 'package:cijepise/components/covid_info_container.dart';

//Models
import 'package:cijepise/models/covid_info.dart';

//Screens
import 'appointment/appointment_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kLightBlueColor,
      body: SafeArea(
        child: FutureBuilder<List<CovidInfo>>(
          future: fetchCovidInfo(http.Client()),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              int newCases = snapshot.data.last.confirmed - snapshot.data[snapshot.data.length - 2].confirmed;
              int deaths = snapshot.data.last.deaths - snapshot.data[snapshot.data.length - 2].deaths;

              return Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(kDefaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'KORONAVIRUS',
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'UniSans',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CovidInfoContainer(
                              text: newCases.toString(),
                              label: 'novi slučajevi',
                              iconAsset: 'assets/icons/coronavirus.svg',
                            ),
                            CovidInfoContainer(
                              text: deaths.toString(),
                              label: 'umrli',
                              iconAsset: 'assets/icons/death.svg',
                            ),
                          ],
                        ),
                        SizedBox(height: 30.0),
                        Container(
                          width: size.width,
                          height: 280.0,
                          decoration: BoxDecoration(
                            color: kDarkBlueColor,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: kDefaultPadding * 1.8, right: kDefaultPadding * 1.8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/coronavirus.svg',
                                      width: 100.0,
                                      height: 100.0,
                                      color: kGreenColor,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'COVID-19',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'UniSans',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30.0,
                                            letterSpacing: 2,
                                          ),
                                        ),
                                        Text(
                                          'cijepljenje',
                                          style: TextStyle(
                                            color: kGreenColor,
                                            fontFamily: 'UniSans',
                                            fontSize: 26.0,
                                            letterSpacing: 1.8,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20.0),
                                SizedBox(
                                  width: 220.0,
                                  height: 60.0,
                                  child: TextButton(
                                    child: Text(
                                      'Naruči se',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'UniSans',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                        letterSpacing: 1.5,
                                      ),
                                    ),
                                    style: TextButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            color: Colors.white,
                                            width: 1,
                                            style: BorderStyle.solid,
                                          ),
                                          borderRadius: BorderRadius.circular(50.0),
                                        )),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AppointmentScreen(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 30.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'O COVID-19',
                              style: TextStyle(
                                fontFamily: 'UniSans',
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5.0),
                            SizedBox(
                              width: size.width,
                              height: 60.0,
                              child: ElevatedButton(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/info.svg',
                                      width: 55.0,
                                      height: 55.0,
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Osnovne informacije',
                                          style: TextStyle(
                                            color: kInputTextColor,
                                            fontFamily: 'UniSans',
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1.5,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      10.0,
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BasicInfoScreen(),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 20.0),
                            SizedBox(
                              width: size.width,
                              height: 60.0,
                              child: ElevatedButton(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/microscope.svg',
                                      width: 45.0,
                                      height: 45.0,
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Testiranje',
                                          style: TextStyle(
                                            color: kInputTextColor,
                                            fontFamily: 'UniSans',
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1.5,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      10.0,
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AboutTestScreen(),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 20.0),
                            SizedBox(
                              width: size.width,
                              height: 60.0,
                              child: ElevatedButton(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/mask.svg',
                                      color: kDarkBlueColor,
                                      width: 60.0,
                                      height: 60.0,
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Kako se zaštititi?',
                                          style: TextStyle(
                                            color: kInputTextColor,
                                            fontFamily: 'UniSans',
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1.5,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      10.0,
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PreventingScreen(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(kDefaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: size.width,
                          height: 280.0,
                          decoration: BoxDecoration(
                            color: kDarkBlueColor,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: kDefaultPadding * 1.8, right: kDefaultPadding * 1.8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/coronavirus.svg',
                                      width: 100.0,
                                      height: 100.0,
                                      color: kGreenColor,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'COVID-19',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'UniSans',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30.0,
                                            letterSpacing: 2,
                                          ),
                                        ),
                                        Text(
                                          'cijepljenje',
                                          style: TextStyle(
                                            color: kGreenColor,
                                            fontFamily: 'UniSans',
                                            fontSize: 26.0,
                                            letterSpacing: 1.8,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20.0),
                                SizedBox(
                                  width: 220.0,
                                  height: 60.0,
                                  child: TextButton(
                                    child: Text(
                                      'Naruči se',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'UniSans',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                        letterSpacing: 1.5,
                                      ),
                                    ),
                                    style: TextButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            color: Colors.white,
                                            width: 1,
                                            style: BorderStyle.solid,
                                          ),
                                          borderRadius: BorderRadius.circular(50.0),
                                        )),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AppointmentScreen(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 30.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'O COVID-19',
                              style: TextStyle(
                                fontFamily: 'UniSans',
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5.0),
                            SizedBox(
                              width: size.width,
                              height: 60.0,
                              child: ElevatedButton(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/info.svg',
                                      width: 55.0,
                                      height: 55.0,
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Osnovne informacije',
                                          style: TextStyle(
                                            color: kInputTextColor,
                                            fontFamily: 'UniSans',
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1.5,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      10.0,
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BasicInfoScreen(),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 20.0),
                            SizedBox(
                              width: size.width,
                              height: 60.0,
                              child: ElevatedButton(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/microscope.svg',
                                      width: 45.0,
                                      height: 45.0,
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Testiranje',
                                          style: TextStyle(
                                            color: kInputTextColor,
                                            fontFamily: 'UniSans',
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1.5,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      10.0,
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AboutTestScreen(),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 20.0),
                            SizedBox(
                              width: size.width,
                              height: 60.0,
                              child: ElevatedButton(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/mask.svg',
                                      color: kDarkBlueColor,
                                      width: 60.0,
                                      height: 60.0,
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Kako se zaštititi?',
                                          style: TextStyle(
                                            color: kInputTextColor,
                                            fontFamily: 'UniSans',
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1.5,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      10.0,
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PreventingScreen(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
            );
          },
        ),
      ),
    );
  }
}
