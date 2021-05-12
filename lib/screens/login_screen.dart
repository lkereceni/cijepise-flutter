import 'package:flutter/material.dart';
import 'package:cijepise/utilities/constants.dart';

//Components
import 'package:cijepise/components/rounded_button.dart';
import 'package:cijepise/components/input_container.dart';

//Screens
import 'package:cijepise/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const id = 'loginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(kLightBlueColor),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Stack(
            fit: StackFit.loose,
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 250.0,
                child: InputContainer(
                  hintText: 'OIB',
                  width: 220.0,
                  obscureText: false,
                ),
              ),
              Positioned(
                top: 350.0,
                child: InputContainer(
                  hintText: 'Lozinka',
                  width: 220.0,
                  obscureText: true,
                ),
              ),
              Positioned(
                bottom: 220.0,
                child: RoundedButton(
                  text: 'Prijava',
                  onClick: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
