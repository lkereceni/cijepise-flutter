import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cijepise/constants.dart';

//Screens
import 'package:cijepise/screens/login_screen.dart';
import 'package:cijepise/screens/register_screen.dart';

import 'package:cijepise/components/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const id = 'welcomeScreen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kLightBlueColor,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: kDefaultPadding,
              left: kDefaultPadding,
              right: kDefaultPadding,
            ),
            child: SvgPicture.asset(
              'assets/images/welcome_screen_background.svg',
              height: 500,
              width: size.width,
            ),
          ),
          RoundedButton(
            text: 'Prijavi se',
            onClick: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              );
            },
          ),
          TextButton(
            child: Text(
              'Registriraj se',
              style: TextStyle(
                color: kDarkBlueColor,
                fontFamily: 'UniSans',
                fontSize: 20,
                fontWeight: FontWeight.w400,
                letterSpacing: 1,
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
