import 'package:cijepise/components/rounded_button.dart';
import 'package:cijepise/utilities/constants.dart';
import 'package:flutter/material.dart';

//Components
import 'package:cijepise/components/input_container.dart';

class RegisterScreen extends StatefulWidget {
  static const id = 'registerScreen';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                top: 100.0,
                child: Text(
                  'REGISTRACIJA',
                  style: TextStyle(
                    color: Color(kDarkBlueColor),
                    fontFamily: 'UniSans',
                    fontWeight: FontWeight.w600,
                    fontSize: 30.0,
                    letterSpacing: 2,
                  ),
                ),
              ),
              Positioned(
                top: 200.0,
                child: Row(
                  children: [
                    InputContainer(
                      hintText: 'Ime',
                      width: 170.0,
                      obscureText: false,
                    ),
                    SizedBox(width: 20.0),
                    InputContainer(
                      hintText: 'Prezime',
                      width: 170.0,
                      obscureText: false,
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 270.0,
                child: InputContainer(
                  hintText: 'Ulica i kućni broj',
                  width: 360.0,
                  obscureText: false,
                ),
              ),
              Positioned(
                top: 340.0,
                child: Row(
                  children: [
                    InputContainer(
                      hintText: 'Grad',
                      width: 170.0,
                      obscureText: false,
                    ),
                    SizedBox(width: 20.0),
                    InputContainer(
                      hintText: 'Županija',
                      width: 170.0,
                      obscureText: false,
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 410.0,
                child: Row(
                  children: [
                    InputContainer(
                      hintText: 'OIB',
                      width: 170.0,
                      obscureText: false,
                    ),
                    SizedBox(width: 20.0),
                    InputContainer(
                      hintText: 'Datum rođenja',
                      width: 170.0,
                      obscureText: false,
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 480.0,
                child: Row(
                  children: [
                    InputContainer(
                      hintText: 'Lozinka',
                      width: 170.0,
                      obscureText: true,
                    ),
                    SizedBox(width: 20.0),
                    InputContainer(
                      hintText: 'Ponovite lozinku',
                      width: 170.0,
                      obscureText: true,
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 630.0,
                child: RoundedButton(
                  text: 'Registracija',
                  onClick: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
