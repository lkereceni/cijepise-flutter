import 'package:flutter/material.dart';
import 'package:cijepise/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Components
import 'package:cijepise/components/rounded_button.dart';
import 'package:cijepise/components/input_container.dart';

//Screens
import 'package:cijepise/screens/home_screen.dart';

//Services
import 'package:cijepise/services/database.dart';

class LoginScreen extends StatefulWidget {
  static const id = 'loginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController oibController = new TextEditingController();
  TextEditingController lozinkaController = new TextEditingController();

  Future<void> setPrefs(String oib) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('oib', oib);
  }

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
                  controller: oibController,
                ),
              ),
              Positioned(
                top: 350.0,
                child: InputContainer(
                  hintText: 'Lozinka',
                  width: 220.0,
                  obscureText: true,
                  controller: lozinkaController,
                ),
              ),
              Positioned(
                bottom: 220.0,
                child: RoundedButton(
                  text: 'Prijava',
                  onClick: () async {
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    if (oibController.text == '') {
                      Fluttertoast.showToast(
                        msg: 'Morate upisati vaš OIB',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                      );
                    } else if (oibController.text.length != 11) {
                      Fluttertoast.showToast(
                        msg: 'OIB ne smije imati više ili manje od 11 brojeva',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                      );
                    } else if (oibController.text
                        .contains(RegExp(r'[a-zA-Z]'))) {
                      Fluttertoast.showToast(
                        msg: 'OIB ne smije sadržavati slova',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                      );
                    } else {
                      Database.getUserLogin(http.Client(), oibController.text)
                          .then((result) {
                        if (result == null) {
                          Fluttertoast.showToast(
                            msg: 'Molimo vas da se registrirate',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                          );
                        } else if (lozinkaController.text !=
                            result[0]['lozinka']) {
                          Fluttertoast.showToast(
                            msg: 'Upisali ste pogrešnu lozinku',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                          );
                        } else {
                          Database.getUser(http.Client(), oibController.text)
                              .then((result) {
                            prefs.setString('id', result[0].id);
                            prefs.setString('ime', result[0].ime);
                            prefs.setString('prezime', result[0].prezime);
                            prefs.setString('oib', result[0].oib);
                            prefs.setString('adresa', result[0].adresa);
                            prefs.setString('grad', result[0].grad);
                            prefs.setString('zupanija', result[0].zupanija);
                            prefs.setString(
                                'datumRodenja', result[0].datumRodenja);
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()),
                          );
                        }
                      });
                    }
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
