import 'package:flutter/material.dart';

//screens
import 'screens/welcome_screen.dart';

void main() => runApp(CijepiSeApp());

class CijepiSeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
      },
    );
  }
}
