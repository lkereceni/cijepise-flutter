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
            if (snapshot.hasData) {
              if (snapshot.data[0].prvaDozaDatum != null) {
                String prvaDozaDatumGodina =
                    snapshot.data[0].prvaDozaDatum.substring(0, 4);
                String prvaDozaDatumMjesec =
                    snapshot.data[0].prvaDozaDatum.substring(4, 6);
                String prvaDozaDatumDan =
                    snapshot.data[0].prvaDozaDatum.substring(6, 8);
                sPrvaDozaDatum = prvaDozaDatumDan +
                    '.' +
                    prvaDozaDatumMjesec +
                    '.' +
                    prvaDozaDatumGodina +
                    '.';
              } else {
                sPrvaDozaDatum = '-';
              }
              snapshot.data[0].vrstaCjepiva == null
                  ? vaccineType = '-'
                  : vaccineType = vaccineName;

              snapshot.data[0].prvaDozaStatus == null
                  ? vaccinationStatus = '-'
                  : vaccinationStatus = snapshot.data[0].prvaDozaStatus;
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
                          'COVID-19 cjepivo (prva doza)',
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
                                    ? 'Cijepili ste se sa\nprvom dozom COVID-19 cjepiva.'
                                    : 'Naručeni ste za\nprvu dozu COVID-19 cjepiva',
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
                                    value: sPrvaDozaDatum,
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
                          'COVID-19 cjepivo (prva doza)',
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
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            AppointmentInputContainer(
                              label: 'Ime',
                              width: 170.0,
                              controller: imeController,
                            ),
                            SizedBox(width: 20.0),
                            AppointmentInputContainer(
                              label: 'Prezime',
                              width: 170.0,
                              controller: prezimeController,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 240.0,
                      child: AppointmentInputContainer(
                        label: 'Ulica i kućni broj',
                        width: 360.0,
                        controller: adresaController,
                      ),
                    ),
                    Positioned(
                      top: 330.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 24.0),
                            child: Text(
                              'Županija',
                              style: TextStyle(
                                  color: Color(kHintTextColor), fontSize: 14.0),
                            ),
                          ),
                          FutureBuilder(
                            future: Database.getZupanije(http.Client()),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData)
                                return Center(
                                    child: CircularProgressIndicator());
                              return Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Color(kLightBlueColor),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                width: 360.0,
                                height: 50.0,
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: 16.0, right: 8.0),
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
                                        if (selectedGradItem != null) {
                                          selectedGradItem = null;
                                        }
                                        selectedZupanijaItem = newVal;
                                        //zupanijaQuery = newVal;
                                      });
                                    },
                                    value: selectedZupanijaItem,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 420.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 24.0),
                            child: Text(
                              'Grad',
                              style: TextStyle(
                                  color: Color(kHintTextColor), fontSize: 14.0),
                            ),
                          ),
                          FutureBuilder(
                            future: Database.gradoviJson(selectedZupanijaItem),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData)
                                return Center(
                                    child: CircularProgressIndicator());
                              return Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Color(kLightBlueColor),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                width: 360.0,
                                height: 50.0,
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: 24.0, right: 0.0),
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
                                        selectedGradItem = newVal;
                                      });
                                    },
                                    value: selectedGradItem,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 510.0,
                      child: Row(
                        children: [
                          AppointmentInputContainer(
                            label: 'OIB',
                            width: 170.0,
                            controller: oibController,
                          ),
                          SizedBox(width: 20.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 24.0),
                                child: Text(
                                  'Datum rođenja',
                                  style: TextStyle(
                                    color: Color(kHintTextColor),
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
                              SizedBox(height: 2.0),
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
                                      color: Color(kLightBlueColor),
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    child: Text(
                                      sDatumRodenja,
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
                        ],
                      ),
                    ),
                    Positioned(
                      top: 600.0,
                      child: Padding(
                        padding: EdgeInsets.only(left: 24.0),
                        child: Text(
                          '*provjerite jesu li uneseni podaci ispravni',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 650.0,
                      child: RoundedButton(
                        text: 'Naruči se',
                        onClick: () {
                          selectedDate.year == DateTime.now().year
                              ? sDatumRodenja = userDatumRodenja
                              : sDatumRodenja =
                                  databaseFormatter.format(selectedDate);
                          Database.updateUser(
                            userId,
                            imeController.text,
                            prezimeController.text,
                            adresaController.text,
                            selectedGradItem,
                            selectedZupanijaItem,
                            int.parse(oibController.text),
                            int.parse(sDatumRodenja),
                          );
                          Database.addUserVaccination(oibController.text);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FirstDoseScreen()));
                        },
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
