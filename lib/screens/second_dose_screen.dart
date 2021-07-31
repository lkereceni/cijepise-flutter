import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cijepise/services/database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cijepise/constants.dart';
import 'package:intl/intl.dart';

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
    sDatumRodenja = datumRodenjaDan + '.' + datumRodenjaMjesec + '.' + datumRodenjaGodina + '.';

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

      Database.getVaccineName(http.Client(), userOib).then((value) => vaccineName = value[0]['naziv_cjepiva']);
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
    if (vaccinationStatus == 'na čekanju' || vaccinationStatus == 'Na čekanju') {
      return kDarkBlueColor;
    } else if (vaccinationStatus == 'naručen' || vaccinationStatus == 'Naručen') {
      return kYellowColor;
    } else if (vaccinationStatus == 'cijepljen' || vaccinationStatus == 'Cijepljen') {
      return kGreenColor;
    } else {
      return Colors.black;
    }
  }

  Widget getStatus() {
    if (vaccinationStatus == 'na čekanju' || vaccinationStatus == 'Na čekanju') {
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
          Navigator.push(context, MaterialPageRoute(builder: (context) => DataChangeScreen()));
        },
      );
    } else if (vaccinationStatus == 'naručen' || vaccinationStatus == 'Naručen') {
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
          Navigator.push(context, MaterialPageRoute(builder: (context) => DataChangeScreen()));
        },
      );
    } else if (vaccinationStatus == 'cijepljen' || vaccinationStatus == 'Cijepljen') {
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
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: kDarkBlueColor,
            size: 28.0,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: Database.getUserVaccinationInfo(http.Client(), userOib),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data[0].drugaDozaDatum != null) {
              if (snapshot.data[0].drugaDozaDatum != null) {
                String drugaDozaDatumGodina = snapshot.data[0].drugaDozaDatum.substring(0, 4);
                String drugaDozaDatumMjesec = snapshot.data[0].drugaDozaDatum.substring(4, 6);
                String drugaDozaDatumDan = snapshot.data[0].drugaDozaDatum.substring(6, 8);
                sDrugaDozaDatum = drugaDozaDatumDan + '.' + drugaDozaDatumMjesec + '.' + drugaDozaDatumGodina + '.';
              } else {
                sDrugaDozaDatum = '-';
              }
              snapshot.data[0].vrstaCjepiva == null ? vaccineType = '-' : vaccineType = vaccineName;

              snapshot.data[0].drugaDozaStatus == null
                  ? vaccinationStatus = '-'
                  : vaccinationStatus = snapshot.data[0].drugaDozaStatus;
              return Padding(
                padding: EdgeInsets.symmetric(
                  vertical: kDefaultPadding,
                  horizontal: kDefaultPadding,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'COVID-19 cjepivo (druga doza)',
                        style: TextStyle(
                          color: kInputTextColor,
                          fontFamily: 'UniSans',
                          fontSize: 24.0,
                        ),
                      ),
                      SizedBox(height: kDefaultPadding),
                      Container(
                        height: 260.0,
                        width: size.width,
                        decoration: BoxDecoration(
                          color: kLightBlueColor,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(kDefaultPadding * 1.5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                vaccinationStatus == 'cijepljen' || vaccinationStatus == 'Cijepljen'
                                    ? 'Cijepili ste se sa\ndrugom dozom COVID-19 cjepiva.'
                                    : 'Naručeni ste za\ndrugu dozu COVID-19 cjepiva.',
                                style: TextStyle(
                                  color: kDarkGreyTextColor,
                                  fontSize: 18.0,
                                ),
                              ),
                              SizedBox(height: kDefaultPadding),
                              AppointmentInfoText(
                                label: 'Status:',
                                value: vaccinationStatus,
                                valueColor: getStatusColor(),
                              ),
                              SizedBox(height: kDefaultPadding),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  AppointmentInfoText(
                                    label: 'Cjepivo:',
                                    value: vaccineType,
                                    valueColor: kDarkBlueColor,
                                  ),
                                  AppointmentInfoText(
                                    label: 'Datum:',
                                    value: sDrugaDozaDatum,
                                    valueColor: kDarkBlueColor,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: kDefaultPadding * 2),
                      getStatus(),
                    ],
                  ),
                ),
              );
            } else {
              return Center(
                child: Text(
                  'Još niste naručeni za\ndrugu dozu cjepiva.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
