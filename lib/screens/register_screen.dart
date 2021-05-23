import 'package:cijepise/components/rounded_button.dart';
import 'package:cijepise/screens/login_screen.dart';
import 'package:cijepise/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//Components
import 'package:cijepise/components/input_container.dart';

//Services
import 'package:cijepise/services/database.dart';

class RegisterScreen extends StatefulWidget {
  static const id = 'registerScreen';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  //Controllers
  TextEditingController imeController = new TextEditingController(),
      prezimeController = new TextEditingController(),
      adresaController = new TextEditingController(),
      gradController = new TextEditingController(),
      zupanijaController = new TextEditingController(),
      oibController = new TextEditingController(),
      datumRodenjaController = new TextEditingController(),
      lozinkaController = new TextEditingController(),
      ponovljenaLozinkaController = new TextEditingController();

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
                      controller: imeController,
                    ),
                    SizedBox(width: 20.0),
                    InputContainer(
                      hintText: 'Prezime',
                      width: 170.0,
                      obscureText: false,
                      controller: prezimeController,
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
                  controller: adresaController,
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
                      controller: gradController,
                    ),
                    SizedBox(width: 20.0),
                    InputContainer(
                      hintText: 'Županija',
                      width: 170.0,
                      obscureText: false,
                      controller: zupanijaController,
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
                      controller: oibController,
                    ),
                    SizedBox(width: 20.0),
                    InputContainer(
                      hintText: 'Datum rođenja',
                      width: 170.0,
                      obscureText: false,
                      controller: datumRodenjaController,
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
                      controller: lozinkaController,
                    ),
                    SizedBox(width: 20.0),
                    InputContainer(
                      hintText: 'Ponovite lozinku',
                      width: 170.0,
                      obscureText: true,
                      controller: ponovljenaLozinkaController,
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 630.0,
                child: RoundedButton(
                  text: 'Registracija',
                  onClick: () {
                    Database.addUser(
                        imeController.text,
                        prezimeController.text,
                        adresaController.text,
                        gradController.text,
                        zupanijaController.text,
                        int.parse(oibController.text),
                        int.parse(datumRodenjaController.text),
                        lozinkaController.text);

                    //Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
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
