import 'package:cijepise/utilities/constants.dart';
import 'package:flutter/material.dart';

//screens
import 'screens/welcome_screen.dart';

void main() => runApp(CijepiSeApp());

class CijepiSeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Color(kDarkBlueColor),
        accentColor: Color(kLightBlueColor),
        fontFamily: 'UniSans',
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
      },
    );
  }
}
