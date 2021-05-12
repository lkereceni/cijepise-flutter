import 'package:cijepise/utilities/constants.dart';
import 'package:flutter/material.dart';

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
        /*appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Color(kDarkBlueColor),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),*/
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
                  child: Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Container(
                      height: 200.0,
                      width: 180.0,
                      decoration: BoxDecoration(
                        color: Color(kLightBlueColor),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 200.0,
                  right: 0.0,
                  child: Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Container(
                      height: 200.0,
                      width: 180.0,
                      decoration: BoxDecoration(
                        color: Color(kLightBlueColor),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 420.0,
                  left: 0.0,
                  child: Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Container(
                      height: 200.0,
                      width: 180.0,
                      decoration: BoxDecoration(
                        color: Color(kLightBlueColor),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 420.0,
                  right: 0.0,
                  child: Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Container(
                      height: 200.0,
                      width: 180.0,
                      decoration: BoxDecoration(
                        color: Color(kLightBlueColor),
                        borderRadius: BorderRadius.circular(20.0),
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
