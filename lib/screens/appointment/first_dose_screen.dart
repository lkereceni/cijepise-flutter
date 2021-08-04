import 'dart:ui';

import 'package:cijepise/components/screen_title.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cijepise/services/database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cijepise/constants.dart';
import 'package:intl/intl.dart';

//Widgets
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
String sPrvaDozaDatum = '';
String vaccineName = '';

class FirstDoseScreen extends StatefulWidget {
  FirstDoseScreen({Key key}) : super(key: key);

  @override
  _FirstDoseScreenState createState() => _FirstDoseScreenState();
}

class _FirstDoseScreenState extends State<FirstDoseScreen> {
  //Controllers
  TextEditingController imeController = new TextEditingController(),
      prezimeController = new TextEditingController(),
      adresaController = new TextEditingController(),
      oibController = new TextEditingController(),
      datumRodenjaController = new TextEditingController();

  String selectedItemGrad;
  String selectedItemZupanija;

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

      selectedItemGrad = obtainedGrad;
      selectedItemZupanija = obtainedZupanija;

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
            if (snapshot.hasData) {
              if (snapshot.data[0].prvaDozaDatum != null) {
                String prvaDozaDatumGodina = snapshot.data[0].prvaDozaDatum.substring(0, 4);
                String prvaDozaDatumMjesec = snapshot.data[0].prvaDozaDatum.substring(4, 6);
                String prvaDozaDatumDan = snapshot.data[0].prvaDozaDatum.substring(6, 8);
                sPrvaDozaDatum = prvaDozaDatumDan + '.' + prvaDozaDatumMjesec + '.' + prvaDozaDatumGodina + '.';
              } else {
                sPrvaDozaDatum = '-';
              }
              snapshot.data[0].vrstaCjepiva == null ? vaccineType = '-' : vaccineType = vaccineName;

              snapshot.data[0].prvaDozaStatus == null
                  ? vaccinationStatus = '-'
                  : vaccinationStatus = snapshot.data[0].prvaDozaStatus;
              return Padding(
                padding: EdgeInsets.symmetric(
                  vertical: kDefaultPadding,
                  horizontal: kDefaultPadding,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ScreenTitle(
                        title: 'COVID-19 cjepivo (prva doza)',
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
                                    ? 'Cijepili ste se sa\nprvom dozom COVID-19 cjepiva.'
                                    : 'Naručeni ste za\nprvu dozu COVID-19 cjepiva.',
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
                                    value: sPrvaDozaDatum,
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
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: kDefaultPadding,
                    horizontal: kDefaultPadding,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ScreenTitle(
                          title: 'COVID-19 cjepivo (prva doza)',
                        ),
                        SizedBox(height: kDefaultPadding),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppointmentInputContainer(
                              label: 'Ime',
                              width: size.width * 0.4,
                              controller: imeController,
                            ),
                            AppointmentInputContainer(
                              label: 'Prezime',
                              width: size.width * 0.4,
                              controller: prezimeController,
                            ),
                          ],
                        ),
                        SizedBox(height: kDefaultPadding),
                        AppointmentInputContainer(
                          label: 'Ulica i kućni broj',
                          width: size.width,
                          controller: adresaController,
                        ),
                        SizedBox(height: kDefaultPadding),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: kDefaultPadding),
                              child: Text(
                                'Županija',
                                style: TextStyle(
                                  color: kHintTextColor,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                            SizedBox(height: 2.0),
                            FutureBuilder(
                              future: Database.getZupanije(http.Client()),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
                                return Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: kLightBlueColor,
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  width: size.width,
                                  height: 50.0,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                                    child: DropdownButton(
                                      isExpanded: true,
                                      hint: Text(
                                        'Županija',
                                        style: TextStyle(color: kHintTextColor),
                                      ),
                                      icon: Icon(
                                        Icons.expand_more,
                                        size: 24.0,
                                      ),
                                      underline: SizedBox(),
                                      style: TextStyle(
                                        color: kInputTextColor,
                                        fontFamily: 'UniSans',
                                        fontSize: 16.0,
                                      ),
                                      items: snapshot.data.map<DropdownMenuItem<String>>((item) {
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
                                        });
                                      },
                                      value: selectedItemZupanija,
                                    ),
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                        SizedBox(height: kDefaultPadding),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 24.0),
                              child: Text(
                                'Grad',
                                style: TextStyle(color: kHintTextColor, fontSize: 14.0),
                              ),
                            ),
                            SizedBox(height: 2.0),
                            FutureBuilder(
                              future: Database.gradoviJson(selectedItemZupanija),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
                                return Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: kLightBlueColor,
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  width: size.width,
                                  height: 50.0,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                                    child: DropdownButton(
                                      isExpanded: true,
                                      hint: Text(
                                        'Grad',
                                        style: TextStyle(
                                          color: kHintTextColor,
                                        ),
                                      ),
                                      icon: Icon(
                                        Icons.expand_more,
                                        size: 24.0,
                                      ),
                                      underline: SizedBox(),
                                      style: TextStyle(
                                        color: kInputTextColor,
                                        fontFamily: 'UniSans',
                                        fontSize: 16.0,
                                      ),
                                      items: snapshot.data.map<DropdownMenuItem<String>>((item) {
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
                          ],
                        ),
                        SizedBox(height: kDefaultPadding),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppointmentInputContainer(
                              label: 'OIB',
                              width: size.width * 0.4,
                              controller: oibController,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: kDefaultPadding),
                                  child: Text(
                                    'Datum rođenja',
                                    style: TextStyle(
                                      color: kHintTextColor,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 2.0),
                                SizedBox(
                                  width: size.width * 0.4,
                                  height: 50.0,
                                  child: InkWell(
                                    onTap: () {
                                      selectDate(context);
                                    },
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.only(left: kDefaultPadding),
                                      decoration: BoxDecoration(
                                        color: kLightBlueColor,
                                        borderRadius: BorderRadius.circular(50.0),
                                      ),
                                      child: Text(
                                        sDatumRodenja,
                                        style: TextStyle(
                                          color: kInputTextColor,
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
                          ],
                        ),
                        SizedBox(height: kDefaultPadding),
                        Padding(
                          padding: EdgeInsets.only(left: kDefaultPadding),
                          child: Text(
                            '*provjerite jesu li uneseni podaci ispravni',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                        SizedBox(height: kDefaultPadding),
                        RoundedButton(
                          text: 'Naruči se',
                          onClick: () {
                            selectedDate.year == DateTime.now().year
                                ? sDatumRodenja = userDatumRodenja
                                : sDatumRodenja = databaseFormatter.format(selectedDate);
                            Database.updateUser(
                              userId,
                              imeController.text,
                              prezimeController.text,
                              adresaController.text,
                              selectedItemGrad,
                              selectedItemZupanija,
                              int.parse(oibController.text),
                              int.parse(sDatumRodenja),
                            );
                            Database.addUserVaccination(oibController.text);
                            Navigator.pushReplacement(
                                context, MaterialPageRoute(builder: (context) => FirstDoseScreen()));
                          },
                        ),
                      ],
                    ),
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
