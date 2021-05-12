import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cijepise/utilities/constants.dart';

//Screens
import 'package:cijepise/screens/login_screen.dart';
import 'package:cijepise/screens/register_screen.dart';

//Components
import 'package:cijepise/components/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const id = 'welcomeScreen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(kLightBlueColor),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
            child: Stack(
              fit: StackFit.loose,
              alignment: Alignment.topCenter,
              children: [
                Positioned(
                  top: 100.0,
                  child: SvgPicture.asset(
                    'assets/images/welcome_screen_background.svg',
                    fit: BoxFit.fitWidth,
                    width: 300.0,
                    height: 300.0,
                  ),
                ),
                Positioned(
                  bottom: 180.0,
                  child: RoundedButton(
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
                ),
                Positioned(
                  bottom: 120.0,
                  child: TextButton(
                    child: Text(
                      'Registriraj se',
                      style: TextStyle(
                        color: Color(kDarkBlueColor),
                        fontSize: 20.0,
                        fontFamily: 'UniSans',
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.5,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterScreen(),
                        ),
                      );
                    },
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
