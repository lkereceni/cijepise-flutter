import 'package:flutter/material.dart';
import 'package:cijepise/utilities/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

//Networking
import 'package:cijepise/services/networking.dart';
import 'package:http/http.dart' as http;

//Components
import 'package:cijepise/components/covid_info_container.dart';

//Models
import 'package:cijepise/models/covid_info.dart';

//Screens
import 'package:cijepise/screens/appointment_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Color(kLightBlueColor),
        body: SafeArea(
            child: FutureBuilder<List<CovidInfo>>(
          future: fetchCovidInfo(http.Client()),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              int newCases = snapshot.data.last.confirmed -
                  snapshot.data[snapshot.data.length - 2].confirmed;
              int deaths = snapshot.data.last.deaths -
                  snapshot.data[snapshot.data.length - 2].deaths;

              return Padding(
                padding: EdgeInsets.all(24.0),
                child: Stack(
                  children: [
                    Positioned(
                      top: 40.0,
                      left: 0.0,
                      child: Text(
                        'KORONAVIRUS',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontFamily: 'UniSans',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 60.0,
                      left: 0.0,
                      child: CovidInfoContainer(
                        text: newCases.toString(),
                        label: 'novi slučajevi',
                        iconAsset: 'assets/icons/coronavirus.svg',
                      ),
                    ),
                    Positioned(
                      top: 60.0,
                      right: 0.0,
                      child: CovidInfoContainer(
                        text: deaths.toString(),
                        label: 'umrli',
                        iconAsset: 'assets/icons/death.svg',
                      ),
                    ),
                    Positioned(
                      top: 180.0,
                      right: 0.0,
                      left: 0.0,
                      child: Container(
                        width: size.width,
                        height: 250.0,
                        decoration: BoxDecoration(
                          color: Color(kDarkBlueColor),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 24.0, bottom: 30.0),
                                  child: SvgPicture.asset(
                                    'assets/icons/coronavirus.svg',
                                    color: Color(kGreenColor),
                                    width: 100.0,
                                    height: 100.0,
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 60.0, top: 10.0),
                                        child: Text(
                                          'COVID-19',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'UniSans',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30.0,
                                            letterSpacing: 2,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 60.0),
                                        child: Text(
                                          'cijepljenje',
                                          style: TextStyle(
                                            color: Color(kGreenColor),
                                            fontSize: 26.0,
                                            fontFamily: 'UniSans',
                                            letterSpacing: 1.8,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 220.0,
                              height: 60,
                              child: ElevatedButton(
                                child: Text(
                                  'Naruči se',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: 'UniSans',
                                    letterSpacing: 1.5,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                  alignment: Alignment.center,
                                  elevation: MaterialStateProperty.all(0.0),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: Colors.white,
                                        width: 1,
                                        style: BorderStyle.solid,
                                      ),
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AppointmentScreen()),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 460.0,
                      left: 0.0,
                      child: Text(
                        'O COVID-19',
                        style: TextStyle(
                          fontFamily: 'UniSans',
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 480.0,
                      left: 0.0,
                      right: 0.0,
                      child: Column(
                        children: [
                          SizedBox(
                            width: size.width,
                            height: 70,
                            child: ElevatedButton(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(6.0),
                                    child: SvgPicture.asset(
                                      'assets/icons/info.svg',
                                      height: 60.0,
                                      width: 60.0,
                                    ),
                                  ),
                                  SizedBox(width: 24.0),
                                  Text(
                                    'Osnovne informacije',
                                    style: TextStyle(
                                      fontSize: 22.0,
                                      fontFamily: 'UniSans',
                                      letterSpacing: 1.5,
                                      fontWeight: FontWeight.bold,
                                      color: Color(kInputTextColor),
                                    ),
                                  ),
                                ],
                              ),
                              style: ButtonStyle(
                                alignment: Alignment.center,
                                elevation: MaterialStateProperty.all(0.0),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white),
                              ),
                              onPressed: () {},
                            ),
                          ),
                          SizedBox(height: 15.0),
                          SizedBox(
                            width: size.width,
                            height: 70,
                            child: ElevatedButton(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 16.0, right: 16.0),
                                    child: SvgPicture.asset(
                                      'assets/icons/microscope.svg',
                                      height: 40.0,
                                      width: 40.0,
                                    ),
                                  ),
                                  SizedBox(width: 24.0),
                                  Text(
                                    'Testiranje',
                                    style: TextStyle(
                                      fontSize: 22.0,
                                      fontFamily: 'UniSans',
                                      letterSpacing: 1.5,
                                      fontWeight: FontWeight.bold,
                                      color: Color(kInputTextColor),
                                    ),
                                  ),
                                ],
                              ),
                              style: ButtonStyle(
                                alignment: Alignment.center,
                                elevation: MaterialStateProperty.all(0.0),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white),
                              ),
                              onPressed: () {},
                            ),
                          ),
                          SizedBox(height: 15.0),
                          SizedBox(
                            width: size.width,
                            height: 70,
                            child: ElevatedButton(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(6.0),
                                    child: SvgPicture.asset(
                                      'assets/icons/mask.svg',
                                      color: Color(kDarkBlueColor),
                                    ),
                                  ),
                                  SizedBox(width: 24.0),
                                  Text(
                                    'Kako se zaštititi?',
                                    style: TextStyle(
                                      fontSize: 22.0,
                                      fontFamily: 'UniSans',
                                      letterSpacing: 1.5,
                                      fontWeight: FontWeight.bold,
                                      color: Color(kInputTextColor),
                                    ),
                                  ),
                                ],
                              ),
                              style: ButtonStyle(
                                alignment: Alignment.center,
                                elevation: MaterialStateProperty.all(0.0),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white),
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return Center(
              child: CircularProgressIndicator(backgroundColor: Colors.white),
            );
          },
        )));
  }
}
