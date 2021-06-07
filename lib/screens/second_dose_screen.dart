import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cijepise/services/database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cijepise/utilities/constants.dart';
import 'package:intl/intl.dart';

//Components
import 'package:cijepise/components/appointment_input_container.dart';
import 'package:cijepise/components/appointment_info_text.dart';
import 'package:cijepise/components/rounded_button.dart';

//Screens
import 'package:cijepise/screens/data_change_screen.dart';

String userId;
String userOib;
String userIme;
String userPrezime;
String userAdresa;
String userGrad;
String userZupanija;
String userDatumRodenja;

String vaccineType;
String vaccinationDate;
String vaccinationStatus;
String sDatumRodenja = '';
String sDrugaDozaDatum = '';
String vaccineName = '';

class SecondDoseScreen extends StatefulWidget {
  SecondDoseScreen({Key key}) : super(key: key);

  @override
  _SecondDoseScreenState createState() => _SecondDoseScreenState();
}

class _SecondDoseScreenState extends State<SecondDoseScreen> {
  //Controllers
  TextEditingController imeController = new TextEditingController(),
      prezimeController = new TextEditingController(),
      adresaController = new TextEditingController(),
      oibController = new TextEditingController(),
      datumRodenjaController = new TextEditingController();

  String selectedGradItem;
  String selectedZupanijaItem;

  Future getPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var obtainedId = prefs.getString('id');
    var obtainedOib = prefs.getString('oib');
    var obtainedIme = prefs.getString('ime');
    var obtainedPrezime = prefs.getString('prezime');
    var obtainedAdresa = prefs.getString('adresa');
    var obtainedGrad = prefs.getString('grad');
    var obtainedZupanija = prefs.getString('zupanija');
    var obtainedDatumRodenja = prefs.getString('datumRodenja');

    String datumRodenjaGodina = obtainedDatumRodenja.substring(0, 4);
    String datumRodenjaMjesec = obtainedDatumRodenja.substring(4, 6);
    String datumRodenjaDan = obtainedDatumRodenja.substring(6, 8);
    sDatumRodenja = datumRodenjaDan +
        '.' +
        datumRodenjaMjesec +
        '.' +
        datumRodenjaGodina +
        '.';

    setState(() {
      userId = obtainedId;
      userOib = obtainedOib;
      userIme = obtainedIme;
      userPrezime = obtainedPrezime;
      userAdresa = obtainedAdresa;
      userGrad = obtainedGrad;
      userZupanija = obtainedZupanija;
      userDatumRodenja = obtainedDatumRodenja;

      imeController.text = userIme;
      prezimeController.text = obtainedPrezime;
      adresaController.text = obtainedAdresa;
      oibController.text = obtainedOib;

      selectedGradItem = obtainedGrad;
      selectedZupanijaItem = obtainedZupanija;

      Database.getVaccineName(http.Client(), userOib)
          .then((value) => vaccineName = value[0]['naziv_cjepiva']);
    });
  }

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
        sDatumRodenja = formatter.format(selectedDate);
      });
    }
  }

  Color getStatusColor() {
    if (vaccinationStatus == 'na čekanju' ||
        vaccinationStatus == 'Na čekanju') {
      return Color(kDarkBlueColor);
    } else if (vaccinationStatus == 'naručen' ||
        vaccinationStatus == 'Naručen') {
      return Color(kYellowColor);
    } else if (vaccinationStatus == 'cijepljen' ||
        vaccinationStatus == 'Cijepljen') {
      return Color(kGreenColor);
    } else {
      return Colors.black;
    }
  }

  Widget getStatus() {
    if (vaccinationStatus == 'na čekanju' ||
        vaccinationStatus == 'Na čekanju') {
      return RoundedButton(
        text: 'Promijeni podatke',
        onClick: () async {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.clear();
          await Database.getUser(http.Client(), userOib).then((result) {
            prefs.setString('id', result[0].id);
            prefs.setString('oib', result[0].oib);
            prefs.setString('ime', result[0].ime);
            prefs.setString('prezime', result[0].prezime);
            prefs.setString('adresa', result[0].adresa);
            prefs.setString('grad', result[0].grad);
            prefs.setString('zupanija', result[0].zupanija);
            prefs.setString('datumRodenja', result[0].datumRodenja);
          });
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DataChangeScreen()));
        },
      );
    } else if (vaccinationStatus == 'naručen' ||
        vaccinationStatus == 'Naručen') {
      return RoundedButton(
        text: 'Promijeni podatke',
        onClick: () async {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.clear();
          await Database.getUser(http.Client(), userOib).then((result) {
            prefs.setString('id', result[0].id);
            prefs.setString('oib', result[0].oib);
            prefs.setString('ime', result[0].ime);
            prefs.setString('prezime', result[0].prezime);
            prefs.setString('adresa', result[0].adresa);
            prefs.setString('grad', result[0].grad);
            prefs.setString('zupanija', result[0].zupanija);
            prefs.setString('datumRodenja', result[0].datumRodenja);
          });
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DataChangeScreen()));
        },
      );
    } else if (vaccinationStatus == 'cijepljen' ||
        vaccinationStatus == 'Cijepljen') {
      return Container();
    } else {
      return Container();
    }
  }

  @override
  void initState() {
    getPrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FutureBuilder(
          future: Database.getUserVaccinationInfo(http.Client(), userOib),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data[0].drugaDozaDatum != null) {
              if (snapshot.data[0].drugaDozaDatum != null) {
                String drugaDozaDatumGodina =
                    snapshot.data[0].drugaDozaDatum.substring(0, 4);
                String drugaDozaDatumMjesec =
                    snapshot.data[0].drugaDozaDatum.substring(4, 6);
                String drugaDozaDatumDan =
                    snapshot.data[0].drugaDozaDatum.substring(6, 8);
                sDrugaDozaDatum = drugaDozaDatumDan +
                    '.' +
                    drugaDozaDatumMjesec +
                    '.' +
                    drugaDozaDatumGodina +
                    '.';
              } else {
                sDrugaDozaDatum = '-';
              }
              snapshot.data[0].vrstaCjepiva == null
                  ? vaccineType = '-'
                  : vaccineType = vaccineName;

              snapshot.data[0].drugaDozaStatus == null
                  ? vaccinationStatus = '-'
                  : vaccinationStatus = snapshot.data[0].drugaDozaStatus;
              return Padding(
                padding: EdgeInsets.all(24.0),
                child: Stack(
                  fit: StackFit.loose,
                  alignment: Alignment.center,
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
                        padding: EdgeInsets.only(left: 0.0, top: 8.0),
                        child: Text(
                          'COVID-19 cjepivo (druga doza)',
                          style: TextStyle(
                            fontFamily: 'UniSans',
                            fontSize: 24.0,
                            fontWeight: FontWeight.normal,
                            color: Color(kInputTextColor),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 140.0,
                      child: Container(
                        height: 250.0,
                        width: 370.0,
                        decoration: BoxDecoration(
                          color: Color(kLightBlueColor),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                vaccinationStatus == 'cijepljen' ||
                                        vaccinationStatus == 'Cijepljen'
                                    ? 'Cijepili ste se sa\ndrugom dozom COVID-19 cjepiva.'
                                    : 'Naručeni ste za\ndrugu dozu COVID-19 cjepiva',
                                style: TextStyle(
                                  color: Color(kDarkGreyFontColor),
                                  fontSize: 18.0,
                                ),
                              ),
                              SizedBox(height: 20.0),
                              AppointmentInfoText(
                                label: 'Status:',
                                value: vaccinationStatus,
                                valueColor: getStatusColor(),
                              ),
                              SizedBox(height: 20.0),
                              Row(
                                children: [
                                  AppointmentInfoText(
                                    label: 'Cjepivo:',
                                    value: vaccineType,
                                    valueColor: Color(kDarkBlueColor),
                                  ),
                                  SizedBox(width: 100.0),
                                  AppointmentInfoText(
                                    label: 'Datum:',
                                    value: sDrugaDozaDatum,
                                    valueColor: Color(kDarkBlueColor),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 500.0,
                      child: getStatus(),
                    ),
                  ],
                ),
              );
            } else {
              return Padding(
                padding: EdgeInsets.all(16.0),
                child: Stack(
                  fit: StackFit.loose,
                  alignment: Alignment.center,
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
                        padding: EdgeInsets.only(left: 0.0, top: 8.0),
                        child: Text(
                          'COVID-19 cjepivo (druga doza)',
                          style: TextStyle(
                            fontFamily: 'UniSans',
                            fontSize: 24.0,
                            fontWeight: FontWeight.normal,
                            color: Color(kInputTextColor),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 300.0,
                      child: Center(
                        child: Text(
                          'Molimo vas da se naručite\nza prvu dozu cjepiva.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
