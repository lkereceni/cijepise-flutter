import 'package:cijepise/components/rounded_button.dart';
import 'package:cijepise/screens/login_screen.dart';
import 'package:cijepise/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:device_info/device_info.dart';

//Components
import 'package:cijepise/components/input_container.dart';

//Services
import 'package:cijepise/services/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

String token;

class RegisterScreen extends StatefulWidget {
  static const id = 'registerScreen';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

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

  String selectedItemZupanija;
  String selectedItemGrad;
  String zupanijaQuery;

  bool dropdownGradoviDisabled = true;
  bool datePicked = false;

  DateTime selectedDate = DateTime.now();
  final DateFormat formatter = DateFormat('dd.MM.yyyy.');
  final DateFormat databaseFormatter = DateFormat('yyyyMMdd');

  Future<void> selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1915, 8),
      lastDate: DateTime(2022),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
        datePicked = true;
      });
    }
  }

  Future getPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String obtainedToken = prefs.getString('token');

    setState(() {
      token = obtainedToken;
    });
  }

  @override
  void initState() {
    super.initState();
    getPrefs();
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
                child: FutureBuilder(
                  future: Database.getZupanije(http.Client()),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return Center(child: CircularProgressIndicator());
                    return Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      width: 360.0,
                      height: 50.0,
                      child: Padding(
                        padding: EdgeInsets.only(left: 14.0, right: 8.0),
                        child: DropdownButton(
                          hint: Text(
                            'Županija',
                            style: TextStyle(
                              color: Color(kHintTextColor),
                            ),
                          ),
                          icon: Icon(
                            Icons.expand_more,
                            size: 24.0,
                          ),
                          underline: SizedBox(),
                          style: TextStyle(
                            color: Color(kInputTextColor),
                            fontFamily: 'UniSans',
                            fontSize: 16.0,
                          ),
                          items: snapshot.data
                              .map<DropdownMenuItem<String>>((item) {
                            return DropdownMenuItem<String>(
                              child: Text(item.nazivZupanije),
                              value: item.nazivZupanije,
                            );
                          }).toList(),
                          onChanged: (newVal) {
                            setState(() {
                              if (selectedItemGrad != null) {
                                selectedItemGrad = null;
                              }
                              selectedItemZupanija = newVal;
                              zupanijaQuery = newVal;
                              dropdownGradoviDisabled = false;
                            });
                          },
                          value: selectedItemZupanija,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                top: 410.0,
                child: FutureBuilder(
                  future: Database.gradoviJson(zupanijaQuery),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return Center(child: CircularProgressIndicator());
                    return Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      width: 360.0,
                      height: 50.0,
                      child: Padding(
                        padding: EdgeInsets.only(left: 14.0, right: 0.0),
                        child: DropdownButton(
                          hint: Text(
                            'Grad',
                            style: TextStyle(
                              color: Color(kHintTextColor),
                            ),
                          ),
                          icon: Expanded(
                            child: Icon(
                              Icons.expand_more,
                              size: 24.0,
                            ),
                          ),
                          underline: SizedBox(),
                          style: TextStyle(
                            color: Color(kInputTextColor),
                            fontFamily: 'UniSans',
                            fontSize: 16.0,
                          ),
                          items: snapshot.data
                              .map<DropdownMenuItem<String>>((item) {
                            return DropdownMenuItem<String>(
                              child: Text(item['mjesto']),
                              value: item['mjesto'],
                            );
                          }).toList(),
                          onChanged: (newVal) {
                            setState(() {
                              selectedItemGrad = newVal;
                            });
                          },
                          value: selectedItemGrad,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                top: 480.0,
                child: Row(
                  children: [
                    InputContainer(
                      hintText: 'OIB',
                      width: 170.0,
                      obscureText: false,
                      controller: oibController,
                    ),
                    SizedBox(width: 20.0),
                    SizedBox(
                      width: 170.0,
                      height: 50.0,
                      child: InkWell(
                        onTap: () {
                          selectDate(context);
                        },
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 14.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          child: !datePicked
                              ? Text(
                                  'Datum rođenja',
                                  style: TextStyle(
                                    color: Color(kHintTextColor),
                                    fontFamily: 'UniSans',
                                    fontSize: 16.0,
                                  ),
                                  textAlign: TextAlign.left,
                                )
                              : Text(
                                  formatter.format(selectedDate),
                                  style: TextStyle(
                                    color: Color(kInputTextColor),
                                    fontFamily: 'UniSans',
                                    fontSize: 16.0,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 550.0,
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
                top: 650.0,
                child: RoundedButton(
                  text: 'Registracija',
                  onClick: () {
                    if (imeController.text == '') {
                      Fluttertoast.showToast(
                        msg: 'Morate upisati vaše ime',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                      );
                    } else if (imeController.text
                        .contains(RegExp(r'[0-9!@#$%^&*(),.?":{}|<>]'))) {
                      Fluttertoast.showToast(
                        msg:
                            'Ime ne smije sadržavati brojeve ili specijalne znakove',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                      );
                    } else if (prezimeController.text == '') {
                      Fluttertoast.showToast(
                        msg: 'Morate upisati vaše prezime',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                      );
                    } else if (prezimeController.text
                        .contains(RegExp(r'[0-9!@#$%^&*(),.?":{}|<>]'))) {
                      Fluttertoast.showToast(
                        msg:
                            'Prezime ne smije sadržavati brojeve ili specijalne znakove',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                      );
                    } else if (adresaController.text == '') {
                      Fluttertoast.showToast(
                        msg: 'Morate upisati vašu adresu',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                      );
                    } else if (selectedItemZupanija == null) {
                      Fluttertoast.showToast(
                        msg: 'Morate odabrati vašu županiju',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                      );
                    } else if (selectedItemGrad == null) {
                      Fluttertoast.showToast(
                        msg: 'Morate odabrati vaš grad',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                      );
                    } else if (oibController.text == '') {
                      Fluttertoast.showToast(
                        msg: 'Morate upisati vaš OIB',
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
                    } else if (oibController.text.length != 11) {
                      Fluttertoast.showToast(
                        msg: 'OIB ne smije imati više ili manje od 11 brojeva',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                      );
                    } else if (lozinkaController.text == '') {
                      Fluttertoast.showToast(
                        msg: 'Morate upisati lozinku',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                      );
                    } else if (ponovljenaLozinkaController.text == '') {
                      Fluttertoast.showToast(
                        msg: 'Morate ponovno upisati lozinku',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                      );
                    } else if (ponovljenaLozinkaController.text !=
                        lozinkaController.text) {
                      Fluttertoast.showToast(
                        msg: 'Lozinke nisu iste',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                      );
                    } else if (oibController.text.isNotEmpty) {
                      Database.getOIB(http.Client()).then((result) {
                        if (result.contains(oibController.text)) {
                          Fluttertoast.showToast(
                            msg: 'Korisnik sa ovim OIB-om je već registriran',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                          );
                        } else {
                          Database.addUser(
                            imeController.text,
                            prezimeController.text,
                            adresaController.text,
                            selectedItemGrad,
                            selectedItemZupanija,
                            int.parse(oibController.text),
                            int.parse(databaseFormatter.format(selectedDate)),
                            lozinkaController.text,
                            token,
                          );

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
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
